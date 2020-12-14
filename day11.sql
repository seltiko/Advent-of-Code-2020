with recursive inputs as (
    select *
    from regexp_split_to_table(
$input$L.LL.LL.LL
LLLLLLL.LL
L.L.L..L..
LLLL.LL.LL
L.LL.LL.LL
L.LLLLL.LL
..L.L.....
LLLLLLLLLL
L.LLLLLL.L
L.LLLLL.LL$input$, '\n') WITH ORDINALITY as t(seat_rows, id)
)
,raw_input as (
    select $input$LLLLLLLLLL.LLLL.LLLLLLL.LLLLL.LLLLLLLLLLLLLLLLLLLLLL.LL.LLLLLLLLLLL.LLLLLL.LL.LLLL.LLLLLL.LLLLLLL
LL.LLLLLLL.LLLLLLLLLLLL.LLLLL.LLLLLLLL.LLLLLLLLL.LLLLLL.LLLLLLLL.LLLLLLLLL.LL.LLLL.LLLLLL.LLLLLLL
LLLLLL.LLLLLLLLLLLLLLLL.LLL.L.LLLLLLLL.LLLL.LLLL.LLLLLL.LLLLLLLLLLLLLLLLLLLLLLLLLL.LLLL.L.LLLLLLL
LLLLLLLLLL.LLLL.LLLLLLLLLLLLL.LLLLLLLL.LLLLLLLLL.LLLLLLLLLLLLLLL.LLLLLLLLLLLLLLLLL.LLLLLLLLLLLLLL
LLLLLLLLLLLLLLL.LLLLLLL.LLLLL.LLLLLL.L.LLLLLLLLL.LLLLLL.LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL.LLLLLLL
LLLLLLLLLL.LLLLLLLLLLLL.LLLLLL.LLLLLLLLLLLLLLLLLLLLLLLLL.LLLLLLL.LLLLLLLLL.LLLLLLL.LLLLLL.LLLLLLL
LLLLLLLLLL.LLLL.LLLLLLL.LLLLL.LLLLLLLL.LLLLLLLLLLLLLLLLLLL.LLLLLLL.LLLLLLLLLLLLLLL.LLLLLL.LLLLLLL
LLLLLLLLLL.LLLL.LLLLLLLLLLLLL.LLLLLLLLLLLLLLLLLL.LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL.LLLLLL.LLLLLLL
L.L....L...L..LLLLLL.L.LLL..L...L.....L.L...L..L.LL.....L..L..LL...L........L..LLLLLLL.L......L..
LLLLLLLLLL.LLLLLLLL.LLL.LLLLLLLLLLLLLL.LLLLLLLLL.LLLLLLLLLLLLLLL.LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL
LLLLLLLLLLLLLLLLLLLLLLL.LLLL..LLLLLLLL.LL.LLLLLLL.LLLLLLLLLLLLLL.LL.LLLLLLLLLLLLLL.LLLLLLLLLLLLLL
LLL.LLLLLL.LLLL.LLLLLLLLLLLLL.LLLLLLLLLLLLLLLLLL.LLLLLLLLLLLLLLL.LLLLLLL.L.LLLLLLL.LLLLLLLLLLLLLL
LLLLLLLLLLLLLLL..L.LLLL.LLLLL.LLLLLLLL.LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL.LLLLLLLLLLLL
LLLLLLL.LLLLLLL.LLLLLLL.LLLLL.LLL.LLLLLLLLLLLL.LLLLLLLL.LLLLLLLL.LLLLLLLLL.LLLLLLLLLLLLLL.LLLLLLL
LLLLLLLLLL.LLLLLLLLLLLLLLLLLL.LLLLLLLL.LLLLLLLLL.LLLLLL.LLLLLLLL.LLLLLLLLL.LLLLLLL.LLLLLLLLLLLLLL
LLLLLLLLLL.LLLL.LLLLLLLLLL.LL.LLLLLLLL.LLLLLLLL...LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL.LLLLLL.LLLLLLL
LLLLLLLLLLLLL.LLLLLLLLL.LLLLL.LLLLLLL..LLLLLL.LLLLLLLLLLL.LLLLLL.LLLLLLLLL.LL.LLLLLLLLLLLLLLLLLLL
..L...L..LL.L....LL.L...LLLL......L...L....L...L.L...L..L..L...L.....L..L...................LLL.L
LLLLLLLLLLLL.LLLLLLL.LL.LLLLL.LLLLLLLL.LLLLLLLLL.LLLLL..LLLLLLLLLLLLLLLLLLLLLLLLLL.LLLLLL.LLLLLLL
LLLLLLLLLL.LLLL.LLLLLLLLLLLLL.LLLLLLLLLLLLLLLLLLLLLLLLLLL.LLLLLLLLLLLLLLLL.LL.LLLL.LLLLLL.LLLLLLL
LLLLLLLLLL.LLLL.LLLLLLLLLLLLLLLLLLLLLL.LLLLLLLLL.LLLLLLLLLLLLLLLLLLLLLLLLL.L.LLLLLLLLLLLL.LLLLLLL
LLLLLLLLLLLLLLL.LLLLLLL.LLLLL.LLLLLLLLLLLLLLLLLL.LLLLLL.L.LLLLLL.LLLLLLLLLLL.LLLL..LLLLLL.LLLLLLL
LLLLLLLLLL.LLLL.LLLLLLLLLLLLL.LLLLLLLL.LLLLLLLLLLLLLLLL.LLLLLLLL.LL.LLLLLLLLLLLLLLLLLLLLLLLLLLLLL
LL..LL.....LLL......LL.........L...L..L......L.....LL........LLLL.....L..................LL....L.
LLLLLLLLLL.LLLL.LLLLLLL.LLLLL.LLLLLLLL.LLLLLLLLL.L.LLLLLLLLLLLLL.LLLLL.LLLLLLLLLL.LLLLLLL.LLLLLLL
LLLLLLLLLLLLLLLLLLL.LLL.LLL.L.LLLLLLLLLLLLLLLLLL.LL.L.L.LLLLLLLL.LLLLLLLLLLLLLLLLLLLLLLL.LLLLLLLL
LL.LLLLLLL.LLLLLLLLLLLL.LLLLLLLLLLLLLL.LLLLLLLLL.LLLLLL.LLLLLLLL.LLLLLLLLL.LLLLLLL.LLL.LL.LLLLLL.
LLLLLLLLLL.LLLL.LLLLLLL.LLLLL.LLLLLLLLLLLLLLLLLL.LLLLLL.LLLLLLLLLLLLLLLLLL.LLLLLLL.LLLLLL.LLLLLLL
.LLLLLLLLLLLL.L.LLLLLLL.LLLLL.LLLLLLLL.LLLLLLLLL.LLLLLL.LLLLLLLL.LLLLLLLLLLLLLL.LLLLLLLLL.LLLLLLL
...L..L...L.....L....LL..L.....L.L..L...LLLL..L....LL.L....L.L.L......LL...L...L..LLLL.L..L......
LLLLLLLLLL.LLLLLLLLLLLL.LLLLL.LLLLLLLL.LLLL.LLLLLLLLLLL.LLLLLL...LLL.LLLLL.LLL.LLL.LLLLL..LLLLLLL
LLLLLLLLLL.LLLL.LLLLLLL.LLLLL.LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL.LLL.LLLLLLLLLL.LLLLLLL
LLLLLLLLLLLLLLLLLLLLLLL.LLLLL.LLLLLLLLLLLLLLLLLLLLLLL.L.LLLLLLLLLLLLLLLLLLLLLLLLLL.LLLLLL.LLLLLLL
LLLLLLLLLL.LLLL.LLLLLLLLLLLLL.LLLLLLLL.LL.LL.LLL.LLLLL..LLLLLLLL.LLLLLLLLL.LLLL.LLLLLLLLLLLLLLLLL
L.LLLLLLLLLLL.L..LLLLLL.LLLLL.LLLLLLLL..LLLLLLLLLLLLLLLLLLLLLLLL.LLLLLLLLLLLLLLLLL.LLLLLL.LLLLLLL
.L....LL....L......LLL...L..L..L.L.L.LLL.L.L........L....L..LL......L......L.L..LLLL.L.L..L......
LLLLLLLLLL.LLLLLLLLLLLL.LLLLLLLLLLLLLL.LLLLLLLLLLLLLLLL.LLLLLLLL.LLLLLLLL..LLLLLLL..LL.LLLLLLLLLL
LLLLLLLLLLLLLLLLLLLLLLL.LLLLL.LLLLLLLL.LLLL.LLLL.LLLLLL.LLLLLLLLLLLLLLLLLLL.LLLLLLLLLLLLLLLLLLLLL
LLLLLLLLLL..LLL.LLLLL.L.LL.LL.LLLLLLLLLLLLLLLLLL.LLLLLLLLLLLLLLLLLLLLLLLLL.LLLLLLL.LLLLLLLLLLLLLL
LLLLL.LLLLLLLLL.LLLLLLLLLLLLL.LLLLLLLL.LLLLLLLLL.LLLLLLLLLLLLL.L.LLLLLLLLL.LLLLL.L.LLLLLLLLLLLLLL
LLLLLL.....L......L.......L..L.LLL...L.L...LLL....L.......L.L..L...LL....LL.L...L...LLL.L...L..LL
LLLLLLLLLLLLLLLLLLLLLLL.LLLLLLLLLLLLLL.LLLLLLLLL.LLLLLL.LLLLLLLL.LLLLLLLLL.LLLLLLLLLLLLLL.LLLLLLL
LLLLLLLLLL.LLLLLLLLLLLLLLLLLLLLLLLLLLL.LLLLLLLLL.LLLLLL.LLLLLLLLLLLLLLLLLL.LLLLLLLLLLLLLL.L.LLLLL
LLLLLLLLLLLLLLL.LL.LLLL.LLLLL.LLLLLLLL.LLLLLLLLL.LLLLLL.LLLLLLLLLLLLLLLLLL.LLLLLLLLLLLLLL.LLLLLLL
LLLLLLLLLLLLLLLLLLLLLLL.LLLLL.LLLLLLLLLLLLLLLLLL.LLLLLL.LLLLLLLL.LLLLLL.LL.LLLLLLLLLLLLLLLLLLLLLL
....L..L.L.L...L.....L...LLL.....L.......L..LLL.LL...L.....L..L.L...L.L.L...LL...LL.L....LL.....L
LLLLLLLLLL.LLLL.LLLLLLL.LLLLL.LLLLLLLL.LLLLLLLLL.LLLLLL.LLLLLLLL.LLLLLLLLLLLLL.LLLLLLLLLL.LLL.LLL
LLL.LLLLLL.LLLL.LLLLLLL.LLLLLLLLLLLLLLLLLLL.LLLLLLLL.LL.LLLLLLLLLLLLLLL.LLLLLLLLLL.LLLLLL.LLLLLLL
LLLLLLLLLL.LLLL.LLLLLLLLLLLLL.LLLLLLLL.LLLLLLLLLLLLLL.L.LLLLLLLLLLL.LLLLLL.LLLLLL..LLLLLLLLLLLLLL
LL.LLLLLLLLLLLL.LLLLLLL.LLLLL.LLLLLLLLLLLLLLLLLL.LLLLLL.LL.LLLL..LLLLLLLLL.LLLLLLL.LLLLLL.LLLLLLL
LLLLLLLLLL.LLLL.LLLL.LL.LLLLLLLLLLLLLL.LLLLLLLLL.LLLLLL.LLLLLLLL.LLLLLLLLL.LLLLLLL.LLLLLL.L.LLLLL
LLL.LLLLLL.LLLL.LLLLLLL.LLLLL.LLLLLLLL.LLLLLLLLL.LL.LLLLLL..LLLL.LLLLLLLLL.LLLLLLL.LLLLLLLLL.LL.L
LLLLLLLLLL.LLLL.LLLLLLL.LLLLL.LLLLLLLLLLLLLLLLLL.LLLLLL.LLLLLLLL.LLLLLLLLL.LLLLLLLLLLLLLLLLLLLLLL
......L......LLL......L.LL...L..L.L.L..L.L.......L.L....L..LL.......L......L.....L.LLLLLL...L...L
LLLLLLLLLLLLLLL.LLLLLLL.LLLLL.LLLLLLLL.LLLLLLL.LLLLLLLLL.LLLLLLLLLLLLLLLLL.LLLLLLLLLLL..L.L.LLLLL
LLLLLLLLLLLLLLL.LLLLLLL.LLLL.LLLLLLLLL.LLLLLLLLLLLLLLLL.LLLLL.LLLLLLLLLLLLLLLLLLL.LLLLLLLLLLLLLLL
LLLLLLLLLL.LLLL.LLLLL.L.LLL.L.LLLLLLLL.LLLLLLL.LLLLLLLL.LLLLLLLLLLLLLLLLLLLLLLLLLL.LLLLLL.LLLLLLL
LLLLLLLLLL.LLLL.LL.LLLL.LLLLL.LLLLLLLL.LLLLLLLLL.LLLLLL.LLLLLLLL.LLLLLLLLL.LLLLLLL..LLLLL.LLLLLLL
LL.LLLLLLLLLLLL.LLLLLLL.LLLLL.LLLLLLLL.LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL.LLLLLLL.LLLLLLLLLLLLLL
.LLLLL.LLL.LLLLLLLLLLLL.LLLLL.LLLLLLLL.LLLLLL.LL.LLLLLLLLLLLL.LL.LLLLLLLLLLLLLLLLL.LLLLLL.LLLLLLL
LLLLLLLLLL.LLLL.LLLLLLLLLLLLL.LLLLLLLL.LLL.LL.L.LLLL.L.LLLLLLLLL.LLLLLLLLL.LLLLLLLLLLLLLL.LLLLLLL
LLLLLLLLLL.LLLLLLLLLLLL.LLLL..LLL.LLLL.LLLLLLLLL.LLLLLLLLLLLLLLL.LLLLLLLLLLLLLLLLL.LLLLLLLLLLLLLL
LLLLLLLLLLLLLLLLLLLL.LL.LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL.L.L.LLLLLLL.L.LLLLL.LLLLLL.LLLLLLL
.L....L...L..LL.....L.LL...L.L..LLL...L..L..L..L..L.LLLLL....LLLL.........L..L..L..L..L...LL....L
LLLLLLLLLL.LLLL.LLLLLLL.LLLL..LLLLLLLLLLLLLLLLL..L.LLLL.LLLLLLLL.LLLLLLLLL.LLLLLLL.LLLLLL.LLLLLLL
LLLLLLLLLLLLLLL.LLLLLLL.LLLLL.LLLLLLLL.LLLLLLL.L.LLLLLLLLLLLLLLLLL.LLLLLLL.LLLLLLL.LLLLLL.LLLLLLL
LLLLL.LLLL.LLLL.LLLLLLL.LLLLL.LLLLLLLL.LLLLLLLLL.LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL..LLLL
LLLLLLLLLL.LLLL.LLLLLLL.LLLLL.LLLLLLLL.LLLLLLLLL.LLLLLLLLLLLLLLL.LLLLLLLLLLLLLLLLLLLLLLLL.LLLLLLL
LL.LLLLLLLLLLLL.LLLLLLL.LLLLL.LLLL.L.L.LLLLLLLLL.LLLLLL.LLLLLLLLLLLLLLLLLL.LLLLLLL.LLLLLL.LLLLLLL
LLLLL.LLLL.LLLL.LLLLLLL.LLLLL.LLLLLLLLLLLLLLLLLL.LLLLLLLLL.LLLLLLLLLLLLLLL.LLLLLLL.LLLLLL.LLLLLLL
..L.L...L.L........L.......L......LLLLL......L.LLL.LL.........L.L....L..L.L.L...L..LL.L......LL..
LLLLLLLLLL.LL.L.LLLLLLL.LLLLL.LLLLLLLLLLLLLLLLLLLLLLLLL.LLLLLLLLLLLLLLLLLL.LLLLLLL.LLLLLL.LLLLLLL
LLLLLLLLLL.LLLL.LLLLLLLLL.LLL.LLLLLLLLLLLLLLLLLL.LLLLLL.LLLLLLLLLLLLLLL.LL.LLLLLLL.LLLLLL.LLLLLLL
LLL.LLLLLLLLL.L.LLLLLLL.LLLLLLLLLLLL.L.LLLLLLLL..LLLLLLLLLLLLLLL.LLLL.LLLLLLLLLL.L.LLLLLLLLLLLLL.
LLLLLLLLLLLLLLL.LLLLLLL.LLLLL.LLLLLLLLLLLLLLL.LL.LLLLLLLL.LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL
LLLLLLLLLL.LLLL.LLLLLLL.LLLLL.LLLLLLLL.LLLLLLLLL.LLLLLL.L.LLLLLL.LL.LLLLLL.LLLLLLL.LL.LLL.LLLLLLL
LLLLLLLLLLLLLLLLLLLLLLL.LL.LL.LLLLLLLL.LLLLLLLLL.LLLLLL.LLLLLLLL.LLLLLLLLL.LLLLLLLLLLLLLL.LLLLLLL
LLLLLLLLLL.LLLLLLLLLL.L.LLLLL.LLLLLLLL.LLLLLLLLL.LLL.LL.LLLLLLLL.LLLLLLLLL.LLLLLLL.LLLLLLLLLLLLLL
LLLLLLLLLLLLLLLLLLLLLLL.LLLLLLLLLLLLLLLLLLLLLLLL.LLLLLL.LL.LLLLL.LLLLLLLLL.LLLLLLL.LLLLLLLLLLLLLL
LLLLLLLL.L.LLLL.LLLLLLL.LLLL..LLLLLLLLLLLLLLLLLL.LLLLLLLLLLLLLLL.LLLLLLLLL.LLLLLLL.LLLLLL.LLLL.LL
.....LL.L...L..L.L..LL.L.......L...L...LLL.L.L..L.LL.L...LL..L.LL.LLL......LL.L..L.LL......L.....
LLL.LLLLLL.LLLLLLLLLLLL.LLLLLL..LLLLLL.LLLLLLLLL.LLLLLL.LLLLLLLL.LLLLLLLLL.LLLLLLLLLL.LLLLLLLL..L
LLLLLLLLLL.LLLL.LLLLL.L.LLLLL.LLLLLLLL.LLLLLLLLLLLLLLLL.LLLLLLLL.L..LLLLLL.LLLLLLL.LLLLL.LLLLLLLL
LLLLLLLLLL.LLL..LLLLLLL.LLLLL.LLLLLLLL.LLLLLLL.LLLLLLLL.LLLLLLLL.LLLLLLLLLLLLLLLLL.LLLLLL.LLLLLLL
LLLLLLLLLL.LLLLLLLLLLLL.LLLLL.LLLLLLLL.LLLLLLLLLLLLLLL..LLLLLL.LLLLLLLLL.L.LLLLL.LLLLLLLL.LLLLLLL
LLLLLLLLLL.LLLL.LLLLLLL.LLLLL.LLL.LLLLLLLLLLLLLLLLLLLLLLLLLLLLLL.LLLLLLLLL.LLLLLLL.LLLLLL.LLLLLLL
LLLLLLLLLLLLLLL.LLLLLLLLLLLLL.LLLLLLLL.LLLLLLLLL.LLLLLLLLLLLL.LL.LLL.LLLLLLLLL.LLLLLLLLLL.LLLLLLL
LLLLLLLLLLLLLLL.LLLLLLLLLLLLLLL.LLLLLL.LLLLLLLLL.LLLLLL.LLLLLLLL.LLLLLLLLLLLLLLLLL.LLLLLL.LLLLLLL
LL.LLLLLLLLLLLL.LLLLLLL.LLLL..LLLLLLL..LLLLLLLLL.LLLLLLLLLLLLLLL.LLLLLLLLL.LLLLLLLLLLLLLL.LLLLLLL
LLLLLLLL.L.LLLLLLLLLLLL.LLLLLLLLLLLLL..LLLLLLLLL.LLLLLL.LLLLLLLLLLLLLLLLLL.LLLLLLL.LLLLLL.LLLLLLL
LLLLLLLL.LLLLLLLLLLLLLL.LLLLL.LLLLLLLLLL.LLLLLLL.LLLLLL.LLLLLL.L.LLLLLLLLL.LLLLLLL.LL.LLL.LLLLLLL
LLLLLLLLLLLLLLLLLLLLLLLLLLLLL.LLLLLLLLLLLLLLLLLL.LLLLLL.LLLLLLLL.LLLLLLLLLLLLLLLLL.LLLLLL.LLLLLLL
LLLLLLLLLLLLLLL.LLLLLLL.LLLLL.LLLLL.LLLLL.LLLLLL.L.LLLL.LLLLLLLL.LLLLLLLLLLLLLLLLL.LLL.LL.LLLLLL.$input$ as raw_input
)
,raw_input2 as(
    select 'L.LL.LL.LL
LLLLLLL.LL
L.L.L..L..
LLLL.LL.LL
L.LL.LL.LL
L.LLLLL.LL
..L.L.....
LLLLLLLLLL
L.LLLLLL.L
L.LLLLL.LL' as raw_input
)
,parsed as(
select
     *,
       regexp_replace(raw_input,'\n','','g') as raw_string,
       regexp_split_to_array(regexp_replace(raw_input,'\n','','g'),'') as raw_array,
       char_length(regexp_replace(raw_input,'\n','','g')) as string_length,
       char_length(regexp_replace(raw_input,'\n','','g')) / (char_length(raw_input) + 1 - char_length(regexp_replace(raw_input,'\n','','g'))) as row_lengtha
from raw_input i
)
--    select * from parsed;
,num_elements as(
    select generate_series(1,string_length) as seat_spaces,
           row_lengtha as row_length
--            raw_array as input_array
    from parsed
)
,adjaceny as (
select ne.seat_spaces as starting_space,
       ne2.seat_spaces as adjacent_spaces,
       ne.row_length
from num_elements ne
inner join num_elements ne2
    on 'no'
    or (ne.seat_spaces - 1) / ne.row_length = (ne2.seat_spaces - 1) / ne2.row_length
    or ne.seat_spaces%ne.row_length = ne2.seat_spaces%ne2.row_length
--     or ne.seat_spaces + ne.row_length * ((ne2.seat_spaces - ne.seat_spaces) / ne2.row_length) + 1 * ((ne2.seat_spaces - ne.seat_spaces) / ne2.row_length) = ne2.seat_spaces
    or abs(ne.seat_spaces%ne.row_length - ne2.seat_spaces%ne.row_length) = abs((ne.seat_spaces - 1) / ne.row_length - (ne2.seat_spaces - 1) / ne.row_length)
--     or ne.seat_spaces + ne.row_length * ((ne.seat_spaces - ne2.seat_spaces) / ne2.row_length) + 1 * ((ne.seat_spaces - ne2.seat_spaces) / ne2.row_length) = ne2.seat_spaces
--     or ne.seat_spaces - ne.row_length * ((ne2.seat_spaces - ne.seat_spaces) / ne2.row_length) + 1 * ((ne2.seat_spaces - ne.seat_spaces) / ne2.row_length) = ne2.seat_spaces
--     or ne.seat_spaces - ne.row_length * ((ne2.seat_spaces - ne.seat_spaces) / ne2.row_length) - 1 * ((ne2.seat_spaces - ne.seat_spaces) / ne2.row_length) = ne2.seat_spaces
--     on case when (ne.seat_spaces - 1) / ne.row_length = (ne2.seat_spaces - 1) / ne2.row_length then abs(ne2.seat_spaces - ne.seat_spaces) = 1
--         when abs((ne.seat_spaces - 1) / ne.row_length - (ne2.seat_spaces - 1) / ne2.row_length) = 1 then abs(ne2.seat_spaces - 10 - ne.seat_spaces) < 2
--         else false end
where ne.seat_spaces <> ne2.seat_spaces
    and ne.seat_spaces = 99
)
,lookup as (
select ne.seat_spaces,
       above,
       below,
       rightward,
       leftward,
       aboveright,
       aboveleft,
       belowright,
       belowleft
from num_elements ne
left join lateral (
    select min(case when ne2.seat_spaces > ne.seat_spaces then ne2.seat_spaces end) above,
           max(case when ne2.seat_spaces < ne.seat_spaces then ne2.seat_spaces end) below
    from num_elements ne2
             inner join lateral (
        select raw_array[ne2.seat_spaces] as adjacent_type
--                raw_array[ne.seat_spaces]  as space_type
        from parsed
        ) p on adjacent_type = 'L'
    where ne2.seat_spaces % ne.row_length = ne.seat_spaces % ne.row_length
      and ne2.seat_spaces <> ne.seat_spaces
    )ab on true
left join lateral (
    select min(case when ne2.seat_spaces > ne.seat_spaces then ne2.seat_spaces end) rightward,
           max(case when ne2.seat_spaces < ne.seat_spaces then ne2.seat_spaces end) leftward
    from num_elements ne2
             inner join lateral (
        select raw_array[ne2.seat_spaces] as adjacent_type
--                raw_array[ne.seat_spaces]  as space_type
        from parsed
        ) p on adjacent_type = 'L'
    where (ne.seat_spaces - 1) / ne.row_length = (ne2.seat_spaces - 1) / ne2.row_length
      and ne2.seat_spaces <> ne.seat_spaces
    )rl on true
left join lateral (
    select
           min(case when ne2.seat_spaces > ne.seat_spaces and (ne.seat_spaces-1)%ne.row_length - (ne2.seat_spaces-1)%ne.row_length < 0 then ne2.seat_spaces end) belowright,
           min(case when ne2.seat_spaces > ne.seat_spaces and (ne.seat_spaces-1)%ne.row_length - (ne2.seat_spaces-1)%ne.row_length > 0 then ne2.seat_spaces end) belowleft,
           max(case when ne2.seat_spaces < ne.seat_spaces and (ne.seat_spaces-1)%ne.row_length - (ne2.seat_spaces-1)%ne.row_length < 0 then ne2.seat_spaces end) aboveright,
           max(case when ne2.seat_spaces < ne.seat_spaces and (ne.seat_spaces-1)%ne.row_length - (ne2.seat_spaces-1)%ne.row_length > 0 then ne2.seat_spaces end) aboveleft
--             ne.seat_spaces as belowright,ne2.seat_spaces as belowleft, 1 as aboveright, 2 as aboveleft
    from num_elements ne2
             inner join lateral (
        select raw_array[ne2.seat_spaces] as adjacent_type
--                raw_array[ne.seat_spaces]  as space_type
        from parsed
        ) p on adjacent_type = 'L'
    where abs((ne.seat_spaces-1)%ne.row_length - (ne2.seat_spaces-1)%ne.row_length) = abs((ne.seat_spaces - 1) / ne.row_length - (ne2.seat_spaces - 1) / ne.row_length)
      and ne2.seat_spaces <> ne.seat_spaces
      and not(ne2.seat_spaces % ne.row_length = ne.seat_spaces % ne.row_length)
--       and abs(ne.seat_spaces%ne.row_length - ne2.seat_spaces%ne.row_length) < ne.row_length - ne.seat_spaces%ne.row_length
--       and ne.seat_spaces%ne.row_length > ne2.seat_spaces%ne.row_length
--       and abs((ne.seat_spaces-1)%ne.row_length - (ne2.seat_spaces-1)%ne.row_length) + ne.seat_spaces <= ((ne.seat_spaces - 1) / ne.row_length) * ne.row_length
    )diag on true
)
--    select * from lookup
-- where seat_spaces = 28
-- ;

