WITH stg_product_product_source AS (SELECT product.ProductID                            AS product_key
                                         , product.Name                                 AS product_name
                                         , product.ProductNumber                        AS product_number
                                         , product.FinishedGoodsFlag                    AS finished_goods_flag
                                         , product.MakeFlag                             AS make_flag
                                         , product.SizeUnitMeasureCode                  AS size_unit_measure_key
                                         , product.WeightUnitMeasureCode                AS weight_unit_measure_key
                                         , NULLIF(product.Color, 'NULL')                AS color
                                         , product.Weight                               AS weight
                                         , NULLIF(product.Size, 'NULL')                 AS `size`
                                         , product.SafetyStockLevel                     AS safety_stock_level
                                         , product.StandardCost                         AS standard_cost
                                         , product.ListPrice                            AS list_price
                                         , NULLIF(product.ProductSubcategoryID, 'NULL') AS product_subcategory_key
                                         , NULLIF(product.ProductModelID, 'NULL')       AS product_model_key
                                    FROM `adventureworks2019.Production.Product` product)
   , stg_product_category_source AS (SELECT sub_category.ProductSubcategoryID AS product_subcategory_key
                                          , sub_category.Name                 AS product_subcategory_name
                                          , category.ProductCategoryID        AS product_category_key
                                          , category.Name                     AS product_category_name
                                     FROM `adventureworks2019.Production.ProductCategory` category
                                              JOIN `adventureworks2019.Production.ProductSubcategory` sub_category
                                                   ON category.ProductCategoryID = sub_category.ProductCategoryID)
   , stg_product_model_source AS (SELECT ProductModelID
                                       , Name
                                  FROM `adventureworks2019.Production.ProductModel`)

   , stg_product_unit_measure AS (SELECT UnitMeasureCode
                                       , Name
                                  FROM `adventureworks2019.Production.UnitMeasure`)
SELECT product.*
     , measure1.Name AS size_unit_measure_name
     , measure2.Name AS weight_unit_measure_name
     , `model`.Name  AS product_model_name
     , category.product_subcategory_name
     , category.product_category_key
     , category.product_category_name
FROM stg_product_product_source product
         LEFT JOIN stg_product_unit_measure measure1
                   ON product.size_unit_measure_key = measure1.UnitMeasureCode
         LEFT JOIN stg_product_unit_measure measure2 ON product.weight_unit_measure_key = measure1.UnitMeasureCode
         LEFT JOIN stg_product_model_source `model`
                   ON CAST(product.product_model_key AS numeric) = `model`.ProductModelID
         LEFT JOIN stg_product_category_source category
                   ON CAST(product.product_subcategory_key AS numeric) = category.product_subcategory_key