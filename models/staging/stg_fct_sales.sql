WITH stg_fct_sales_source AS (SELECT sale_order_header.SalesOrderNumber            AS sale_order_line_key
                                   , sale_order_detail.SalesOrderID                AS sales_order_key
                                   , sale_order_header.CustomerID                  AS customer_key
                                   , sale_order_header.TerritoryID                 AS sales_territory_key
                                   , NULLIF(sale_order_header.SalesPersonID, 'NULL') AS sales_person_key
                                   , sale_order_header.OrderDate                   AS order_date_key
                                   , sale_order_header.Status                      AS sales_order_status
                                   , address1.AddressID                            AS bill_to_address_key
                                   , address2.AddressID                            AS ship_to_address_key
                                   , sale_order_header.ShipMethodID                AS ship_method_key
                                   , sale_order_detail.OrderQty                    AS order_quantity
                                   , sale_order_detail.UnitPrice                   AS unit_price
                                   , sale_order_detail.UnitPriceDiscount           AS unit_price_discount
                                   , sale_order_detail.UnitPrice * (1 - sale_order_detail.UnitPriceDiscount) *
                                     sale_order_detail.OrderQty                    AS gross_amount

                              FROM `adventureworks2019.Sales.SalesOrderDetail` sale_order_detail
                                       JOIN
                                   `adventureworks2019.Sales.SalesOrderHeader` sale_order_header USING (SalesOrderID)
                                       JOIN `adventureworks2019.Person.Address` address1
                                            ON sale_order_header.BillToAddressID = address1.AddressID
                                       JOIN `adventureworks2019.Person.Address` address2
                                            ON sale_order_header.ShipToAddressID = address2.AddressID)
   , stg_fct_sales_sub_total_source AS (SELECT sale_order_detail.SalesOrderID   AS sales_order_key
                                             , SUM(sale_order_detail.LineTotal) AS sub_total
                                        FROM `adventureworks2019.Sales.SalesOrderDetail` sale_order_detail
                                        GROUP BY sale_order_detail.SalesOrderID)
SELECT sale_source.*
     , sub_total_source.sub_total
     , sale_source.gross_amount + sub_total_source.sub_total AS total_due
FROM stg_fct_sales_source sale_source
         JOIN stg_fct_sales_sub_total_source sub_total_source USING (sales_order_key)