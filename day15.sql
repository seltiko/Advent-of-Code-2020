with recursive inputs as (
    select *
--     from regexp_split_to_table(
    from regexp_split_to_array(
$input$0,1,4,13,15,12,16$input$, ',') as said --WITH ORDINALITY as t(said, id)
-- $input$0,3,6$input$, ',') as said --WITH ORDINALITY as t(said, id)
)

,parsed as(
select
    *

from inputs i
)

,big_start as(
select *
from unnest((select said from parsed)) with ordinality as p(seen_value,last_seen_at)
    )
,test as(
    select
--            array[(array_agg(seen_value::text))::text[],(array_agg(last_seen_at))::text[]] as testing,
--            array_agg(array[seen_value::bigint,last_seen_at]) as testing2,
           array_agg(seen_value::text order by last_seen_at desc) as said,
           array_agg(last_seen_at::text order by last_seen_at desc) as last_seen_at
from big_start bs)

,old_saws2(said,bottles) as(
select
       coalesce( (array_positions(said,said[1]))[2] - 1, 0)::text||said as said,
       array_length(said,1) + 1 as bottles
from test p
union all
select coalesce( (array_positions(said,said[1]))[2] - 1, 0)::text||said as said,
       bottles + 1 as bottles
from old_saws2 p
where bottles + 1 <= 100
)
,slower_solution as(
select said[1],said
from old_saws2
where bottles = 9
)
,test2 as(
    select
           array_agg(seen_value::int order by last_seen_at desc) as said,
           array_agg(last_seen_at::int order by last_seen_at desc) as last_seen_at
--            array_agg(seen_value::text order by last_seen_at desc) as said
from big_start bs)

   ,new_saw(last_said,distance,last_seen_at,said,bottles) as(
select
--        '0'  = any (said),
       0 as last_said,
        case when 0  = any (said) then array_length(said,1)+1 - (last_seen_at[array_position(said,0)])::int else 0 end distance,
       case when 0  = any (said) then last_seen_at[1:array_position(said,0)-1]||(array_length(said,1) + 1)::int||last_seen_at[array_position(said,0)+1:]
           else last_seen_at||(array_length(said,1) + 1)::int
           end as last_seen_at,
--            last_seen_at,
       case when 0  = any (said) then said
           else said||0::int end as said,
       array_length(said,1)+1 as bottles
from test2 p
-- ;
union all
select
    distance as last_said,
    case when distance  = any (said) then bottles+1 - (last_seen_at[array_position(said,distance)])::int else 0 end distance,
       case when distance  = any (said) then last_seen_at[1:array_position(said,distance)-1]||(bottles + 1)::int||last_seen_at[array_position(said,distance)+1:]
           else last_seen_at||(bottles + 1)::int
           end as last_seen_at,
       case when distance  = any (said) then said
           else said||distance::int end as said,
       bottles+1 as bottles

from new_saw
where bottles + 1 <= 30000
)
select * from new_saw
where bottles = 30000
;
