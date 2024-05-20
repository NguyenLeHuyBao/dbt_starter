WITH dim_customer_source AS (
    SELECT *
    FROM {{ref('stg_dim_customer')}}
)
SELECT * FROM dim_customer_source