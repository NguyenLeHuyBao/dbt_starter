WITH dim_ship_method AS (SELECT *
                         FROM {{ref('stg_dim_ship_method')}})
SELECT *
FROM dim_ship_method