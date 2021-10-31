{{ config(materialized='table') }}
select concat(month_a,'-',year_a) as TIME_PERIOD,Location,Total_Cases,Total_Deaths,Total_Recovered,Total_Active_Cases
from
(
select month(to_date(date)) as month_a,year(to_date(date)) as year_a,Location,max(Total_Cases) as Total_Cases,
max(Total_Deaths) as Total_Deaths ,max(Total_Recovered) as Total_Recovered,max(Total_Active_Cases) as Total_Active_Cases
from "FIVETRAN_INTERVIEW_DB"."GOOGLE_SHEETS"."COVID_19_INDONESIA_SOUMYAJIT_DUTTA"
group  by month(to_date(date)),year(to_date(date)),Location
)