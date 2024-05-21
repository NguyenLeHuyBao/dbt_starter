with stg_fct_purchasing_source AS (SELECT purchase_order_header.PurchaseOrderID as purchase_order_key
                                        , purchase_order_header.VendorID        AS vendor_key
                                        , purchase_order_header.ShipMethodID    AS ship_method_key
                                        , purchase_order_detail.ProductID       AS product_key
                                        , CASE
                                              WHEN purchase_order_header.Status = 1 THEN 'Pending'
                                              WHEN purchase_order_header.Status = 2 THEN 'Approved'
                                              WHEN purchase_order_header.Status = 3 THEN 'Rejected'
                                              WHEN purchase_order_header.Status = 4 THEN 'Complete'
                                              ELSE 'No Status' END              AS purchase_order_status
                                        , purchase_order_header.OrderDate       AS order_date
                                        , purchase_order_header.ShipDate        AS ship_date
                                        , purchase_order_detail.DueDate         AS receive_date
                                        , purchase_order_detail.OrderQty        AS order_quantity
                                        , purchase_order_detail.UnitPrice       AS unit_price
                                        , purchase_order_detail.LineTotal       AS sub_total
                                        , purchase_order_header.TaxAmt          AS tax_amount
                                        , purchase_order_header.Freight         AS freight_amount
                                   FROM `adventureworks2019.Purchasing.PurchaseOrderDetail` purchase_order_detail
                                            JOIN
                                        `adventureworks2019.Purchasing.PurchaseOrderHeader` purchase_order_header
                                        USING (PurchaseOrderID))
SELECT *
FROM stg_fct_purchasing_source