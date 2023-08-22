{{ config(
    materialized='view',
     tags=["olympics"]
) }}

WITH rpt_olympics_medal_overview AS (
    SELECT * FROM {{ ref('rpt_olympics_medal_overview') }}
),

rpt_olympics_top_10_athlete AS (
    SELECT 
        name AS athlete_name,
        team AS country,
        gender,
        sport,
        SUM(gold_medal_total) + SUM(silver_medal_total) + SUM(bronze_medal_total) AS medal_total
    FROM rpt_olympics_medal_overview
    GROUP BY name, team, gender, sport
    ORDER BY medal_total DESC
    LIMIT 10
)

SELECT * FROM rpt_olympics_top_10_athlete
