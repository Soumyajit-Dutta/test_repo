{{ config(materialized='table') }}

with table1 as 
(select location,population
from {{ ref('Location') }}
),
table2 as 
(select * from 
{{ref('Locationwise_NewCase_Breakup')}}
),
table3 as
(
select location,time_period,NEW_CASES,population,new_infection_rate,rank () over( partition by time_period order by new_infection_rate desc,NEW_CASES desc) as ranka
from
(
select table1.location,table2.time_period,table2.NEW_CASES,population,table2.NEW_CASES/table1.population as new_infection_rate 
from table1
left join 
table2
on table1.location = table2.location
) as a
order by NEW_CASES desc
)

select Location,time_period,NEW_CASES,new_infection_rate from table3
where ranka = 1