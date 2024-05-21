WITH stg_dim_ship_method_source AS (SELECT ShipMethodID AS ship_method_key
                                         , Name
                                         , ShipBase     AS ship_min_price
                                         , ShipRate     AS ship_price_per_pound
                                    FROM `adventureworks2019.Purchasing.ShipMethod`)
SELECT *
FROM stg_dim_ship_method_source