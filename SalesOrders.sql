SELECT   
	DISTINCT soh.SalesOrderID,
    FORMAT(soh.OrderDate, 'dd-MM-yyy') AS OrderDate,
    FORMAT(soh.ShipDate, 'dd-MM-yyy') AS ShipDate,
    FORMAT(soh.DueDate, 'dd-MM-yyy') AS DueDate,
    c.CustomerID,
    ISNULL(pp.FirstName + ' ' + pp.LastName, s.Name) AS CustomerName,
    s.Name AS StoreName,
    sp.BusinessEntityID AS SalesPersonID,
    ppSales.FirstName + ' ' + ppSales.LastName AS SalesPersonName,
    sp.Bonus,
    sp.SalesYTD,
    sp.SalesLastYear, 
    sp.SalesQuota,
    st.Name AS TerritoryName,
    st.CountryRegionCode,
    st."Group" AS TerritoryGroup,
    sm.Name AS ShipMethodName, 
	soh.SubTotal,
	soh.TaxAmt,
	soh.Freight,
    soh.TotalDue
INTO SalesOrders
FROM
    Sales.SalesOrderHeader AS soh
INNER JOIN
    Sales.SalesOrderDetail AS sod ON soh.SalesOrderID = sod.SalesOrderID
INNER JOIN
    Sales.Customer AS c ON soh.CustomerID = c.CustomerID
LEFT JOIN
    Person.Person AS pp ON c.PersonID = pp.BusinessEntityID
LEFT JOIN
    Sales.Store AS s ON c.StoreID = s.BusinessEntityID
LEFT JOIN
    Sales.SalesPerson AS sp ON soh.SalesPersonID = sp.BusinessEntityID
LEFT JOIN
    Person.Person AS ppSales ON sp.BusinessEntityID = ppSales.BusinessEntityID
LEFT JOIN
    Sales.SalesTerritory AS st ON soh.TerritoryID = st.TerritoryID
LEFT JOIN
    Purchasing.ShipMethod AS sm ON soh.ShipMethodID = sm.ShipMethodID
ORDER BY soh.SalesOrderID ASC;