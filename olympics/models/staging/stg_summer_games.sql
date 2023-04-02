{{ config(materialized='table') }}


WITH raw_summer_games AS (
  SELECT * FROM {{ ref('raw_summer_games') }}
),

renamed AS (
 SELECT 
    id,
    name, 
    sex AS gender,
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
 FROM raw_summer_games
)

SELECT * FROM renamed
