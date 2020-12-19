
CREATE or replace FUNCTION pg_temp.dobadmath(text) RETURNS text
    as
$dobadmathfunc$with recursive finput as (
    select $1 as finput
)
,domath(remaining,iter) as(
select coalesce((case when (regexp_match(finput,'^\d+ ([\+\*]) \d+'))[1] = '+'
            then (regexp_match(finput,'^(\d+) [\+\*] \d+'))[1]::bigint + (regexp_match(finput,'^\d+ [\+\*] (\d+)'))[1]::bigint
            else (regexp_match(finput,'^(\d+) [\+\*] \d+'))[1]::bigint * (regexp_match(finput,'^\d+ [\+\*] (\d+)'))[1]::bigint
            end)::text||(regexp_match(finput,'^\d+ [\+\*] \d+(.*)'))[1], finput) as remaining,
       1::int as iter
from finput
union all
select (case when (regexp_match(remaining,'^\d+ ([\+\*]) \d+'))[1] = '+'
            then (regexp_match(remaining,'^(\d+) [\+\*] \d+'))[1]::bigint + (regexp_match(remaining,'^\d+ [\+\*] (\d+)'))[1]::bigint
            else (regexp_match(remaining,'^(\d+) [\+\*] \d+'))[1]::bigint * (regexp_match(remaining,'^\d+ [\+\*] (\d+)'))[1]::bigint
            end)::text||(regexp_match(remaining,'^\d+ [\+\*] \d+(.*)'))[1] as remaining,
       iter + 1
from domath
    where remaining ~ '[\+\*]'
)
select remaining::text from domath
order by iter desc limit 1;$dobadmathfunc$
    LANGUAGE SQL
    IMMUTABLE
    RETURNS NULL ON NULL INPUT;



CREATE or replace FUNCTION pg_temp.doworsemath(text) RETURNS text
    as
$dobadmathfunc$with recursive finput as (
    select $1 as finput
--     select '2 * 3' as finput
)
,domath(remaining,iter) as(
select
       coalesce(regexp_replace(finput,'\d+ \+ \d+',(case when (regexp_match(finput,'\d+ (\+) \d+'))[1] = '+'
            then (regexp_match(finput,'(\d+) \+ \d+'))[1]::bigint + (regexp_match(finput,'\d+ \+ (\d+)'))[1]::bigint
            else (regexp_match(finput,'(\d+) \+ \d+'))[1]::bigint * (regexp_match(finput,'\d+ \+ (\d+)'))[1]::bigint
            end)::text),finput) as remaining,
       1::int as iter
from finput
union all
select
       regexp_replace(remaining,'\d+ \+ \d+',(case when (regexp_match(remaining,'\d+ (\+) \d+'))[1] = '+'
            then (regexp_match(remaining,'(\d+) \+ \d+'))[1]::bigint + (regexp_match(remaining,'\d+ \+ (\d+)'))[1]::bigint
            else (regexp_match(remaining,'(\d+) \+ \d+'))[1]::bigint * (regexp_match(remaining,'\d+ \+ (\d+)'))[1]::bigint
            end)::text)as remaining,
       iter + 1
from domath
    where remaining ~ '\+'
)
select remaining::text from domath
order by iter desc
    limit 1
;$dobadmathfunc$
    LANGUAGE SQL
    IMMUTABLE
    RETURNS NULL ON NULL INPUT;



