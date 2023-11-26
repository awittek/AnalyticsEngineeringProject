{{ config(
    materialized='table',
     tags=["olympics"]
) }}


WITH raw_countries AS (
  SELECT * FROM {{ ref('raw_countries') }}
),

renamed AS (
 SELECT 
    {{ dbt_utils.generate_surrogate_key(['contry_name', 'country_short_code', 'country_long_code', 'country_numeric_code']) }} AS id,
contry_name,
country_short_code,
country_long_code,
country_numeric_code,
iso,
region,
sub_region,
intermediate_region,
region_code,
sub_region_code,
intermediate_region_code
 FROM raw_countries
)

SELECT * FROM renamed
