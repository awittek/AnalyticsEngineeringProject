{{ config(
    materialized='table',
     tags=["olympics"]
) }}

WITH rpt_olympics_medal_overview AS (
    SELECT * FROM {{ ref('rpt_olympics_medal_overview') }}
),

olympics_games_total_medals_per_athlete AS (
    SELECT 
        name,
        team,
        gender,
        SUM(gold_medal_total) AS gold_medal_total,
        SUM(silver_medal_total) AS silver_medal_total,
        SUM(bronze_medal_total) AS bronze_medal_total
    FROM rpt_olympics_medal_overview
    GROUP BY name, team, gender
),

olympics_games_weighted_average_per_athlete AS (
   SELECT 
        name,
        team,
        gender,
        gold_medal_total,
        silver_medal_total,
        bronze_medal_total,
        (3*gold_medal_total)/(1+2+3) AS gold_medal_weighted_average,
        (2*silver_medal_total)/(1+2+3) AS silver_medal_weighted_average,
        (1*bronze_medal_total)/(1+2+3) AS bronze_medal_weighted_average,
        (3*gold_medal_total)/(1+2+3) + (2*silver_medal_total)/(1+2+3) + (1*bronze_medal_total)/(1+2+3) AS total_medal_weighted_average
    FROM olympics_games_total_medals_per_athlete
)

select * from olympics_games_weighted_average_per_athlete
