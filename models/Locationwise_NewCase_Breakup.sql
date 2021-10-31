{{ config(materialized='table') }}
select concat(month_a,'-',year_a) as TIME_PERIOD,Location,New_Cases,New_Deaths,New_Recovered,New_Active_Cases
from
(
select month(to_date(date)) as month_a,year(to_date(date)) as year_a,Location,sum(New_Cases) as New_Cases,
sum(New_Deaths) as New_Deaths ,sum(New_Recovered) as New_Recovered,sum(New_Active_Cases) as New_Active_Cases
from "FIVETRAN_INTERVIEW_DB"."GOOGLE_SHEETS"."COVID_19_INDONESIA_SOUMYAJIT_DUTTA"
group  by month(to_date(date)),year(to_date(date)),Location
)