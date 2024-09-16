SELECT
    sod.ProductID,
	soh.SalesOrderID,
    p.Name AS ProductName,
    p.ProductNumber,
	p.Color,

	p.StandardCost,
    p.ListPrice,
    sod.OrderQty,
    sod.UnitPrice,
	(sod.UnitPrice * sod.OrderQty) - (p.StandardCost * sod.OrderQty) AS Profit
FROM
    Sales.SalesOrderHeader AS soh
INNER JOIN Sales.SalesOrderDetail AS sod
ON soh.SalesOrderID = sod.SalesOrderID
INNER JOIN Production.Product AS p
ON sod.ProductID = p.ProductID