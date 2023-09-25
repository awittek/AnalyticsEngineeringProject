{{ config(
    materialized='table',
     tags=["olympics"]
) }}

WITH raw_winter_games AS (
  SELECT * FROM {{ ref('raw_winter_games') }}
),

renamed AS (
 SELECT 
    {{ dbt_utils.generate_surrogate_key(['id', 'name', 'sex', 'team']) }} AS id,
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
 FROM raw_winter_games
)

SELECT * FROM renamed
