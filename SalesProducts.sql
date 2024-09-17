SELECT
    sod.ProductID,
	soh.SalesOrderID,
    p.Name AS ProductName,
	p.Color,
	pc.Name AS Category,
	psc.Name AS Subcategory,
	p.StandardCost,
    p.ListPrice,
    sod.OrderQty,
    sod.UnitPrice,
	(sod.UnitPrice * sod.OrderQty) - (p.StandardCost * sod.OrderQty) AS Profit
INTO SalesProducts
FROM
    Sales.SalesOrderHeader AS soh
INNER JOIN
	Sales.SalesOrderDetail AS sod ON soh.SalesOrderID = sod.SalesOrderID
INNER JOIN
	Production.Product AS p ON sod.ProductID = p.ProductID
LEFT JOIN
	Production.ProductSubcategory AS psc ON psc.ProductSubcategoryID = p.ProductSubcategoryID
LEFT JOIN
	Production.ProductCategory AS pc ON pc.ProductCategoryID = psc.ProductCategoryID;