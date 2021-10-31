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
select location,time_period,New_Deaths,population,death_rate,rank () over( partition by location order by death_rate desc,New_Deaths desc) as ranka
from
(
select table1.location,table2.time_period,table2.New_Deaths,population,table2.New_Deaths/table1.population as death_rate 
from table1
left join 
table2
on table1.location = table2.location
) as a
order by New_Deaths desc
)

select Location,time_period,New_Deaths,Death_rate from table3
where ranka = 1