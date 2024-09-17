WITH sp AS (
	SELECT 
		SalesOrderID, 
		SUM(OrderQty) AS TotalUnits,
		AVG(StandardCost) AS Avg_StdCost
	FROM SalesProducts
	GROUP BY SalesOrderID
)


SELECT
	s.SalesOrderID,
	TerritoryName,
	TerritoryGroup,
	CountryRegionCode,
	ShipMethodName,
	sp.TotalUnits,
	sp.Avg_StdCost,
	TotalDue
FROM SalesOrders AS s
LEFT JOIN sp
	ON s.SalesOrderID = sp.SalesOrderID
ORDER BY s.SalesOrderID;