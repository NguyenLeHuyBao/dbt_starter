WITH stg_dim_customer_source AS (SELECT customer.CustomerID              AS customer_key,
                                        CASE
                                            WHEN (customer.StoreID <> 'NULL') OR ((CAST(customer.CustomerId AS string) =
                                                                                   CAST(customer.PersonID AS string)) AND
                                                                                  customer.StoreID = 'NULL') THEN TRUE
                                            ELSE
                                                FALSE
                                            END                          AS is_reseller,
                                        reseller_store.BusinessEntityID  AS reseller_store_key,
                                        reseller_store.Name              AS reseller_store_name,
                                        sales_territory.TerritoryID      AS customer_territory_key,
                                        sales_territory.Name             AS customer_territory_name,
                                        country_region.CountryRegionCode AS customer_country_region_key,
                                        country_region.Name              AS customer_country_region_name,
                                        person.Title                     AS customer_person_title,
                                        person.FirstName                 AS first_name,
                                        person.MiddleName                AS middle_name,
                                        person.LastName                  AS last_name
                                 FROM `adventureworks2019.Sales.Customer` customer
                                          LEFT JOIN
                                      `adventureworks2019.Sales.Store` reseller_store
                                      ON
                                                  CAST(customer.StoreID AS string) =
                                                  CAST(reseller_store.BusinessEntityID AS string)
                                              AND ((customer.StoreID <> 'NULL')
                                              OR ((CAST(customer.CustomerId AS string) =
                                                   CAST(customer.PersonID AS string))
                                                  AND customer.StoreID = 'NULL'))
                                          LEFT JOIN
                                      `adventureworks2019.Sales.SalesTerritory` sales_territory
                                      ON
                                          customer.TerritoryID = sales_territory.TerritoryID
                                          LEFT JOIN
                                      `adventureworks2019.Person.CountryRegion` country_region
                                      ON
                                          sales_territory.CountryRegionCode = country_region.CountryRegionCode
                                          LEFT JOIN
                                      `adventureworks2019.Person.Person` person
                                      ON
                                              CAST(customer.PersonID AS string) =
                                              CASt(person.BusinessEntityID AS string))
SELECT *
FROM stg_dim_customer_source