with recursive inputs as (
    select *
    from regexp_split_to_table(
$input$16: 95 7 | 53 12
41: 12 13 | 7 107
12: "a"
56: 17 12 | 129 7
102: 12 5 | 7 53
30: 105 7 | 26 12
66: 7 5 | 12 119
14: 27 7 | 109 12
62: 95 7 | 43 12
21: 12 12
23: 12 112 | 7 38
108: 7 43 | 12 21
80: 7 21 | 12 91
72: 7 41 | 12 89
117: 35 12 | 37 7
83: 7 91 | 12 5
13: 94 12 | 95 7
18: 7 62 | 12 87
24: 21 12 | 19 7
35: 7 81 | 12 113
8: 42
20: 12 27 | 7 1
120: 12 29 | 7 97
110: 107 7 | 102 12
7: "b"
32: 7 92 | 12 83
116: 12 40 | 7 98
86: 65 94
75: 12 118 | 7 119
46: 7 103 | 12 80
49: 109 7 | 57 12
95: 12 12 | 7 7
128: 7 19 | 12 5
19: 12 65 | 7 7
94: 7 12 | 12 7
99: 38 12 | 21 7
130: 7 6 | 12 116
76: 7 118 | 12 94
85: 7 67 | 12 126
104: 12 19 | 7 38
22: 44 7 | 24 12
79: 66 7 | 24 12
114: 70 7 | 115 12
27: 5 12 | 118 7
4: 7 91 | 12 21
105: 106 7 | 58 12
70: 18 7 | 2 12
33: 7 112 | 12 38
71: 53 12 | 93 7
87: 53 7 | 119 12
28: 7 64 | 12 16
63: 7 13 | 12 33
9: 57 7 | 36 12
34: 7 74 | 12 59
60: 7 108 | 12 86
67: 123 12 | 72 7
37: 52 12 | 71 7
112: 7 12
44: 12 5 | 7 118
26: 121 7 | 63 12
50: 127 12 | 48 7
15: 93 12 | 119 7
68: 112 12
78: 7 77 | 12 36
59: 49 12 | 22 7
109: 5 12 | 95 7
17: 38 12 | 119 7
54: 7 68 | 12 25
92: 119 12 | 94 7
123: 78 7 | 20 12
65: 7 | 12
129: 21 7 | 21 12
90: 12 112 | 7 95
98: 7 93 | 12 118
47: 12 93 | 7 21
2: 47 12 | 103 7
115: 125 7 | 56 12
25: 43 7 | 38 12
121: 7 23 | 12 99
36: 12 95 | 7 91
1: 7 118 | 12 91
113: 53 12 | 119 7
42: 12 85 | 7 50
6: 90 12 | 88 7
111: 5 12 | 5 7
69: 12 117 | 7 55
5: 12 7
106: 12 101 | 7 75
118: 7 65 | 12 7
77: 7 112 | 12 43
101: 53 7 | 38 12
31: 7 84 | 12 45
107: 53 7 | 118 12
119: 12 7 | 12 12
97: 119 7 | 112 12
57: 12 119 | 7 38
96: 7 98 | 12 4
100: 96 7 | 120 12
84: 12 114 | 7 30
64: 112 12 | 94 7
0: 8 11
52: 43 12 | 118 7
74: 12 28 | 7 79
58: 12 10 | 7 15
122: 12 104 | 7 29
127: 130 12 | 100 7
103: 21 7
81: 7 118 | 12 93
51: 122 12 | 9 7
10: 118 7 | 119 12
53: 12 7 | 7 7
89: 12 128 | 7 80
82: 12 32 | 7 60
124: 111 12 | 108 7
73: 19 7 | 5 12
3: 7 98 | 12 102
29: 38 12 | 5 7
126: 12 39 | 7 51
43: 7 12 | 7 7
125: 73 7 | 76 12
93: 65 65
11: 42 31
45: 12 69 | 7 34
39: 54 12 | 46 7
91: 65 12 | 12 7
61: 7 124 | 12 3
88: 91 7 | 19 12
38: 7 12 | 12 12
48: 61 12 | 82 7
55: 110 12 | 14 7
40: 112 12 | 43 7

abbbabaabbabaaabbbaabbbabaaabbabbabbbbbb
bbbbbabbababaabbbbaababbbbbaaabbaabaaaabaaabbbbabaabbbbbaabbabaa
bababbbababbabbbabbbabaa
abbabaaaaababbaaabaabbab
baababaaabbabbbbaaaabbbababaababaabbbabaaaabbbbb
abaababbabbaaaaaabbbabababaaaaab
aababbaaaababaaaaaabbbaa
bbbbababaaaababaababaaaa
babaaabaabaabaabaabbbbbb
bbbaaabbbababbabbbbbaaab
ababababaaaaaabbabaaabbb
aabbababbabaabbaabaababbbaabaabbbabbababaaabaababbbbaabbbaaaaabb
babbabbaabbabaaaabbabbbaaaabbbab
aabbababbbaaabbbbabbaabb
abbabbbaabaabaabaabbbbba
babaababbaabbbabababaabaaaabbaaababbabbaabbaaabbbbaaabba
baabbababbbabbaaaabbaaaabbbbaaaa
baabbabbbbaaabaaabababaabbabaaabaababbabbaaabaab
bbaaababaabbabbaababbbab
abbaaaaabbabbabaaabbabaa
baaaaabaaabaabbbabaababa
aaaaaaaaabaabaabbbaaabbbbabbabbbababbaabbbbaabaabbaaaabbaaababbbbbabaaba
bbbaaabaaabbbaaabbbabbaaaaaaaabbbbbbabbb
abaaabbbbbaaaaaabbbaabaa
abababbaababaababbbabbab
baaaaababbbbbbbbabaaabbb
aabbaabaaabbaababbbabaab
bbababababbbbbaaabbaaabbbbbbaaaa
aaaaaaaaabaaabaababbbababaaababbbbbaabaa
aabbbabbbbaabbbaabaabaaabbaababbaabbabaababbbabb
aaaabaababbaaabbbabbbabb
babbababbbbaabbaaabaabbbbabbbbabbaaabaabbabaaaab
babbaaaaababbbaababbaabb
abbbbaabbbbbbbbababbaaaaabbaabbbbbbabaaa
abaabaaaaaaabaabaaaabbbb
bababbbbaaababbbabbababb
ababbababbaababababbbbabaabbbaaaababbbbaaaabaaba
babaabaabbabaaabbbababab
babbabbabbaaaababbabbbbb
bbababaabababbbbbabbbabb
abaaaaabbabaabababaaaabaabaabbaabaaaababaababbaabababbbabaaaabbbabaaababaabbbaab
babaabbabbbabbaabbaaabba
abbabababababaaabbbaaababaababbbbbabbbaaabaaababaababaab
aaabaabbabbaaabbababbaab
baaaababaabbaaabbaabbbab
baabbababaabaaaaababbbaabbaaababbbababaaabbbbabb
bbababbabaabaabbbbaabababababbaaabbaaaaaaabbbbbb
bbbaaababaabaabbaaabbbba
bbabbaabbbababbabaaabbba
abaabbbbaabbabbabbabaaabaababaab
bbaabbbabbbbbabbabaababbaaabbbaa
abaabbaaaabbabababbbbbaaaabaaabbabaabbabbbaaaaab
babaabaabbbaabbabbabbaabbaabababbaaabaaa
bbababbbbbbabbbaaaaaababaabababbbbaaaaaa
aaaabbbbabbabbaaabbaaaba
aabbababbbbabbaaabababaabbabbbbabbbbaaba
abbbbaaabbbaaabaabaaabab
babaaaaabaabbaabbbbbbaababbaaaab
aaabaabbbabbababbaabbabbbbbababbabbababb
aaaabaaaaabbabababababbb
abbabaaabababbaaaaaaabaa
aabaaabbbabbabbaabbbbaabbabaabbbababaaaa
bbabbabbabaababbbababbbbaabbabababaaaabaababaaaaabbbaaababaaaaaa
ababaabbbababbabbababbabbaaabbbb
abaabbbababbbaabbababaaaabbbababbabbaaabaaababaa
bbbbbaaaababaababaaaaaaa
babbbaababbabaaabbaabbbababbbbaabbaabaaa
babbabbaabbbbabaaaababba
ababaabababbaaabbabaaaab
abaabbaabbbbbaaaabbabbaa
bababbbaabbabbbbaaaaabaa
abbabbbabbbaaabbaabaaabbbbbbbbbbaaaaabbaabaaabba
bbbaaaaabaabbbabaaaabbbbbbbaabab
bbaabbbaabbababaaabaabaa
aabbbabbbbbbababaabaabbbaaabaaaa
baabbababbbabbaabbaabbbb
abaaaababaaaababaaabaaaa
bbabbbbabaabaaaabaaababb
baabbbaaabababaabababbbaababaababbabbbbb
abbbababbaabbabbbabaabbb
abbabababababbbbaabbabbaabbaaaba
bbabbaabbbabbbbabbaaabba
babaaababaaaababaaabbbbb
baabababaaaaababaababbba
baabbbaabaaaabbabaaaaabbabababaaaababbbbaaabbaababaaaaaabababbbbbbbbabbaaabaaaba
baabababbabbabaabbababbaaaabbababbaabaaa
abaaaabbbabbaaabababbbab
baaaaababababbbababbbbbb
babbbbaabababbabaaababba
ababaabbbabbabbaababbabb
aabbaabbbbbbbabbbabbbbabbbbaabbaabbababb
bbbaaaaabaababbbabbabaabbbabbbaabbbaabbabaaabaabaaaabbbb
bbbaabbaaaaaaabbabbbabbbabbbabbaaaabbbbb
aabaaaabbabaabbaaabaaaaaabbbabababbbbabb
babbabaabababaaabbbbbbbbbaabbabbbbabbbaaaaaabbaa
babbabaababaabababbbbabb
aabbababbbbbbbbabaabbbababbabaabbabbbbba
abbbbaaabaababbbaabbabaa
baabbbabbbbbbabbababbbba
bbababaababbbaabbbbbabaa
aababbaaaababbabbbaabaab
abbbbaabbaaaabbaabaababbbaaaaabb
babbbababbbaababaaabaabbbabbabbababbabaa
abababbaabababaaaaaabbbb
bbaababaaaabaabbbbabbbab
bbbbababbbbbabbabbbaaababaaaaabb
babbbaaabaaaaabababbbaababbbbaababbbbaabbbbbaaaabbaaaabbabbbbabb
abababbabbbaaaaababbaaabbbaaabbbaabbbbaa
ababbababbabbbaaabbaaaba
bbaabbaaababaaabaababbaababbbbabbbbbaaaaabbbabba
aaaabbbababbabbbbbaabbaabaabbaabbbabaaba
abaabbaaabababbaabbbabaaababaaaa
aaabaabbaabaabbbaaabbbaabbaabaaabbbaaabbbbaaaabb
bbabbabbabbbbaabababbbbb
babaaabaaaaabaabbabababa
abbabaabbbabbababaabbbbb
bbbaabbaabbbbaabaabbbaaabababbaabbbabbaaaababbbb
aababbabaabaabbabbabbbbabaabbbbb
aaaabaaabbbaaabaaaabaaaa
babbbaaababaabbbbabaaaab
abbbabbbbabababbbbbbababababaaabbaaaaaabbbbbbaabbbabaabb
ababbabaaababbaababaababaabbaaba
babaabaaabaabaabaabbabbb
babbbbaaabbaababbaabbaabbbbbbbbbbabbaabababaaaaabbbabaaabbaabaab
aabaaaabaaaabbbbaabaaabbbaabaaabababbbbbbbbaaabbbbabbaabbabbbaba
aabaaaabbbaabababbaabbaaabaaabbbbaaabbab
bbabbabaabbababaabaababa
abaaabaaabaaaaabbaaaaaaabbbabaabbbbbaaba
bbbbababababbababbaabababaababbbaababaaabbabaabbbbaabaaabbaabbbbbbabbbbb
baaabbaabbbabbabaabababaabaababaaaabbabb
babbbbaabbbabbbaaaabbaaabbbaaaab
abbbbabaabbabbbabbbaabbb
aaaababababbabbbabbaabbbbabaaaabbaaabbababaaabbaaababbbb
abbbbbabaababaaaaaabababbaaabaab
aabababaaaababaabaaabbaaababbaaa
aabbbaabbabaababbbabbabbbbbbbaaabbbbbbbaabaaabbb
abaabbbabbabbbbaaaaaabaa
bbabababbbaabaaaaaababababbbbbbaabbbaaabbbabbaabbaababab
aaaabbbabaabbabbabaaabbb
baabaaaaaabaabbabbbaabbbbaaaaaaaabaababa
aaaabaababbbbabababbaaaaaabababa
bbbbabaabababbaaaaaaababbaaabaaaaaaabbab
bbbaaababaaaababbabbbbabbbaabaab
aabbbabbabbaaabbbbabaaaabbbbaaab
abaaabbbaaabaaaabaaababbbbbaaabaabbbbbbbaaaaaabbbabaabbaabababaa
aaaabaaababbabbbabbababaabbbbbbbaaabaaaaaabbbbab
abbbbababbbbabaababaabaabbaaaaaa
aabaaabbaaaaabababbaaaba
baaaabbbbaabbbabbabaabbabbbbaaaa
baabbbabbaabbbaababbaaaabbbabbaaabbaaabaaaabaaba
bbbaaaabbabaababbbaabbbbaabaabbababaaabbbabbabbaabbabaabbbabaaab
aabbaaaabababbbabbbbaaba
abaabbbaabbbabbbabaaaabaabbaaabaababbabb
aaaaaabbababababaaaabaaaaaabbbbb
aabbaaaaaaaababaaaaabaaabaababaaaababaab
baabbbaabbbaaabbaaabbaab
aaaaaaababbaaaaabbababbbaaaaabbaaaaababb
aaaabaababaabaaaaabbbaaaabababbaaaaabaabbbbabaaa
abbbbbababaabbbabababbaabababbbabbbbaabaabaabbab
bbaaabbbababbabababbaaabaaaabbaaaaaababb
aaaaaaaabbabaaababbabbbaabbaaaaaaaabbbaabbbbabbb
babbabbaaabaaaaaabbbbaaabbabbbbbaabababa
baabbbabaababbaaaaabbabb
bbabaaabaaaaaaabbbabbbbaaababaab
aaaaaaaababbaaaabbaaabba
aabbabbabbbaaaaabbbaabbaaaaaabaaaaabbbab
babaabaaabaabbaaabbbbaaabbbaaabaabbabaaaaabbabaabbbababa
bbabbbbaaabaaaaaaaaabababbbbbbbbbbbaaabbaababbbaabbbaaaaabbbabba
baababbbbabbabbabababbabbbbbbbabbabaabbb
ababbaabbababbbaaabbaaabaabbaaababbabbab
aabaabbbaabaaabbabbbbbabaaabbbbb
aababaaababbaaabbaaabbaa
aaabbaaabbbaaabbababaaaa
bbbabbaabaabbabbaabaabbbaababbabbbabbbab
aababbabaaabbaaabbaaaaba
aabbbaaabbbbbbbabaaaabbbbaabaaabaaabbbbb
bbbaabbaabbbabbbbabbabbbabbaaaaababaabbb
abbaababbabbbaabbababbbaaaaaaabbababbaaa
aababbaaabbbbaaabababaabababbaabbaabbbbb
babbabbabbabbbaaabbbababbbaabbbaaababbaaaababbbaaaababaa
babbbbabbabababbbbbaabbabaabbababababbbabbbbababaaabababaabaabab
bbbbbaababbbbabbbaabbaaaaabbabaaabbababb
abaaaabaaabbabbaaaabbabb
bbaabbaabbbabbaaaaaaaaaabbbbaaba
abbbbabbaaabaaaaabbbbabaaabbbababbaaaaaabbaaaaaabbaaabba
bbbbbbbabababaabbbbaaabaabbbaaabbaabaaba
bababaaababbbbababaaabbb
babbabbbbabaaabbaabbabbababbbaabaaabbbabbabaaaaa
ababaababaabaaaaaabbbaabbabbaaba
bbabbabbabaabbbbabbaaabbaaaabbaaabababbb
abaaaabababbabaabbaaabbbaabaaabbbbabbaabbbbbbaba
bbbbaaababaaabaabbbbaaba
aaaaaabbaaaabaaaaaababab
bbabbababbababbbaabbbbab
bababbbbbaabbbababaaaabbabbabbaa
bbbaaaaabbaaabbbbabababa
abaabbbaabbbbaaabbbaaaaababbbabbaaabaaaa
ababaabaaabbababbaabbaab
bbbbaaabbaaaaaabbbaaaaaa
bbbaaabbbbaaabaaaabbbaabbbbaaaab
baabbabbbababaaabababbabaabaaabbaaaababbbbabbbbbbbbaabbb
abbabaabababbabaabaabbaa
aaabaabbbaaaaabababaaaba
bbaabbbaaaaabbbaaabaaababaabbbbaaaaababb
bababaaaabbbbaaabbaaaaab
abbabbbbbbaabbaaabbbaabb
babbabaaababababaabaabbabbbaabab
aaaaaaaaaaaabbbabbbabbab
abbabbbaabbabaababaaabbb
bbaabababaababaabbbbabbaaaababbb
abbaababbabaaababbbabbbaabbbbaababaaabbbabbbabbaabaaababbaaabbbbbabbbbba
abbbbbabbababbbbbbaabbab
aabaabbabaabaabbbbaaabba
abbabbbbabbbbbbbababbabb
abbbbaababaabaaaaaaaaaabbabbaaba
aaaaaaabbabaabaabaaaababbbabbababaaabbaa
aabaaaaaabaaaabababbbbbb
aaaabbbaaabbaaabaabaaababbabaabb
bbabbabababbbaabbbabaaba
abbbabbbaabaabbbabaababbbaaaabbaabaabaabbaaabababaaaaabbbbbaabaa
bbabaaabbbbabbaaaabaaaabaabbbbaa
abbbbbbbabbabbbbbbaabaaa
bbbbabaaaabbababababaaaa
babbbbaaaabaaabaabaabbaabbabaaaabbababaaaabbaabbaabbbaba
bbabbbaaabbbababaaabbaba
bbbbaabaaababababbaabaab
bbbabbbabbabbabbabaaaababaaabbab
baaaababbaaaabbbbbbbababaaabaabbaaaaabaa
baaaaababbbbbabbbbbababa
bbabaaaabbabbabababaaabbaaabaabbbaabbbba
bbbabbaaaabbabbabbbbaaaa
abaabbaabbaababbaaabbaaabbbbaaaa
babaabbaaaaaababbaabbabaaaaabaaabaabbaababbaaababaabbaaa
ababaaabbababbaababaabaaaaaaabaabaabbbba
babbbaabaababaaaaabaaabbbbabbbbb
babbaaaabababbbabbbaabbb
abaabbaabbaababaabbabbab
abaabaaabbabbabbbbaaabbbaabbbaaaaaaaabaa
aabbbabaababaabaaaabbabb
abaabaabbbbbbaaabbaababaaabaaaabbababbaaababbabb
abbaabaababaaababbaabbbb
abbbabaabbabaaabababbbbb
aababbbbaabaabbababbabaabaababaabbabaabb
bbabaaabababbaabbabaabaababbabbabbbbbabaabaaababbbbaaaab
aaaabbbabbbabbaaababbbaabbbabbab
abaabbbbbbaabbbbaabbaabbaabaabaaaaabaaabbabbaaaabaabbbbabbaabbab
babbabbbbababaabaaabbaaaaabbabaaabaaabbb
baabbabaaaaabaaabbbaabaa
bababbbbbbbbababbbabbaaa
aabbbaaabbbaabbaaabbbbba
aababbabaaaaabababaaabbb
babbbbabbaaaaabaababbaaa
bababbaababbabbaaaabaabbbbabbbaaaabbbbbaabbaabbabaababba
baabbabbabbaabaababbababbbababbbbabbabbaaababbbaaababbbb
bbbbabaabbabbabbababaaababbbbbaaaabbbaabbbbbbbaa
aabbababbbbbbaabaabbabaababbaabababaaaabbaaaaaab
aabaaabbbababbabbabaabbb
bababbbaabababaabbabbbab
abbabaaaaaabaaaabaaaabaabaaabbbb
abababbabaaaaabaaaabbaab
aaaabbbababaaabaaabaabbaaabbababaaaaabaa
babbbbaaabbabbbbababbbaababaababbbbaaababbabbaaaababbbbbaaababab
baabababbaababbbaabbbabbbbabaabb
aabbabababbaaabbbabbbbabbabaabababbaaaaaaaababbb
aabaaabababaabbabaabbaab
abbbbaababbbababaaabbaba
babaabbaabbaaabbbaaababa
ababbaabbbaabbbaabbbbbbb
bbbbbabbbabbbaaabbaababbabbbaabbbaabbaaa
bbaabbaaaabbabbabbabbaabbbaaabaabbbaabbbbbaaaabbabbbbabb
aabbaabbabbabbbbaaaaabababbbbabbbbbabbab
aabbbaabbbbaaabbbaaaababaaaabbbaaabbbbab
ababbaabbabbbabaaabaababbbbbbaab
bbbbbbbaaabbabbabaabaaba
aabaaabaabbbababbabbaaaabbaabaabaaaabbaa
bbbbbbaaaaabaaabaabbbaabbabbabbabbaabbabaababbba
abaabbbaabaabaaabbaaabaabababbaaabaaabab
abbabaaaaabaaaababbbbaaabbbaaaaaabbbabaabbbaabaa
abaabbbabaaaabbbabbbbaaabbbaaaab
aabaababbaabaaaabbababbbbbabbbbbbbbbabbbabbbabbbaaaaabababbaabbb
aababbaababbaaabaaabaaab
aabbaaababaababbabbbababbaaaaabaaaaaabbababaaaab
abbbabaabbbabbaabbbbbbbbabaabbbbabbbabbbabbbbaaaaabbbbbabaaaaaabbaaabbbabbbbaaba
ababbabaabbaababbaaaabbabaaababaabbaabbabaaababaabbbbbba
baabaabbbbbbbbbbaabababbbaaabbaaaaababaabbabaaab
babbbaababbbbbaaaabaabbbbaabbabbbbbaaabababaabaaaabbabaa
abaabaaaaaababbabbaaabbbbababbabbababababbbaabbaaaababbabaaaabbaaaaabbabaabbaabbbbaabbabbbaabbbb
abababaabababbbbabaaaababbababaaabbbbbbaabbbaaaa
babbbaabaaabaabbbabaabbb
abbabaaaaabbaaabbbaaabbbbbbbaaab
aabbbaababaaaabbaaaababbabaababaabbbbbababaabbbabbbaabaa
aaaabaaaabaabaaaaaabaaab
aaabbaaaaabaaaaabbaaaaaa
bababaaabbbaaaaaabaabbbbaabaaaababbbbabbaabbabbb
abaabbaaabbbbbabbbaaababbbabbbabaaaaaaba
aabaaabbbaabbbabbaaababb
abbabaaabbbaaabbbabbbabb
aaaabababbababbaaababbaabbbabbbb
baaaaababbbbbbbabbbaabbb
baaaaabaabbabaaabbabaaabbabaabaa
abaaaabaabbabaaaabbbaabb
abaabbaabaaaabbababaaabaaaaabbab
babbbaaaabababbaaabbbaababababbb
abbabbbaabbbbababaabaabbbbaaababbbbaababbaaabbaa
aabaabbbaabbaaababaabbababbbabbbbbbbbabbbbbaababaaaaabababbbbabbbbabbbabbaaabaaabaaababa
babbabaabaabbabbbbaabbbabbbbbbab
abbbbaababaaaababababbbbbabbabbbaaabbaaabbbabaab
bbbaaaaaabbabaabababbbaaaaabaabbbaaaaabb
bbbabbaabababbabaabaabbabbaaaaab
abbbabaabbbaaababbaabbab
babbaaababbbbbabbbbabbab
bbaabbbabbbbbbbabbababaabbbaaabbabbaaabaababbbbb
bbbbbbabaabaaaabaaabbbba
babbaaababaaaabbaababbabbbaababbbbaabbbbbabbaaba
aaaababaaaaabaaabbaabbaababaaabaaabbaaaaaabbbaaaaaaaabbbbbbababaabaaabbb
abbaababaabbaaaabababaaababbabbaaabaaaabaaababbaaabbbbba
abababbaaabbaaaaabaabaabbbbbabbaaaababba
bbbbbbbaabababbaaaabaaaa
babbbabbbaababbaaababbbaaababbbbbabaaaabaaaaaabaaabaaabbabababbbbbbaaabbaababaaababbaababbbbbaaa
aaabaabbbbababbbaaaaaabbaaabbbaabbbaabab
abbaaaaaaabababaaaababab
bbabbbaaaaaaaaaabaaaabbbbaaaababbbbbbaab
bbabbbbaabbbbaaabbababaabbbbababbbabaaabaaaaabbbabaaababbbbabbbb
bbababbabbbabbbabbbababb
aaaaaaabbabbbbaaababbbab
baababaabababbbaababbbaaabaababa
ababbaabaaaaababababaabaabbbbaabbabbbbabaaabbababaaaaabbabbbaaabababbbba
bbbaabbabababbabbaabbbba
aabaabbaaaaabaaaaabaaaaaaabbbaababbababaabaaaaab
abbbabaabaabababbbababab
babaababbabbbbababbbbaaabababbabbbbbabaaaaabaababbbbabbb
abaabaaaaababbaaaaaababb
abbabaabaaabaabbbbababab
aaaabaabbaabbbaaaabbabbaaaabbabb
bababbbbabaababbaabbbbbb
babbaaaabbababbbaababbbb
bbbbbbbbabaabaabbbaaaaba
babaabbabababbbbaaabbaab
aabbabbaababbbaabbaaaabb
babbaaababbbbbaabbbabbbababaaaab
babbbbabbababbabbbaabbab
bbbaaaaabababaaababbbbba
abbababaabbaaabbaababbba
baaaababaabaaabaabbaabaabbabaabb
babbaaabbababaaababaabababababbababbbbaabbaabaaaabbbaabb
babaaabbaabaaabbaabbbabbabbbbbba
aabbabbabaabaaaabbbaabab
bababaaaaabbbaaaabbbabaabbbbbbabbaaabbab
abbaabaaaabbaaabbabbbbbaabbabbbabaabbaba
abbbbaabbaabaabbbaaaabbaaaabababbaaabbaaaaababbabaaababb
abbbbaabaaaaaaaaabababaababaaabbabaaabababbabbaa
aaaabaaaabbbbaaaabaabbab
baababbbbbbabbbabbbbaaaa
bbaabbbabaaaababbababbabaaabbaaaabaaabba
aababaaababaabaaaabaabbbbabbbbbb
bbabbbbabbabaaaaabaabbbabababbaaabaaaaababbaaaab
babbaaaaaabaabbabbbbbabbaaaaaaaabbababababaababa
bbbabbbaabbbbaababbaaabbababbaabaabbababbbabbabaaabbaabababaaaab
abbaababbbbaaabbbabbbbba
ababaaabbbabbaabbabaaabbaaabbbba
bababbabaabbaaaaababaabbbabbabbbbbabbbaaaabababababbbabaaaabbbbaababbaaa
aababaaababababbabaaabba
bbaababbabbabaababbbbaababbabaaaabaaaabbaaabbabbabbbaabaaabababbaabbbbbb
abbbabbbaabbaababbababbbbaabbabbbababaaaabababaababbaaaabaabbaaabbabbbbaababbbbb
$input$, '\n\n') WITH ORDINALITY as t(rowrow, baseid)
)
,parsed as(
select i.*,
--        p.elementid - 1 as elementid,
       (regexp_match(element,'^(\d+):'))[1]::int as elementid,
       element as rawelement,
       regexp_replace(element,'(^\d+: )|\"','','g') as element,
       regexp_replace(element,'(^\d+: )|\"','','g') !~* '\d' as base_element_flg
from inputs i
left join lateral(
    select *
    from regexp_split_to_table((select rowrow from inputs i9 where i9.baseid = i.baseid),'\n') with ordinality as t(element,elementid)
    ) p on true
)
,reparsed as(
select i.rowrow,
       i.baseid,
       i.elementid,
       i.rawelement,
       i.element as lessrawelement,
       regexp_split_to_table(element,' \| ','') as element,
       (select max(char_length(element)) from parsed p9 where p9.baseid = 2) as max_length
from parsed i
where baseid = 1
)
-- select * from reparsed;
,ruless(elementid,element,iter) as(
select p.elementid,
       regexp_replace(p.element,p2.elementid::text,p2.element) as element,
       1::int as iter,
        max_length
--        *
from reparsed p
left join lateral(
    select p2.elementid,p2.element
    from reparsed p2 where p.element ~ p2.elementid::text and p2.baseid = 1
    and p2.elementid = (regexp_match(p.element,'(\d+ )|( \d+)'))[1]::int
    ) p2 on true
where p.baseid = 1
  --part 2 change
    and p.elementid in (31,42)
    --end part 2 change
union all
select p.elementid,
       regexp_replace(p.element,p2.elementid::text,p2.element) as element,
       iter + 1,
        max_length
--        *
from ruless p
inner join lateral(
    select p2.elementid,p2.element
    from reparsed p2 where p.element ~ p2.elementid::text and p2.baseid = 1
    and p2.elementid = (regexp_match(p.element,'((\d+ )|( \d+))'))[1]::int
    ) p2 on true
where 'yes'
    and p.element ~ '\d'
    )
