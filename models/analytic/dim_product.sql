WITH product_source AS (SELECT *
                        FROM {{ref('stg_dim_product')}})

   , product_type_casting AS (SELECT product_key
                                   , product_name
                                   , product_number
                                   , safe_cast(make_flag AS string)                AS make_flag
                                   , safe_cast(finished_goods_flag AS string)      AS finished_goods_flag
                                   , safe_cast(product_subcategory_key AS integer) AS product_subcategory_key
                                   , product_subcategory_name
                                   , product_category_key
                                   , product_category_name
                                   , safe_cast(product_model_key AS integer)       AS product_model_key
                                   , product_model_name
                                   , safe_cast(size_unit_measure_key AS integer)   AS size_unit_measure_key
                                   , size_unit_measure_name
                                   , safe_cast(weight_unit_measure_key AS integer) AS weight_unit_measure_key
                                   , weight_unit_measure_name
                                   , color
                                   , safe_cast(weight AS FLOAT64)                  AS weight
                                   , `size`
                                   , safe_cast(safety_stock_level AS BIGNUMERIC)   AS safety_stock_level
                                   , safe_cast(standard_cost AS FLOAT64)           AS standard_cost
                                   , safe_cast(list_price AS FLOAT64)              AS list_price
                              FROM product_source)

SELECT *
FROM product_type_casting