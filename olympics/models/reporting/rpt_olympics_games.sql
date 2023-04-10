{{ config(materialized='table') }}


WITH summer_and_winter_games AS (
    SELECT * FROM {{ ref('stg_summer_games') }}
    UNION ALL
    SELECT * FROM {{ ref('stg_winter_games') }}
)

SELECT * FROM summer_and_winter_games
