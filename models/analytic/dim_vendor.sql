WITH dim_vendor_source AS (SELECT *
                           FROM {{ref('stg_dim_vendor')}})
SELECT *
FROM dim_vendor_source