WITH fct_purchase AS (SELECT *
                      FROM {{ref('stg_fct_purchase')}})
SELECT *
FROM fct_purchase