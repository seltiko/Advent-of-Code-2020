
with recursive inputs as (
    select *
    from regexp_split_to_table(
--     from regexp_split_to_array(
$input$Tile 2311:
..##.#..#.
##..#.....
#...##..#.
####.#...#
##.##.###.
##...#.###
.#.#.#..##
..#....#..
###...#.#.
..###..###

Tile 1951:
#.##...##.
#.####...#
.....#..##
#...######
.##.#....#
.###.#####
###.##.##.
.###....#.
..#.#..#.#
#...##.#..

Tile 1171:
####...##.
#..##.#..#
##.#..#.#.
.###.####.
..###.####
.##....##.
.#...####.
#.##.####.
####..#...
.....##...

Tile 1427:
###.##.#..
.#..#.##..
.#.##.#..#
#.#.#.##.#
....#...##
...##..##.
...#.#####
.#.####.#.
..#..###.#
..##.#..#.

Tile 1489:
##.#.#....
..##...#..
.##..##...
..#...#...
#####...#.
#..#.#.#.#
...#.#.#..
##.#...##.
..##.##.##
###.##.#..

Tile 2473:
#....####.
#..#.##...
#.##..#...
######.#.#
.#...#.#.#
.#########
.###.#..#.
########.#
##...##.#.
..###.#.#.

Tile 2971:
..#.#....#
#...###...
#.#.###...
##.##..#..
.#####..##
.#..####.#
#..#.#..#.
..####.###
..#.#.###.
...#.#.#.#

Tile 2729:
...#.#.#.#
####.#....
..#.#.....
....#..#.#
.##..##.#.
.#.####...
####.#.#..
##.####...
##..#.##..
#.##...##.

Tile 3079:
#.#.#####.
.#..######
..#.......
######....
####.#..#.
.#...#.##.
#.#####.##
..#.###...
..#.......
..#.###...$input$, '\n\n')/* as said*/ WITH ORDINALITY as t(tile, id)
-- $input$0,3,6$input$, ',') WITH ORDINALITY as t(said, id)
)

,parsed as (
    select *,
    (regexp_match(tile,'\d+'))[1]::int as tilenum,
    regexp_replace(tile,'(.*)[^\:](\n)','','g') as bottom,
    (regexp_match(
            regexp_replace(tile, '(.*?:\n)', '', 'g'),
        '(.+?)\n'))[1] as top,
       regexp_replace(
       regexp_replace(
            regexp_replace(tile, '(.*?:\n)', '', 'g'),
        '\n.{9}','','g'),
           '^.{9}','') as rright,
       regexp_replace(
       regexp_replace(
            regexp_replace(tile, '(.*?:\n)', '', 'g'),
        '.{9}\n','','g'),
           '.{9}$','') as lleft
from inputs i
)
   --need to add reversals here
,rotates as (
    select p.id,
           gs.g as rotid,
           p.tilenum,
           case when gs.g = 1 then bottom
                when gs.g = 2 then lleft
                when gs.g = 3 then reverse(top)
                when gs.g = 4 then reverse(rright)
                when gs.g = 5 then reverse(bottom)
                when gs.g = 6 then reverse(lleft)
                when gs.g = 7 then rright
                when gs.g = 8 then top
            end as bottom,
           case when gs.g = 3 then reverse(bottom)
                when gs.g = 4 then reverse(lleft)
                when gs.g = 1 then top
                when gs.g = 2 then rright
                when gs.g = 5 then reverse(top)
                when gs.g = 6 then reverse(rright)
                when gs.g = 7 then lleft
                when gs.g = 8 then bottom
            end as top,
           case when gs.g = 2 then reverse(bottom)
                when gs.g = 3 then reverse(lleft)
                when gs.g = 4 then top
                when gs.g = 1 then rright
                when gs.g = 5 then lleft
                when gs.g = 6 then reverse(top)
                when gs.g = 7 then bottom
                when gs.g = 8 then reverse(rright)
            end as rright,
           case when gs.g = 4 then bottom
                when gs.g = 1 then lleft
                when gs.g = 2 then reverse(top)
                when gs.g = 3 then reverse(rright)
                when gs.g = 5 then rright
                when gs.g = 6 then reverse(bottom)
                when gs.g = 7 then top
                when gs.g = 8 then reverse(lleft)
            end as lleft

    from parsed p
    left join (select generate_series(1,8) as g) gs on true
)
,first_row(idused,rotused,tops,butts,rightward,bottomward) as(
select array[tilenum] as idsused,
       array[rotid] as rotused,
       array[top] as tops, --lol
       array[bottom] as butts, --lol
       rright as rightward,
       bottom as bottomward
from rotates r
/*where exists(
    select 1
    from rotates r9
    where r9.top = r.bottom
        and r9.id <> r.id
          )
    and exists(
    select 1
    from rotates r9
    where r9.lleft = r.rright
        and r9.id <> r.id
          )*/
union all
select idused||r2.tilenum,
       rotused||r2.rotid,
       tops||r2.top,
       butts||r2.bottom,
       r2.rright,
       r2.bottom
from first_row fr
inner join rotates r2 on r2.tilenum != all(fr.idused) and r2.lleft = fr.rightward
where 'yes'/*exists(
    select 1
    from rotates r9
    where r9.top = r2.bottom
        and r9.id <> r2.id
        and r9.tilenum != all(fr.idused)
          )*/
    and array_length(idused||r2.tilenum,1) <= 3
)

,dcorners as (
select distinct r.tilenum
from rotates r
left join rotates r2 on r2.id <> r.id and r2.top = r.bottom
left join rotates r3 on r3.id <> r.id and r3.rright = r.lleft
-- left join rotates r4 on r4.id <> r.id and r4.bottom = r.top
-- left join rotates r5 on r5.id <> r.id and r5.lleft = r.rright
where r2.id is null
    and r3.id is null
--     and r4.id is null
)
,part1 as(select round(exp(sum(ln(tilenum::numeric)))) as part1_answer
from dcorners)
-- select * from rotates where tilenum = 2971;

,combine_rows(idused,rotused,butts) as (
    select idused, rotused, butts
    from first_row fr
    where array_length(fr.idused, 1) = 3
    union all
    select fr.idused || fr2.idused,
           fr.rotused || fr2.rotused,
           fr2.butts
    from combine_rows fr
             inner join first_row fr2 on fr2.tops = fr.butts and not (fr2.idused && fr.idused)
    where 'yes'
      and array_length(fr2.idused, 1) = 3
)
select *
from combine_rows
where array_length(idused, 1) = 9
;

                               
                               
                               
with test as (
    select '..##.#..#.
##..#.....
#...##..#.
####.#...#
##.##.###.
##...#.###
.#.#.#..##
..#....#..
###...#.#.
..###..###' as t
)
,testt as (
    select t,
           regexp_split_to_table(t, '\n') as rowss
    from test
)
,testtt as (
    select *,
           regexp_split_to_table(rowss, '') as baseelement,
           row_number() over () as y
    from testt
)
,testttt as (
    select *, row_number() over (partition by y) as x
    from testtt
)
,testtttt as (
    select *
   , generate_series(1, 8) as rotid
/*       case when generate_series(1,8) = 1 then point(x,y)
        when generate_series(1,8) = 2 then point(x,y)*point(cos(radians(90)),sin(radians(90)))
        when generate_series(1,8) = 3 then point(x,y)*point(cos(radians(180)),sin(radians(180)))
        when generate_series(1,8) = 4 then point(x,y)*point(cos(radians(270)),sin(radians(270)))
        when generate_series(1,8) = 5 then point(-x,y)
        when generate_series(1,8) = 6 then point(-x,y)*point(cos(radians(90)),sin(radians(90)))
        when generate_series(1,8) = 7 then point(-x,y)*point(cos(radians(180)),sin(radians(180)))
        when generate_series(1,8) = 8 then point(-x,y)*point(cos(radians(270)),sin(radians(270)))
            end*/
/*       point(x,y)*point(cos(radians(90)),sin(radians(90))),
       point(x,y)*point(cos(radians(180)),sin(radians(180))),
       point(x,y)*point(cos(radians(270)),sin(radians(270))),
       point(-x,y),
       point(-x,y)*point(cos(radians(90)),sin(radians(90))),
       point(-x,y)*point(cos(radians(180)),sin(radians(180))),
       point(-x,y)*point(cos(radians(270)),sin(radians(270))),
       point(x,y)*/
    from testttt
    )
,final_i_hope as (
    select t,
           rotid,
           round((case
                      when rotid = 1 then point(x, y)
                      when rotid = 2 then point(x, y) * point(cos(radians(90)), sin(radians(90)))
                      when rotid = 3 then point(x, y) * point(cos(radians(180)), sin(radians(180)))
                      when rotid = 4 then point(x, y) * point(cos(radians(270)), sin(radians(270)))
                      when rotid = 5 then point(-x, y)
                      when rotid = 6 then point(-x, y) * point(cos(radians(90)), sin(radians(90)))
                      when rotid = 7 then point(-x, y) * point(cos(radians(180)), sin(radians(180)))
                      when rotid = 8 then point(-x, y) * point(cos(radians(270)), sin(radians(270)))
               end)[1]) as newy,
           array_to_string(array_agg(baseelement order by (case
                                                               when rotid = 1 then point(x, y)
                                                               when rotid = 2
                                                                   then point(x, y) * point(cos(radians(90)), sin(radians(90)))
                                                               when rotid = 3
                                                                   then point(x, y) * point(cos(radians(180)), sin(radians(180)))
                                                               when rotid = 4
                                                                   then point(x, y) * point(cos(radians(270)), sin(radians(270)))
                                                               when rotid = 5 then point(-x, y)
                                                               when rotid = 6
                                                                   then point(-x, y) * point(cos(radians(90)), sin(radians(90)))
                                                               when rotid = 7
                                                                   then point(-x, y) * point(cos(radians(180)), sin(radians(180)))
                                                               when rotid = 8
                                                                   then point(-x, y) * point(cos(radians(270)), sin(radians(270)))
               end)[0]), '') as newrowss
    from testtttt
    group by 1, 2, 3
)
select t,rotid,
       array_to_string(array_agg(newrowss order by newy),'
') as rotated_text
from final_i_hope
group by 1,2
;
