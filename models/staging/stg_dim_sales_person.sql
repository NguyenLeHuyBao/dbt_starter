WITH stg_dim_sales_person AS (SELECT human_resources_employee.BusinessEntityID   AS sales_person_key
                                   , NULLIF(person.Title, 'NULL')                AS sales_person_title
                                   , person.FirstName                            AS first_name
                                   , person.MiddleName                           AS middle_name
                                   , person.LastName                             AS last_name
                                   , human_resources_employee.JobTitle           AS job_title
                                   , human_resources_employee.Gender             AS gender
                                   , CAST(sales_person.Bonus AS FLOAT64)         AS bonus
                                   , CAST(sales_person.CommissionPct AS FLOAT64) AS commission
                              FROM `adventureworks2019.Sales.SalesPerson` sales_person
                                       JOIN
                                   `adventureworks2019.HumanResources.Employee` human_resources_employee
                                   ON sales_person.BusinessEntityID = human_resources_employee.BusinessEntityID
                                       JOIN `adventureworks2019.Person.Person` person ON
                                  human_resources_employee.BusinessEntityID = person.BusinessEntityID)
SELECT *
FROM stg_dim_sales_person