,final_rules as(
select *,
       regexp_replace(r.element,' ','','g') as cookedelement
from ruless r
where r.element !~ '\d'

)
select *
into temp table temp_final_rules2
from final_rules;
select p.elementid,
       p.element into temp table temp_parsed
--     ,fr.cookedelement
from parsed p
-- inner join final_rules fr on p.element = fr.cookedelement
-- inner join temp_final_rules fr on p.element = fr.cookedelement
-- inner join temp_final_rules3 fr on p.element = fr.cookedelement
where p.baseid = 2
;


select (regexp_match('a 12 126 11','((\d+ )|( \d+))'))[1]::int,
       regexp_replace('a 12 126 11', '12','g','g')
;
drop table if exists temp_final_rules;
drop table if exists temp_final_rules2;
drop table if exists temp_final_rules3;
drop table if exists temp_parsed;

-- create temp table temp_final_rules3 as
select fh.first_half||sh.second_half as cookedelement
from(
select * ,(generate_series(2,floor(max_length * 1.0/char_length(cookedelement)))) as repeatss,
       repeat(cookedelement,(generate_series(2,floor(max_length * 1.0/char_length(cookedelement))))::int) as first_half,
       generate_series(2,floor(max_length * 1.0/char_length(cookedelement))) * char_length(cookedelement) as first_half_length
from temp_final_rules2 t
where t.elementid = 42
) fh
inner join (
select * ,(generate_series(1,floor(max_length * 1.0/char_length(cookedelement)))) as repeatss,
       repeat(cookedelement,(generate_series(1,floor(max_length * 1.0/char_length(cookedelement))))::int) as second_half,
       generate_series(1,floor(max_length * 1.0/char_length(cookedelement))) * char_length(cookedelement) as second_half_length
from temp_final_rules2 t
where t.elementid = 31
) sh on sh.second_half_length + fh.first_half_length <= fh.max_length
    and sh.repeatss+1 <= fh.repeatss
