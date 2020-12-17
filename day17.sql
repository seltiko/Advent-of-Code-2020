with recursive inputs as (
    select *
    from regexp_split_to_table(
$input$##..#.#.
#####.##
#######.
#..#..#.
#.#...##
..#....#
....#..#
..##.#..$input$, '\n') WITH ORDINALITY as t(rowrow, rowid)
)

,parsed as (
    select *,0 as zid
    from inputs i
    left join lateral (
        select * from regexp_split_to_table(
                     (select rowrow from inputs where i.rowid = rowid), ''
             ) WITH ORDINALITY as c(state, colid)
        ) c on true
)
,next_step1 as(
select rowid,
       colid,
       zid
from (

         select generate_series(min(rowid) - 1,max(rowid) + 1) as rowid
         from parsed p
     )t
full outer join (
         select generate_series(min(colid) - 1,max(colid) + 1) as colid
         from parsed p
     )t2 on true
full outer join (
         select generate_series(min(zid) - 1,max(zid) + 1) as zid
         from parsed p
     )t3 on true
)
,rawparsed1 as(
select ns1.rowid,
       ns1.colid,
       ns1.zid,
       coalesce(p2.state,'.') as previous_state,
       count(case when p.state = '#' then 1 end) as num_nums,
       count(*),
       case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then '#'
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then '#'
            else '.' end as state,
       max(case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then 1
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then 1
            else 0 end) over(partition by ns1.rowid) as active_in_row,
       max(case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then 1
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then 1
            else 0 end) over(partition by ns1.colid) as active_in_col,
       max(case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then 1
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then 1
            else 0 end) over(partition by ns1.zid) as active_in_z
from next_step1 ns1
left join parsed p
    on (abs(p.colid - ns1.colid) <= 1
    and abs(p.rowid - ns1.rowid) <= 1
    and abs(p.zid - ns1.zid) <= 1 )
    and not(p.colid = ns1.colid and p.rowid = ns1.rowid and p.zid = ns1.zid)
left join parsed p2 on p2.colid = ns1.colid and p2.rowid = ns1.rowid and p2.zid = ns1.zid
group by 1,2,3,4
)
,bounds as(
select
--        *,
       max(case when active_in_row = 1 then rowid end) as max_active_row,
       min(case when active_in_row = 1 then rowid end) as min_active_row,
       max(case when active_in_col = 1 then colid end) as max_active_col,
       min(case when active_in_col = 1 then colid end) as min_active_col,
       max(case when active_in_z = 1 then zid end) as max_active_z,
       min(case when active_in_z = 1 then zid end) as min_active_z
from rawparsed1
)
,parsed2 as (
select p.*
from rawparsed1 p
inner join bounds b on p.rowid between min_active_row and max_active_row
        and p.colid between min_active_col and max_active_col
        and p.zid between min_active_z and max_active_z
)
,next_step2 as(
select rowid,
       colid,
       zid
from (

         select generate_series(min(rowid) - 1,max(rowid) + 1) as rowid
         from parsed2 p
     )t
full outer join (
         select generate_series(min(colid) - 1,max(colid) + 1) as colid
         from parsed2 p
     )t2 on true
full outer join (
         select generate_series(min(zid) - 1,max(zid) + 1) as zid
         from parsed2 p
     )t3 on true
)
,rawparsed2 as(
select ns1.rowid,
       ns1.colid,
       ns1.zid,
       coalesce(p2.state,'.') as previous_state,
       count(case when p.state = '#' then 1 end) as num_nums,
       count(*),
       case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then '#'
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then '#'
            else '.' end as state,
       max(case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then 1
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then 1
            else 0 end) over(partition by ns1.rowid) as active_in_row,
       max(case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then 1
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then 1
            else 0 end) over(partition by ns1.colid) as active_in_col,
       max(case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then 1
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then 1
            else 0 end) over(partition by ns1.zid) as active_in_z
from next_step2 ns1
left join parsed2 p
    on (abs(p.colid - ns1.colid) <= 1
    and abs(p.rowid - ns1.rowid) <= 1
    and abs(p.zid - ns1.zid) <= 1 )
    and not(p.colid = ns1.colid and p.rowid = ns1.rowid and p.zid = ns1.zid)
left join parsed2 p2 on p2.colid = ns1.colid and p2.rowid = ns1.rowid and p2.zid = ns1.zid
group by 1,2,3,4
)
,bounds2 as(
select
--        *,
       max(case when active_in_row = 1 then rowid end) as max_active_row,
       min(case when active_in_row = 1 then rowid end) as min_active_row,
       max(case when active_in_col = 1 then colid end) as max_active_col,
       min(case when active_in_col = 1 then colid end) as min_active_col,
       max(case when active_in_z = 1 then zid end) as max_active_z,
       min(case when active_in_z = 1 then zid end) as min_active_z
from rawparsed2
)
,parsed3 as (
select p.*
from rawparsed2 p
inner join bounds2 b on p.rowid between min_active_row and max_active_row
        and p.colid between min_active_col and max_active_col
        and p.zid between min_active_z and max_active_z
)
,next_step3 as(
select rowid,
       colid,
       zid
from (

         select generate_series(min(rowid) - 1,max(rowid) + 1) as rowid
         from parsed3 p
     )t
full outer join (
         select generate_series(min(colid) - 1,max(colid) + 1) as colid
         from parsed3 p
     )t2 on true
full outer join (
         select generate_series(min(zid) - 1,max(zid) + 1) as zid
         from parsed3 p
     )t3 on true
)
,rawparsed3 as(
select ns1.rowid,
       ns1.colid,
       ns1.zid,
       coalesce(p2.state,'.') as previous_state,
       count(case when p.state = '#' then 1 end) as num_nums,
       count(*),
       case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then '#'
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then '#'
            else '.' end as state,
       max(case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then 1
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then 1
            else 0 end) over(partition by ns1.rowid) as active_in_row,
       max(case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then 1
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then 1
            else 0 end) over(partition by ns1.colid) as active_in_col,
       max(case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then 1
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then 1
            else 0 end) over(partition by ns1.zid) as active_in_z
from next_step3 ns1
left join parsed3 p
    on (abs(p.colid - ns1.colid) <= 1
    and abs(p.rowid - ns1.rowid) <= 1
    and abs(p.zid - ns1.zid) <= 1 )
    and not(p.colid = ns1.colid and p.rowid = ns1.rowid and p.zid = ns1.zid)
left join parsed3 p2 on p2.colid = ns1.colid and p2.rowid = ns1.rowid and p2.zid = ns1.zid
group by 1,2,3,4
)
,bounds3 as(
select
--        *,
       max(case when active_in_row = 1 then rowid end) as max_active_row,
       min(case when active_in_row = 1 then rowid end) as min_active_row,
       max(case when active_in_col = 1 then colid end) as max_active_col,
       min(case when active_in_col = 1 then colid end) as min_active_col,
       max(case when active_in_z = 1 then zid end) as max_active_z,
       min(case when active_in_z = 1 then zid end) as min_active_z
from rawparsed3
)
,parsed4 as (
select p.*
from rawparsed3 p
inner join bounds3 b on p.rowid between min_active_row and max_active_row
        and p.colid between min_active_col and max_active_col
        and p.zid between min_active_z and max_active_z
)
,next_step4 as(
select rowid,
       colid,
       zid
from (

         select generate_series(min(rowid) - 1,max(rowid) + 1) as rowid
         from parsed4 p
     )t
full outer join (
         select generate_series(min(colid) - 1,max(colid) + 1) as colid
         from parsed4 p
     )t2 on true
full outer join (
         select generate_series(min(zid) - 1,max(zid) + 1) as zid
         from parsed4 p
     )t3 on true
)
,rawparsed4 as(
select ns1.rowid,
       ns1.colid,
       ns1.zid,
       coalesce(p2.state,'.') as previous_state,
       count(case when p.state = '#' then 1 end) as num_nums,
       count(*),
       case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then '#'
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then '#'
            else '.' end as state,
       max(case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then 1
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then 1
            else 0 end) over(partition by ns1.rowid) as active_in_row,
       max(case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then 1
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then 1
            else 0 end) over(partition by ns1.colid) as active_in_col,
       max(case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then 1
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then 1
            else 0 end) over(partition by ns1.zid) as active_in_z
from next_step4 ns1
left join parsed4 p
    on (abs(p.colid - ns1.colid) <= 1
    and abs(p.rowid - ns1.rowid) <= 1
    and abs(p.zid - ns1.zid) <= 1 )
    and not(p.colid = ns1.colid and p.rowid = ns1.rowid and p.zid = ns1.zid)
left join parsed4 p2 on p2.colid = ns1.colid and p2.rowid = ns1.rowid and p2.zid = ns1.zid
group by 1,2,3,4
)
,bounds4 as(
select
--        *,
       max(case when active_in_row = 1 then rowid end) as max_active_row,
       min(case when active_in_row = 1 then rowid end) as min_active_row,
       max(case when active_in_col = 1 then colid end) as max_active_col,
       min(case when active_in_col = 1 then colid end) as min_active_col,
       max(case when active_in_z = 1 then zid end) as max_active_z,
       min(case when active_in_z = 1 then zid end) as min_active_z
from rawparsed4
)
,parsed5 as (
select p.*
from rawparsed4 p
inner join bounds4 b on p.rowid between min_active_row and max_active_row
        and p.colid between min_active_col and max_active_col
        and p.zid between min_active_z and max_active_z
)

,next_step5 as(
select rowid,
       colid,
       zid
from (

         select generate_series(min(rowid) - 1,max(rowid) + 1) as rowid
         from parsed5 p
     )t
full outer join (
         select generate_series(min(colid) - 1,max(colid) + 1) as colid
         from parsed5 p
     )t2 on true
full outer join (
         select generate_series(min(zid) - 1,max(zid) + 1) as zid
         from parsed5 p
     )t3 on true
)
,rawparsed5 as(
select ns1.rowid,
       ns1.colid,
       ns1.zid,
       coalesce(p2.state,'.') as previous_state,
       count(case when p.state = '#' then 1 end) as num_nums,
       count(*),
       case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then '#'
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then '#'
            else '.' end as state,
       max(case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then 1
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then 1
            else 0 end) over(partition by ns1.rowid) as active_in_row,
       max(case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then 1
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then 1
            else 0 end) over(partition by ns1.colid) as active_in_col,
       max(case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then 1
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then 1
            else 0 end) over(partition by ns1.zid) as active_in_z
from next_step5 ns1
left join parsed5 p
    on (abs(p.colid - ns1.colid) <= 1
    and abs(p.rowid - ns1.rowid) <= 1
    and abs(p.zid - ns1.zid) <= 1 )
    and not(p.colid = ns1.colid and p.rowid = ns1.rowid and p.zid = ns1.zid)
left join parsed5 p2 on p2.colid = ns1.colid and p2.rowid = ns1.rowid and p2.zid = ns1.zid
group by 1,2,3,4
)
,bounds5 as(
select
--        *,
       max(case when active_in_row = 1 then rowid end) as max_active_row,
       min(case when active_in_row = 1 then rowid end) as min_active_row,
       max(case when active_in_col = 1 then colid end) as max_active_col,
       min(case when active_in_col = 1 then colid end) as min_active_col,
       max(case when active_in_z = 1 then zid end) as max_active_z,
       min(case when active_in_z = 1 then zid end) as min_active_z
from rawparsed5
)
,parsed6 as (
select p.*
from rawparsed5 p
inner join bounds5 b on p.rowid between min_active_row and max_active_row
        and p.colid between min_active_col and max_active_col
        and p.zid between min_active_z and max_active_z
)
--
,next_step6 as(
select rowid,
       colid,
       zid
from (

         select generate_series(min(rowid) - 1,max(rowid) + 1) as rowid
         from parsed6 p
     )t
full outer join (
         select generate_series(min(colid) - 1,max(colid) + 1) as colid
         from parsed6 p
     )t2 on true
full outer join (
         select generate_series(min(zid) - 1,max(zid) + 1) as zid
         from parsed6 p
     )t3 on true
)
,rawparsed6 as(
select ns1.rowid,
       ns1.colid,
       ns1.zid,
       coalesce(p2.state,'.') as previous_state,
       count(case when p.state = '#' then 1 end) as num_nums,
       count(*),
       case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then '#'
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then '#'
            else '.' end as state,
       max(case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then 1
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then 1
            else 0 end) over(partition by ns1.rowid) as active_in_row,
       max(case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then 1
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then 1
            else 0 end) over(partition by ns1.colid) as active_in_col,
       max(case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then 1
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then 1
            else 0 end) over(partition by ns1.zid) as active_in_z
from next_step6 ns1
left join parsed6 p
    on (abs(p.colid - ns1.colid) <= 1
    and abs(p.rowid - ns1.rowid) <= 1
    and abs(p.zid - ns1.zid) <= 1 )
    and not(p.colid = ns1.colid and p.rowid = ns1.rowid and p.zid = ns1.zid)
left join parsed6 p2 on p2.colid = ns1.colid and p2.rowid = ns1.rowid and p2.zid = ns1.zid
group by 1,2,3,4
)
,bounds6 as(
select
--        *,
       max(case when active_in_row = 1 then rowid end) as max_active_row,
       min(case when active_in_row = 1 then rowid end) as min_active_row,
       max(case when active_in_col = 1 then colid end) as max_active_col,
       min(case when active_in_col = 1 then colid end) as min_active_col,
       max(case when active_in_z = 1 then zid end) as max_active_z,
       min(case when active_in_z = 1 then zid end) as min_active_z
from rawparsed6
)
,parsed7 as (
select p.*
from rawparsed6 p
inner join bounds6 b on p.rowid between min_active_row and max_active_row
        and p.colid between min_active_col and max_active_col
        and p.zid between min_active_z and max_active_z
)


select 'part1',sum((state='#')::int) from parsed7
;

with recursive inputs as (
    select *
    from regexp_split_to_table(
$input$##..#.#.
#####.##
#######.
#..#..#.
#.#...##
..#....#
....#..#
..##.#..$input$, '\n') WITH ORDINALITY as t(rowrow, rowid)
)

,parsed as (
    select *,0 as zid,0 as wid
    from inputs i
    left join lateral (
        select * from regexp_split_to_table(
                     (select rowrow from inputs where i.rowid = rowid), ''
             ) WITH ORDINALITY as c(state, colid)
        ) c on true
)
,next_step1 as(
select rowid,
       colid,
       zid,
       wid
from (

         select generate_series(min(rowid) - 1,max(rowid) + 1) as rowid
         from parsed p
     )t
full outer join (
         select generate_series(min(colid) - 1,max(colid) + 1) as colid
         from parsed p
     )t2 on true
full outer join (
         select generate_series(min(zid) - 1,max(zid) + 1) as zid
         from parsed p
     )t3 on true
full outer join (
         select generate_series(min(wid) - 1,max(wid) + 1) as wid
         from parsed p
     )t4 on true
)
,rawparsed1 as(
select ns1.rowid,
       ns1.colid,
       ns1.zid,
       ns1.wid,
       coalesce(p2.state,'.') as previous_state,
       count(case when p.state = '#' then 1 end) as num_nums,
       count(*),
       case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then '#'
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then '#'
            else '.' end as state,
       max(case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then 1
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then 1
            else 0 end) over(partition by ns1.rowid) as active_in_row,
       max(case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then 1
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then 1
            else 0 end) over(partition by ns1.colid) as active_in_col,
       max(case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then 1
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then 1
            else 0 end) over(partition by ns1.zid) as active_in_z,
       max(case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then 1
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then 1
            else 0 end) over(partition by ns1.wid) as active_in_w
from next_step1 ns1
left join parsed p
    on (abs(p.colid - ns1.colid) <= 1
    and abs(p.rowid - ns1.rowid) <= 1
    and abs(p.zid - ns1.zid) <= 1
    and abs(p.wid - ns1.wid) <= 1 )
    and not(p.colid = ns1.colid and p.rowid = ns1.rowid and p.zid = ns1.zid and p.wid = ns1.wid)
left join parsed p2 on p2.colid = ns1.colid and p2.rowid = ns1.rowid and p2.zid = ns1.zid and p2.wid = ns1.wid
group by 1,2,3,4,5
)
,bounds as(
select
--        *,
       max(case when active_in_row = 1 then rowid end) as max_active_row,
       min(case when active_in_row = 1 then rowid end) as min_active_row,
       max(case when active_in_col = 1 then colid end) as max_active_col,
       min(case when active_in_col = 1 then colid end) as min_active_col,
       max(case when active_in_z = 1 then zid end) as max_active_z,
       min(case when active_in_z = 1 then zid end) as min_active_z,
       max(case when active_in_w = 1 then wid end) as max_active_w,
       min(case when active_in_w = 1 then wid end) as min_active_w
from rawparsed1
)
,parsed2 as (
select p.*
from rawparsed1 p
inner join bounds b on p.rowid between min_active_row and max_active_row
        and p.colid between min_active_col and max_active_col
        and p.zid between min_active_z and max_active_z
        and p.wid between min_active_w and max_active_w
)
,next_step2 as(
select rowid,
       colid,
       zid,
       wid
from (

         select generate_series(min(rowid) - 1,max(rowid) + 1) as rowid
         from parsed2 p
     )t
full outer join (
         select generate_series(min(colid) - 1,max(colid) + 1) as colid
         from parsed2 p
     )t2 on true
full outer join (
         select generate_series(min(zid) - 1,max(zid) + 1) as zid
         from parsed2 p
     )t3 on true
full outer join (
         select generate_series(min(wid) - 1,max(wid) + 1) as wid
         from parsed2 p
     )t4 on true
)
,rawparsed2 as(
select ns1.rowid,
       ns1.colid,
       ns1.zid,
       ns1.wid,
       coalesce(p2.state,'.') as previous_state,
       count(case when p.state = '#' then 1 end) as num_nums,
       count(*),
       case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then '#'
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then '#'
            else '.' end as state,
       max(case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then 1
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then 1
            else 0 end) over(partition by ns1.rowid) as active_in_row,
       max(case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then 1
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then 1
            else 0 end) over(partition by ns1.colid) as active_in_col,
       max(case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then 1
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then 1
            else 0 end) over(partition by ns1.zid) as active_in_z,
       max(case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then 1
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then 1
            else 0 end) over(partition by ns1.wid) as active_in_w
from next_step2 ns1
left join parsed2 p
    on (abs(p.colid - ns1.colid) <= 1
    and abs(p.rowid - ns1.rowid) <= 1
    and abs(p.zid - ns1.zid) <= 1
    and abs(p.wid - ns1.wid) <= 1 )
    and not(p.colid = ns1.colid and p.rowid = ns1.rowid and p.zid = ns1.zid and p.wid = ns1.wid)
left join parsed2 p2 on p2.colid = ns1.colid and p2.rowid = ns1.rowid and p2.zid = ns1.zid and p2.wid = ns1.wid
group by 1,2,3,4,5
)
,bounds2 as(
select
--        *,
       max(case when active_in_row = 1 then rowid end) as max_active_row,
       min(case when active_in_row = 1 then rowid end) as min_active_row,
       max(case when active_in_col = 1 then colid end) as max_active_col,
       min(case when active_in_col = 1 then colid end) as min_active_col,
       max(case when active_in_z = 1 then zid end) as max_active_z,
       min(case when active_in_z = 1 then zid end) as min_active_z,
       max(case when active_in_w = 1 then wid end) as max_active_w,
       min(case when active_in_w = 1 then wid end) as min_active_w
from rawparsed2
)
,parsed3 as (
select p.*
from rawparsed2 p
inner join bounds2 b on p.rowid between min_active_row and max_active_row
        and p.colid between min_active_col and max_active_col
        and p.zid between min_active_z and max_active_z
        and p.wid between min_active_w and max_active_w
)
,next_step3 as(
select rowid,
       colid,
       zid,
       wid
from (

         select generate_series(min(rowid) - 1,max(rowid) + 1) as rowid
         from parsed3 p
     )t
full outer join (
         select generate_series(min(colid) - 1,max(colid) + 1) as colid
         from parsed3 p
     )t2 on true
full outer join (
         select generate_series(min(zid) - 1,max(zid) + 1) as zid
         from parsed3 p
     )t3 on true
full outer join (
         select generate_series(min(wid) - 1,max(wid) + 1) as wid
         from parsed3 p
     )t4 on true
)
,rawparsed3 as(
select ns1.rowid,
       ns1.colid,
       ns1.zid,
       ns1.wid,
       coalesce(p2.state,'.') as previous_state,
       count(case when p.state = '#' then 1 end) as num_nums,
       count(*),
       case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then '#'
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then '#'
            else '.' end as state,
       max(case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then 1
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then 1
            else 0 end) over(partition by ns1.rowid) as active_in_row,
       max(case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then 1
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then 1
            else 0 end) over(partition by ns1.colid) as active_in_col,
       max(case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then 1
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then 1
            else 0 end) over(partition by ns1.zid) as active_in_z,
       max(case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then 1
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then 1
            else 0 end) over(partition by ns1.wid) as active_in_w
from next_step3 ns1
left join parsed3 p
    on (abs(p.colid - ns1.colid) <= 1
    and abs(p.rowid - ns1.rowid) <= 1
    and abs(p.zid - ns1.zid) <= 1
    and abs(p.wid - ns1.wid) <= 1
        )
    and not(p.colid = ns1.colid and p.rowid = ns1.rowid and p.zid = ns1.zid and p.wid = ns1.wid)
left join parsed3 p2 on p2.colid = ns1.colid and p2.rowid = ns1.rowid and p2.zid = ns1.zid and p2.wid = ns1.wid
group by 1,2,3,4,5
)
,bounds3 as(
select
--        *,
       max(case when active_in_row = 1 then rowid end) as max_active_row,
       min(case when active_in_row = 1 then rowid end) as min_active_row,
       max(case when active_in_col = 1 then colid end) as max_active_col,
       min(case when active_in_col = 1 then colid end) as min_active_col,
       max(case when active_in_z = 1 then zid end) as max_active_z,
       min(case when active_in_z = 1 then zid end) as min_active_z,
       max(case when active_in_w = 1 then wid end) as max_active_w,
       min(case when active_in_w = 1 then wid end) as min_active_w
from rawparsed3
)
,parsed4 as (
select p.*
from rawparsed3 p
inner join bounds3 b on p.rowid between min_active_row and max_active_row
        and p.colid between min_active_col and max_active_col
        and p.zid between min_active_z and max_active_z
        and p.wid between min_active_w and max_active_w
)
,next_step4 as(
select rowid,
       colid,
       zid,
       wid
from (

         select generate_series(min(rowid) - 1,max(rowid) + 1) as rowid
         from parsed4 p
     )t
full outer join (
         select generate_series(min(colid) - 1,max(colid) + 1) as colid
         from parsed4 p
     )t2 on true
full outer join (
         select generate_series(min(zid) - 1,max(zid) + 1) as zid
         from parsed4 p
     )t3 on true
full outer join (
         select generate_series(min(wid) - 1,max(wid) + 1) as wid
         from parsed4 p
     )t4 on true
)
,rawparsed4 as(
select ns1.rowid,
       ns1.colid,
       ns1.zid,
       ns1.wid,
       coalesce(p2.state,'.') as previous_state,
       count(case when p.state = '#' then 1 end) as num_nums,
       count(*),
       case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then '#'
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then '#'
            else '.' end as state,
       max(case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then 1
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then 1
            else 0 end) over(partition by ns1.rowid) as active_in_row,
       max(case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then 1
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then 1
            else 0 end) over(partition by ns1.colid) as active_in_col,
       max(case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then 1
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then 1
            else 0 end) over(partition by ns1.zid) as active_in_z,
       max(case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then 1
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then 1
            else 0 end) over(partition by ns1.wid) as active_in_w
from next_step4 ns1
left join parsed4 p
    on (abs(p.colid - ns1.colid) <= 1
    and abs(p.rowid - ns1.rowid) <= 1
    and abs(p.zid - ns1.zid) <= 1
    and abs(p.wid - ns1.wid) <= 1
        )
    and not(p.colid = ns1.colid and p.rowid = ns1.rowid and p.zid = ns1.zid and p.wid = ns1.wid)
left join parsed4 p2 on p2.colid = ns1.colid and p2.rowid = ns1.rowid and p2.zid = ns1.zid and p2.wid = ns1.wid
group by 1,2,3,4,5
)
,bounds4 as(
select
--        *,
       max(case when active_in_row = 1 then rowid end) as max_active_row,
       min(case when active_in_row = 1 then rowid end) as min_active_row,
       max(case when active_in_col = 1 then colid end) as max_active_col,
       min(case when active_in_col = 1 then colid end) as min_active_col,
       max(case when active_in_z = 1 then zid end) as max_active_z,
       min(case when active_in_z = 1 then zid end) as min_active_z,
       max(case when active_in_w = 1 then wid end) as max_active_w,
       min(case when active_in_w = 1 then wid end) as min_active_w
from rawparsed4
)
,parsed5 as (
select p.*
from rawparsed4 p
inner join bounds4 b on p.rowid between min_active_row and max_active_row
        and p.colid between min_active_col and max_active_col
        and p.zid between min_active_z and max_active_z
        and p.zid between min_active_w and max_active_w
)

,next_step5 as(
select rowid,
       colid,
       zid,
       wid
from (

         select generate_series(min(rowid) - 1,max(rowid) + 1) as rowid
         from parsed5 p
     )t
full outer join (
         select generate_series(min(colid) - 1,max(colid) + 1) as colid
         from parsed5 p
     )t2 on true
full outer join (
         select generate_series(min(zid) - 1,max(zid) + 1) as zid
         from parsed5 p
     )t3 on true
full outer join (
         select generate_series(min(wid) - 1,max(wid) + 1) as wid
         from parsed5 p
     )t4 on true
)
,rawparsed5 as(
select ns1.rowid,
       ns1.colid,
       ns1.zid,
       ns1.wid,
       coalesce(p2.state,'.') as previous_state,
       count(case when p.state = '#' then 1 end) as num_nums,
       count(*),
       case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then '#'
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then '#'
            else '.' end as state,
       max(case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then 1
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then 1
            else 0 end) over(partition by ns1.rowid) as active_in_row,
       max(case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then 1
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then 1
            else 0 end) over(partition by ns1.colid) as active_in_col,
       max(case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then 1
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then 1
            else 0 end) over(partition by ns1.zid) as active_in_z,
       max(case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then 1
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then 1
            else 0 end) over(partition by ns1.wid) as active_in_w
from next_step5 ns1
left join parsed5 p
    on (abs(p.colid - ns1.colid) <= 1
    and abs(p.rowid - ns1.rowid) <= 1
    and abs(p.zid - ns1.zid) <= 1
    and abs(p.wid - ns1.wid) <= 1
        )
    and not(p.colid = ns1.colid and p.rowid = ns1.rowid and p.zid = ns1.zid and p.wid = ns1.wid)
left join parsed5 p2 on p2.colid = ns1.colid and p2.rowid = ns1.rowid and p2.zid = ns1.zid and p2.wid = ns1.wid
group by 1,2,3,4,5
)
,bounds5 as(
select
--        *,
       max(case when active_in_row = 1 then rowid end) as max_active_row,
       min(case when active_in_row = 1 then rowid end) as min_active_row,
       max(case when active_in_col = 1 then colid end) as max_active_col,
       min(case when active_in_col = 1 then colid end) as min_active_col,
       max(case when active_in_z = 1 then zid end) as max_active_z,
       min(case when active_in_z = 1 then zid end) as min_active_z,
       max(case when active_in_w = 1 then wid end) as max_active_w,
       min(case when active_in_w = 1 then wid end) as min_active_w
from rawparsed5
)
,parsed6 as (
select p.*
from rawparsed5 p
inner join bounds5 b on p.rowid between min_active_row and max_active_row
        and p.colid between min_active_col and max_active_col
        and p.zid between min_active_z and max_active_z
        and p.wid between min_active_w and max_active_w
)
--
,next_step6 as(
select rowid,
       colid,
       zid,
       wid
from (

         select generate_series(min(rowid) - 1,max(rowid) + 1) as rowid
         from parsed6 p
     )t
full outer join (
         select generate_series(min(colid) - 1,max(colid) + 1) as colid
         from parsed6 p
     )t2 on true
full outer join (
         select generate_series(min(zid) - 1,max(zid) + 1) as zid
         from parsed6 p
     )t3 on true
full outer join (
         select generate_series(min(wid) - 1,max(wid) + 1) as wid
         from parsed6 p
     )t4 on true
)
,rawparsed6 as(
select ns1.rowid,
       ns1.colid,
       ns1.zid,
       ns1.wid,
       coalesce(p2.state,'.') as previous_state,
       count(case when p.state = '#' then 1 end) as num_nums,
       count(*),
       case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then '#'
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then '#'
            else '.' end as state,
       max(case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then 1
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then 1
            else 0 end) over(partition by ns1.rowid) as active_in_row,
       max(case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then 1
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then 1
            else 0 end) over(partition by ns1.colid) as active_in_col,
       max(case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then 1
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then 1
            else 0 end) over(partition by ns1.zid) as active_in_z,
       max(case when coalesce(p2.state,'.') = '#' and count(case when p.state = '#' then 1 end) in (2,3) then 1
            when coalesce(p2.state,'.') = '.' and count(case when p.state = '#' then 1 end) = 3 then 1
            else 0 end) over(partition by ns1.wid) as active_in_w
from next_step6 ns1
left join parsed6 p
    on (abs(p.colid - ns1.colid) <= 1
    and abs(p.rowid - ns1.rowid) <= 1
    and abs(p.zid - ns1.zid) <= 1
    and abs(p.wid - ns1.wid) <= 1
        )
    and not(p.colid = ns1.colid and p.rowid = ns1.rowid and p.zid = ns1.zid and p.wid = ns1.wid)
left join parsed6 p2 on p2.colid = ns1.colid and p2.rowid = ns1.rowid and p2.zid = ns1.zid and p2.wid = ns1.wid
group by 1,2,3,4,5
)
,bounds6 as(
select
--        *,
       max(case when active_in_row = 1 then rowid end) as max_active_row,
       min(case when active_in_row = 1 then rowid end) as min_active_row,
       max(case when active_in_col = 1 then colid end) as max_active_col,
       min(case when active_in_col = 1 then colid end) as min_active_col,
       max(case when active_in_z = 1 then zid end) as max_active_z,
       min(case when active_in_z = 1 then zid end) as min_active_z,
       max(case when active_in_w = 1 then zid end) as max_active_w,
       min(case when active_in_w = 1 then zid end) as min_active_w
from rawparsed6
)
,parsed7 as (
select p.*
from rawparsed6 p
inner join bounds6 b on p.rowid between min_active_row and max_active_row
        and p.colid between min_active_col and max_active_col
        and p.zid between min_active_z and max_active_z
        and p.wid between min_active_w and max_active_w
)


select 'part2',sum((state='#')::int) from parsed7
;