,sitdown(live_string,lag_string,cycles) as(
select distinct
       array_agg((case
        when (raw_array)[seat_spaces] = 'L'
            and (raw_array)[above] is distinct from '#'
            and (raw_array)[below] is distinct from '#'
            and (raw_array)[rightward] is distinct from '#'
            and (raw_array)[leftward] is distinct from '#'
            and (raw_array)[aboveright] is distinct from '#'
            and (raw_array)[aboveleft] is distinct from '#'
            and (raw_array)[belowright] is distinct from '#'
            and (raw_array)[belowleft] is distinct from '#'
            then '#'
        when (raw_array)[seat_spaces] = '#'
            and (
                ((raw_array)[above] is not distinct from '#')::int +
                ((raw_array)[below] is not distinct from '#')::int +
                ((raw_array)[rightward] is not distinct from '#')::int +
                ((raw_array)[leftward] is not distinct from '#')::int +
                ((raw_array)[aboveright] is not distinct from '#')::int +
                ((raw_array)[aboveleft] is not distinct from '#')::int +
                ((raw_array)[belowright] is not distinct from '#')::int +
                ((raw_array)[belowleft] is not distinct from '#')::int
                ) >= 5
            then 'L'
        else (raw_array)[seat_spaces] end)) over(),
        raw_array,
       1
--             ,
--        *
from parsed ri
cross join lookup
-- group by starting_space,raw_input
-- limit 1
union all
select distinct
       array_agg((case
        when (live_string)[seat_spaces] = 'L'
            and (live_string)[above] is distinct from '#'
            and (live_string)[below] is distinct from '#'
            and (live_string)[rightward] is distinct from '#'
            and (live_string)[leftward] is distinct from '#'
            and (live_string)[aboveright] is distinct from '#'
            and (live_string)[aboveleft] is distinct from '#'
            and (live_string)[belowright] is distinct from '#'
            and (live_string)[belowleft] is distinct from '#'
            then '#'
        when (live_string)[seat_spaces] = '#'
            and (
                ((live_string)[above] is not distinct from '#')::int +
                ((live_string)[below] is not distinct from '#')::int +
                ((live_string)[rightward] is not distinct from '#')::int +
                ((live_string)[leftward] is not distinct from '#')::int +
                ((live_string)[aboveright] is not distinct from '#')::int +
                ((live_string)[aboveleft] is not distinct from '#')::int +
                ((live_string)[belowright] is not distinct from '#')::int +
                ((live_string)[belowleft] is not distinct from '#')::int
                ) >= 5
            then 'L'
        else (live_string)[seat_spaces] end)) over(),
                live_string,
  cycles+ 1
from sitdown ri
cross join lookup a
where 'yes'
--     and cycles < 1
    and live_string <> lag_string
-- group by cycles
-- limit 1
)