;



create temp table temp_final_rules3 as
with recursive first_half(cookedelement,repeats,half_length) as(
select cookedelement,
       1 as repeatss,
        char_length(cookedelement) as half_length,
       max_length
from temp_final_rules2 t
where t.elementid = 42
union all
select fh.cookedelement||t.cookedelement,
       repeats+1,
       char_length(fh.cookedelement||t.cookedelement),
       fh.max_length
from first_half fh
cross join temp_final_rules2 t
where t.elementid = 42
    and char_length(fh.cookedelement||t.cookedelement) < fh.max_length
    )
,second_half(cookedelement,repeats,half_length) as(
select cookedelement,
       1 as repeatss,
        char_length(cookedelement) as half_length
from temp_final_rules2 t
where t.elementid = 31
union all
select fh.cookedelement||t.cookedelement,
       repeats+1,
       char_length(fh.cookedelement||t.cookedelement)
from second_half fh
cross join temp_final_rules2 t
where t.elementid = 31
    and char_length(fh.cookedelement||t.cookedelement) < max_length
    )
select fh.cookedelement||sh.cookedelement
from first_half fh
inner join second_half sh on sh.half_length + fh.half_length <= max_length
;

with recursive testing(element,reducedelement,left_removals) as (
select p.element,
       left(right(p.element,-8),-8) as reducedelement,
       1 as left_removals
from temp_parsed p
where exists(
    select cookedelement
from temp_final_rules2 t
where t.elementid = 42
    and p.element ~ ('^'||t.cookedelement)
          )
    and exists(
    select cookedelement
from temp_final_rules2 t
where t.elementid = 31
    and p.element ~ (t.cookedelement||'$')
          )
union all
select p.element,
       right(reducedelement,-8),
       left_removals + 1
from testing p
where exists(
    select cookedelement
from temp_final_rules2 t
where t.elementid = 42
    and p.reducedelement ~ ('^'||t.cookedelement)
          )
)
,testing2(element,reducedelement,right_removals,left_removals) as (
select
    p.element,
       left(p.reducedelement,-8),
       1 + 1 as right_removals,
       p.left_removals
from testing p
where exists(
    select cookedelement
from temp_final_rules2 t
where t.elementid = 31
    and p.reducedelement ~ (t.cookedelement||'$')
          )
    and p.reducedelement <> ''
    and p.left_removals > 1
union all
    select
    p.element,
       left(p.reducedelement,-8),
       right_removals + 1 as right_removals,
       p.left_removals
from testing2 p
where exists(
    select cookedelement
from temp_final_rules2 t
where t.elementid = 31
    and p.reducedelement ~ (t.cookedelement||'$')
          )
    and p.left_removals > right_removals + 1
)
select * from testing;

select distinct element from(
select element from testing2 t2
where t2.reducedelement = ''
union
select element from testing t
where t.reducedelement = '')t
-- order by element,left_removals desc

-- 308 too high, 227 too low
