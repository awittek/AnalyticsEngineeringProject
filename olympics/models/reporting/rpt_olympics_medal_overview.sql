{{ config(
    materialized='table'
) }}

{{ config(
    tags=["olympics"]
) }}


WITH rpt_olympics_games AS (
    SELECT * FROM {{ ref('rpt_olympics_games') }}
),

olympics_games_pivoted_by_medal AS (
    SELECT * FROM (
        SELECT
            name,
            gender,
            age,
            team,
            noc,
            games,
            year,
            season, 
            city,
            sport,
            event,
            medal
        FROM rpt_olympics_games
        WHERE medal IS NOT NULL
        )PIVOT
        (
        COUNT(medal) FOR medal IN ('Gold' AS gold_medal, 'Silver' AS silver_medal, 'Bronze' AS bronze_medal)
        )
)

SELECT * FROM olympics_games_pivoted_by_medal
