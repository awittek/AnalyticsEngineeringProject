{{ config(materialized='table') }}

WITH stg_summer_and_winter_games AS (
    SELECT * FROM {{ ref('stg_summer_games') }}
    UNION ALL
    SELECT * FROM {{ ref('stg_winter_games') }}
),

games_pivoted_by_medal AS (
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
        FROM stg_summer_and_winter_games
        WHERE medal IS NOT NULL
        )PIVOT
        (
        COUNT(medal) FOR medal IN ('Gold' as gold_medal,'Silver' AS silver_medal ,'Bronze' AS bronze_medal)
        )
)

SELECT * FROM games_pivoted_by_medal