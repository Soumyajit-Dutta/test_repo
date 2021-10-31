
{{ config(materialized='table') }}

select distinct Location,population,POPULATION_DENSITY,Total_Regencies,
Total_Cities,Total_Districts,Total_Urban_Villages,Total_Rural_Villages
 from "FIVETRAN_INTERVIEW_DB"."GOOGLE_SHEETS"."COVID_19_INDONESIA_SOUMYAJIT_DUTTA"