select *,
         cardinality(s.live_string) -  cardinality( array_remove(s.live_string,'#'))
from sitdown s
order by cycles desc
limit 1
;
/*
part 1 is here 
,sitdown(live_string,lag_string,cycles) as(
select distinct
       array_agg((case
        when (raw_array)[seat_spaces] = 'L' and seat_spaces%row_length = 1
            and (raw_array)[seat_spaces+1] is distinct from '#'
            and (raw_array)[seat_spaces+row_length] is distinct from '#'
            and (raw_array)[seat_spaces+row_length+1] is distinct from '#'
            and (raw_array)[seat_spaces-row_length] is distinct from '#'
            and (raw_array)[seat_spaces-row_length+1] is distinct from '#'
            then '#'
        when (raw_array)[seat_spaces] = '#' and seat_spaces%row_length = 1
            and (((raw_array)[seat_spaces+1] is not distinct from '#')::int +
                ((raw_array)[seat_spaces+row_length] is not distinct from '#')::int +
                ((raw_array)[seat_spaces+row_length+1] is not distinct from '#')::int +
                ((raw_array)[seat_spaces-row_length] is not distinct from '#')::int +
                ((raw_array)[seat_spaces-row_length+1] is not distinct from '#')::int ) >= 4
            then 'L'
        when (raw_array)[seat_spaces] = 'L' and seat_spaces%row_length = 0
            and (raw_array)[seat_spaces-1] is distinct from '#'
            and (raw_array)[seat_spaces+row_length] is distinct from '#'
            and (raw_array)[seat_spaces+row_length-1] is distinct from '#'
            and (raw_array)[seat_spaces-row_length] is distinct from '#'
            and (raw_array)[seat_spaces-row_length-1] is distinct from '#'
            then '#'
        when (raw_array)[seat_spaces] = '#' and seat_spaces%row_length = 0
            and (((raw_array)[seat_spaces-1] is not distinct from '#')::int +
                ((raw_array)[seat_spaces+row_length] is not distinct from '#')::int +
                ((raw_array)[seat_spaces+row_length-1] is not distinct from '#')::int +
                ((raw_array)[seat_spaces-row_length] is not distinct from '#')::int +
                ((raw_array)[seat_spaces-row_length-1] is not distinct from '#')::int ) >= 4
            then 'L'
        when (raw_array)[seat_spaces] = 'L' and seat_spaces%row_length not in (1,0)
            and (raw_array)[seat_spaces-1] is distinct from '#'
            and (raw_array)[seat_spaces+1] is distinct from '#'
            and (raw_array)[seat_spaces+row_length] is distinct from '#'
            and (raw_array)[seat_spaces+row_length-1] is distinct from '#'
            and (raw_array)[seat_spaces+row_length+1] is distinct from '#'
            and (raw_array)[seat_spaces-row_length] is distinct from '#'
            and (raw_array)[seat_spaces-row_length-1] is distinct from '#'
            and (raw_array)[seat_spaces-row_length+1] is distinct from '#'
            then '#'
        when (raw_array)[seat_spaces] = '#' and seat_spaces%row_length not in (1,0)
            and (((raw_array)[seat_spaces-1] is not distinct from '#')::int +
                ((raw_array)[seat_spaces+1] is not distinct from '#')::int +
                ((raw_array)[seat_spaces+row_length] is not distinct from '#')::int +
                ((raw_array)[seat_spaces+row_length-1] is not distinct from '#')::int +
                ((raw_array)[seat_spaces+row_length+1] is not distinct from '#')::int +
                ((raw_array)[seat_spaces-row_length] is not distinct from '#')::int +
                ((raw_array)[seat_spaces-row_length-1] is not distinct from '#')::int +
                ((raw_array)[seat_spaces-row_length+1] is not distinct from '#')::int ) >= 4
            then 'L'
        else (raw_array)[seat_spaces] end)) over(),
        raw_array,
       1
--             ,
--        *
from parsed ri
cross join num_elements
-- group by starting_space,raw_input
-- limit 1
union all
select distinct
       array_agg((case
        when (live_string)[seat_spaces] = 'L' and seat_spaces%row_length = 1
            and (live_string)[seat_spaces+1] is distinct from '#'
            and (live_string)[seat_spaces+row_length] is distinct from '#'
            and (live_string)[seat_spaces+row_length+1] is distinct from '#'
            and (live_string)[seat_spaces-row_length] is distinct from '#'
            and (live_string)[seat_spaces-row_length+1] is distinct from '#'
            then '#'
        when (live_string)[seat_spaces] = '#' and seat_spaces%row_length = 1
            and (((live_string)[seat_spaces+1] is not distinct from '#')::int +
                ((live_string)[seat_spaces+row_length] is not distinct from '#')::int +
                ((live_string)[seat_spaces+row_length+1] is not distinct from '#')::int +
                ((live_string)[seat_spaces-row_length] is not distinct from '#')::int +
                ((live_string)[seat_spaces-row_length+1] is not distinct from '#')::int ) >= 4
            then 'L'
        when (live_string)[seat_spaces] = 'L' and seat_spaces%row_length = 0
            and (live_string)[seat_spaces-1] is distinct from '#'
            and (live_string)[seat_spaces+row_length] is distinct from '#'
            and (live_string)[seat_spaces+row_length-1] is distinct from '#'
            and (live_string)[seat_spaces-row_length] is distinct from '#'
            and (live_string)[seat_spaces-row_length-1] is distinct from '#'
            then '#'
        when (live_string)[seat_spaces] = '#' and seat_spaces%row_length = 0
            and (((live_string)[seat_spaces-1] is not distinct from '#')::int +
                ((live_string)[seat_spaces+row_length] is not distinct from '#')::int +
                ((live_string)[seat_spaces+row_length-1] is not distinct from '#')::int +
                ((live_string)[seat_spaces-row_length] is not distinct from '#')::int +
                ((live_string)[seat_spaces-row_length-1] is not distinct from '#')::int ) >= 4
            then 'L'
        when (live_string)[seat_spaces] = 'L' and seat_spaces%row_length not in (1,0)
            and (live_string)[seat_spaces-1] is distinct from '#'
            and (live_string)[seat_spaces+1] is distinct from '#'
            and (live_string)[seat_spaces+row_length] is distinct from '#'
            and (live_string)[seat_spaces+row_length-1] is distinct from '#'
            and (live_string)[seat_spaces+row_length+1] is distinct from '#'
            and (live_string)[seat_spaces-row_length] is distinct from '#'
            and (live_string)[seat_spaces-row_length-1] is distinct from '#'
            and (live_string)[seat_spaces-row_length+1] is distinct from '#'
            then '#'
        when (live_string)[seat_spaces] = '#' and seat_spaces%row_length not in (1,0)
            and (((live_string)[seat_spaces-1] is not distinct from '#')::int +
                ((live_string)[seat_spaces+1] is not distinct from '#')::int +
                ((live_string)[seat_spaces+row_length] is not distinct from '#')::int +
                ((live_string)[seat_spaces+row_length-1] is not distinct from '#')::int +
                ((live_string)[seat_spaces+row_length+1] is not distinct from '#')::int +
                ((live_string)[seat_spaces-row_length] is not distinct from '#')::int +
                ((live_string)[seat_spaces-row_length-1] is not distinct from '#')::int +
                ((live_string)[seat_spaces-row_length+1] is not distinct from '#')::int ) >= 4
            then 'L'
        else (live_string)[seat_spaces] end)) over(),
                live_string,
  cycles+ 1
from sitdown ri
cross join num_elements a
where 'yes'
--     and cycles < 1
    and live_string <> lag_string
-- group by cycles
-- limit 1
)


select *,
         cardinality(s.live_string) -  cardinality( array_remove(s.live_string,'#'))
from sitdown s
order by cycles desc
limit 1
;
*/





