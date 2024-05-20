WITH fct_sales_source AS (SELECT *
                          FROM {{ref('stg_fct_sales')}})
SELECT *
FROM fct_sales_source