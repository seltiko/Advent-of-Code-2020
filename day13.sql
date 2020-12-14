with recursive inputs as (
    select *
    from regexp_split_to_table(
$input$1013728
23,x,x,x,x,x,x,x,x,x,x,x,x,41,x,x,x,x,x,x,x,x,x,733,x,x,x,x,x,x,x,x,x,x,x,x,13,17,x,x,x,x,19,x,x,x,x,x,x,x,x,x,29,x,449,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,37$input$, '\n') WITH ORDINALITY as t(busses, id)
)

,parsed as(
select
     (regexp_split_to_table(regexp_replace(busses,'x,','','g'),','))::int as bus_ids
from inputs i
where id = 2
)
,part1 as (
select busses, bus_ids, floor(busses::numeric / bus_ids::numeric) as just_below,
       floor(busses::numeric / bus_ids::numeric) * bus_ids + bus_ids as just_past,
       (floor(busses::numeric / bus_ids::numeric) * bus_ids + bus_ids - busses::numeric)%bus_ids as minimum_time,
       (floor(busses::numeric / bus_ids::numeric) * bus_ids + bus_ids - busses::numeric)%bus_ids * bus_ids as answer
from parsed p
cross join inputs i
where i.id = 1
order by (floor(busses::numeric / bus_ids::numeric) * bus_ids + bus_ids - busses::numeric)%bus_ids asc
limit 1
)
,mods_of_modes as (
select bus_id::int, (bus_id::int - (sub_id -1)%bus_id::int)%bus_id::int as mod_result, sub_id,row_number() over (order by bus_id desc) as bus_id_ordering
from regexp_split_to_table((select busses from inputs where id = 2), ',')  with ordinality t(bus_id,sub_id)
where bus_id <> 'x'
order by bus_id desc
)
--    select * from mods_of_modes;
,one_to_two(bigbigbig,iter,check_bus,check_mod_result,bus_id_o) as (
select mom.mod_result, mom.bus_id as iter, mom2.bus_id as check_bus, mom2.mod_result as check_mod_result,mom2.bus_id_ordering
--        *
from mods_of_modes mom
left join mods_of_modes mom2 on mom2.bus_id_ordering = mom.bus_id_ordering + 1
where mom.bus_id_ordering = 1
union all
select bigbigbig + iter, iter, check_bus, check_mod_result,bus_id_o
from one_to_two ott
where (bigbigbig + iter)%check_bus != check_mod_result
)
,one_to_two2 as (select * from one_to_two order by bigbigbig desc limit 1)
,two_to_three(bigbigbig,iter,check_bus,check_mod_result,bus_id_o) as (
select bigbigbig+iter, iter*check_bus as iter, mom2.bus_id as check_bus, mom2.mod_result as check_mod_result,mom2.bus_id_ordering
--        *
from one_to_two2 mom
left join mods_of_modes mom2 on mom2.bus_id_ordering = mom.bus_id_o + 1
-- order by mom.bigbigbig desc
-- limit 1
union all
select bigbigbig + iter, iter, check_bus, check_mod_result,bus_id_o
from two_to_three ott
where (bigbigbig + iter)%check_bus != check_mod_result
)
,two_to_three2 as (select * from two_to_three
order by bigbigbig desc limit 1)
,two_to_three_cheat as (select 12354738::bigint as bigbigbig, 329117::bigint as iter, 41::int as check_bus, 13::int as check_mod_result, 3::int as bus_id_o)
,three_to_four(bigbigbig,iter,check_bus,check_mod_result,bus_id_o) as (
select bigbigbig+iter, iter*check_bus as iter, mom2.bus_id as check_bus, mom2.mod_result as check_mod_result,mom2.bus_id_ordering
--        *
from two_to_three2 mom
left join mods_of_modes mom2 on mom2.bus_id_ordering = mom.bus_id_o + 1
-- order by mom.bigbigbig desc
-- limit 1
union all
select bigbigbig + iter, iter, check_bus, check_mod_result,bus_id_o
from three_to_four ott
where (bigbigbig + iter)%check_bus != check_mod_result
)
,three_to_four2 as (select * from three_to_four
order by bigbigbig desc limit 1)
,four_to_five(bigbigbig,iter,check_bus,check_mod_result,bus_id_o) as (
select bigbigbig+iter, iter*check_bus as iter, mom2.bus_id as check_bus, mom2.mod_result as check_mod_result,mom2.bus_id_ordering
--        *
from three_to_four2 mom
left join mods_of_modes mom2 on mom2.bus_id_ordering = mom.bus_id_o + 1
-- order by mom.bigbigbig desc
-- limit 1
union all
select bigbigbig + iter, iter, check_bus, check_mod_result,bus_id_o
from four_to_five ott
where (bigbigbig + iter)%check_bus != check_mod_result
)
,four_to_five2 as (select * from four_to_five order by bigbigbig desc limit 1)
,five_to_six(bigbigbig,iter,check_bus,check_mod_result,bus_id_o) as (
select (bigbigbig::numeric+iter::numeric)::numeric, (iter::numeric*check_bus)::numeric as iter, mom2.bus_id as check_bus, mom2.mod_result as check_mod_result,mom2.bus_id_ordering
--        *
from four_to_five2 mom
left join mods_of_modes mom2 on mom2.bus_id_ordering = mom.bus_id_o + 1
-- order by mom.bigbigbig desc
-- limit 1
union all
select (bigbigbig + iter)::numeric, iter, check_bus, check_mod_result,bus_id_o
from five_to_six ott
where (bigbigbig::numeric + iter::numeric)%check_bus != check_mod_result
)
,five_to_six2 as (select * from five_to_six order by bigbigbig desc limit 1)
,six_to_seven(bigbigbig,iter,check_bus,check_mod_result,bus_id_o) as (
select bigbigbig+iter, iter*check_bus as iter, mom2.bus_id as check_bus, mom2.mod_result as check_mod_result,mom2.bus_id_ordering
--        *
from five_to_six2 mom
left join mods_of_modes mom2 on mom2.bus_id_ordering = mom.bus_id_o + 1
-- order by mom.bigbigbig desc
-- limit 1
union all
select bigbigbig + iter, iter, check_bus, check_mod_result,bus_id_o
from six_to_seven ott
where (bigbigbig + iter)%check_bus != check_mod_result
)
,six_to_seven2 as (select * from six_to_seven order by bigbigbig desc limit 1)
,seven_to_eight(bigbigbig,iter,check_bus,check_mod_result,bus_id_o) as (
select bigbigbig+iter, iter*check_bus as iter, mom2.bus_id as check_bus, mom2.mod_result as check_mod_result,mom2.bus_id_ordering
--        *
from six_to_seven2 mom
left join mods_of_modes mom2 on mom2.bus_id_ordering = mom.bus_id_o + 1
-- order by mom.bigbigbig desc
-- limit 1
union all
select bigbigbig + iter, iter, check_bus, check_mod_result,bus_id_o
from seven_to_eight ott
where (bigbigbig + iter)%check_bus != check_mod_result
)
,seven_to_eight2 as (select * from seven_to_eight order by bigbigbig desc limit 1)
,eight_to_last(bigbigbig,iter,check_bus,check_mod_result,bus_id_o) as (
select bigbigbig+iter, iter*check_bus as iter, mom2.bus_id as check_bus, mom2.mod_result as check_mod_result,mom2.bus_id_ordering
--        *
from seven_to_eight2 mom
left join mods_of_modes mom2 on mom2.bus_id_ordering = mom.bus_id_o + 1
-- order by mom.bigbigbig desc
-- limit 1
union all
select bigbigbig + iter, iter, check_bus, check_mod_result,bus_id_o
from eight_to_last ott
where (bigbigbig + iter)%check_bus != check_mod_result
)
-- select bigbigbig + iter from five_to_six order by bigbigbig desc limit 1
select bigbigbig + iter from eight_to_last order by bigbigbig desc limit 1
;
