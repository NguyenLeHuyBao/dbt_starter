WITH sales_territory_source AS (
    SELECT *
    FROM {{ref('stg_dim_sales_territory')}}
)

SELECT * FROM sales_territory_source