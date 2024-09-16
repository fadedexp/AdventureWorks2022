SELECT   
	DISTINCT soh.SalesOrderID,
    -- Sales Order Information
    soh.OrderDate,
    soh.ShipDate,
    soh.DueDate,
  
    -- Customer Information
    c.CustomerID,
    c.AccountNumber,
    ISNULL(pp.FirstName + ' ' + pp.LastName, s.Name) AS CustomerName,
    s.Name AS StoreName,
    
    -- Sales Person Information
    sp.BusinessEntityID AS SalesPersonID,
    ppSales.FirstName + ' ' + ppSales.LastName AS SalesPersonName,
    sp.Bonus,
    sp.SalesYTD,
    sp.SalesLastYear, 
    sp.SalesQuota,
    
    -- Territory Information
    st.Name AS TerritoryName,
    st.CountryRegionCode,
    st."Group" AS TerritoryGroup,
    
    -- Shipping Information
    sm.Name AS ShipMethodName, 

    CASE
       WHEN soh.Status = 5 THEN 'Completed'
       ELSE 'Not completed'
    END AS OrderStatus,

	soh.SubTotal,
	soh.TaxAmt,
	soh.Freight,
    soh.TotalDue
    
FROM
    Sales.SalesOrderHeader soh
INNER JOIN
    Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
INNER JOIN
    Sales.Customer c ON soh.CustomerID = c.CustomerID

-- Customer Personal or Store Information
LEFT JOIN
    Person.Person pp ON c.PersonID = pp.BusinessEntityID
LEFT JOIN
    Sales.Store s ON c.StoreID = s.BusinessEntityID

-- Sales Person Information
LEFT JOIN
    Sales.SalesPerson sp ON soh.SalesPersonID = sp.BusinessEntityID
LEFT JOIN
    Person.Person ppSales ON sp.BusinessEntityID = ppSales.BusinessEntityID

-- Sales Territory Information
LEFT JOIN
    Sales.SalesTerritory st ON soh.TerritoryID = st.TerritoryID

-- Shipping Method Information
LEFT JOIN
    Purchasing.ShipMethod sm ON soh.ShipMethodID = sm.ShipMethodID;