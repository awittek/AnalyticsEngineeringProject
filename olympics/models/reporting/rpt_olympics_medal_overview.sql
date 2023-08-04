{{ config(
    materialized='table',
     tags=["olympics"]
) }}

WITH rpt_olympics_games AS (
    SELECT * FROM {{ ref('rpt_olympics_games') }}
),

olympics_games_pivoted_by_medal AS (
    SELECT * FROM (
        SELECT
            gender,
            sport,
            medal
        FROM rpt_olympics_games
        WHERE medal IS NOT NULL
        )PIVOT
        (
        COUNT(medal) FOR medal IN ('Gold' AS gold_medal, 'Silver' AS silver_medal, 'Bronze' AS bronze_medal)
        )
),

olympics_games_grouped_by_gender_and_sport AS (
    SELECT 
        gender,
        sport,
        SUM(gold_medal) AS gold_medal_total,
        SUM(silver_medal) AS silver_medal_total,
        SUM(bronze_medal) AS bronze_medal_total
    FROM olympics_games_pivoted_by_medal
    GROUP BY gender, sport
)

SELECT * FROM olympics_games_grouped_by_gender_and_sport
