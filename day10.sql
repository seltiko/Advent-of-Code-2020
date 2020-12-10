with recursive inputs as (
    select *
    from regexp_split_to_table(
$input$56
139
42
28
3
87
142
57
147
6
117
95
2
112
107
54
146
104
40
26
136
127
111
47
8
24
13
92
18
130
141
37
81
148
31
62
50
80
91
33
77
1
96
100
9
120
27
97
60
102
25
83
55
118
19
113
49
133
14
119
88
124
110
145
65
21
7
74
72
61
103
20
41
53
32
44
10
34
121
114
67
69
66
82
101
68
84
48
73
17
43
140$input$, '\n') WITH ORDINALITY as t(jolts, id)
)
,parsed as(
select
       jolts::int,
       id
from inputs i
)
,laggy as (
select *,
       lag(jolts,1) over(order by jolts) as previous_jolt,
       jolts - coalesce(lag(jolts,1) over(order by jolts),0) as differences
from parsed p
order by jolts

)
,part1 as (
select count(case when differences = 1 then 1 end) as ones,
            (count(case when differences = 3 then 1 end) + 1) as threes,
        count(case when differences = 1 then 1 end) *
            (count(case when differences = 3 then 1 end) + 1) as answer
from laggy l
)
,regimes as (
select *,
       count(case when differences = 3 then 1 end) over(order by jolts) as regime
from laggy l2
)
,regime_sizes as(
select regime,
       count(*) - case when regime <> 0 then 1 else 0 end as regime_size
from regimes r
group by 1
having count(*) - case when regime <> 0 then 1 else 0 end > 1
)
select 'part1'::text,
       answer
from part1
union
select 'part2',
       2^sum(case when regime_size = 2 then 1 else 0 end) *
       4^sum(case when regime_size = 3 then 1 else 0 end) *
       7^sum(case when regime_size = 4 then 1 else 0 end) *
       13^sum(case when regime_size = 5 then 1 else 0 end) *
       24^sum(case when regime_size = 6 then 1 else 0 end)
from regime_sizes
;
