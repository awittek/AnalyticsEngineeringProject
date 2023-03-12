WITH olympics_winter_data_source AS (
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
 FROM {{ref('raw_winter_games')}}
)

SELECT * FROM  olympics_winter_data_source