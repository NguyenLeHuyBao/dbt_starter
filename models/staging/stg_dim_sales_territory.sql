WITH stg_dim_sales_territory AS (SELECT territory.TerritoryID       AS territory_key
                                      , territory.Name              AS territory_name
                                      , territory.CountryRegionCode AS country_region_key
                                      , country_region.Name         AS country_region_name
                                      , territory.Group             AS group_name
                                 FROM `adventureworks2019.Sales.SalesTerritory` territory
                                          JOIN
                                      `adventureworks2019.Person.CountryRegion` country_region
                                      ON territory.CountryRegionCode = country_region.CountryRegionCode)
SELECT *
FROM stg_dim_sales_territory