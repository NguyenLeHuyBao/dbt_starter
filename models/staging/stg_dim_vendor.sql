WITH stg_vendor_source AS (SELECT vendor.BusinessEntityID                                   AS vendor_key
                                , vendor.AccountNumber                                      AS vendor_code
                                , vendor.Name                                               AS vendor_name
                                , CASE
                                      WHEN vendor.CreditRating = 1 THEN 'Superior'
                                      WHEN vendor.CreditRating = 2 THEN 'Excellent'
                                      WHEN vendor.CreditRating = 3 THEN 'Above Average'
                                      WHEN vendor.CreditRating = 4 THEN 'Average'
                                      WHEN vendor.CreditRating = 5 THEN 'Below Average' END AS vendor_rating
                                , CASE
                                      WHEN vendor.ActiveFlag = 0 THEN 'inActive'
                                      WHEN vendor.ActiveFlag = 1 THEN 'Active' END          AS vendor_status
                                , NULLIF(vendor.PurchasingWebServiceURL, 'NULL')            AS vendor_web_url
                                , product_vendor.ProductID                                  AS product_key
                                , product_vendor.AverageLeadTime                            AS average_working_day
                                , product_vendor.StandardPrice                              AS standard_price
                                , product_vendor.MinOrderQty                                AS min_ord_qty
                                , product_vendor.MaxOrderQty                                AS max_ord_qty
                                , NULLIF(product_vendor.OnOrderQty, 'NULL')                 AS on_ord_qty
                                , product_vendor.UnitMeasureCode                            AS measure_code
                           FROM `adventureworks2019.Purchasing.Vendor` vendor
                                    LEFT JOIN
                                `adventureworks2019.Purchasing.ProductVendor` product_vendor USING (BusinessEntityID))
SELECT *
FROM stg_vendor_source
