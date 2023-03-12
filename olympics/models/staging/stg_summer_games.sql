WITH olympics_summer_data_source AS (
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
 FROM {{ref('raw_summer_games')}}
)

SELECT * FROM  olympics_summer_data_source