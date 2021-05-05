


-- 340. 那張訂單賺最多錢？
SELECT TOP 1 OrderID,SUM(UnitPrice*Quantity*(1-Discount)) Total
FROM [Order Details]
GROUP BY OrderID
ORDER BY Total DESC

SELECT A.OrderID,A.Total
FROM
(
	SELECT OrderID,SUM(UnitPrice*Quantity*(1-Discount)) Total
	FROM [Order Details]
	GROUP BY OrderID
)AS A,
(
	SELECT MAX(Total) Total
	FROM
	(
		SELECT OrderID,SUM(UnitPrice*Quantity*(1-Discount)) Total
		FROM [Order Details]
		GROUP BY OrderID
	)AS C
)AS B
WHERE A.Total = B.Total


-- 350. VINET的訂單中，有幾個業務經手 (顯示總數) (COUNT + 子查詢)
SELECT COUNT(EmployeeID) 業務數量
FROM
(
	SELECT DISTINCT EmployeeID
	FROM Orders
	WHERE CustomerID LIKE 'VINET'
)AS A


-- 360. VINET的訂單中，所有經手業務的名字 (JOIN)
SELECT DISTINCT LastName,FirstName
FROM Orders AS O INNER JOIN Employees AS E
	ON O.EmployeeID = E.EmployeeID
WHERE CustomerID LIKE 'VINET'


-- 370. VINET的訂單中，找出訂單編號為10274所購買的產品清單，請找出產品名稱、產品價格
SELECT O.OrderID,P.ProductID,P.ProductName,OD.UnitPrice
FROM Orders AS O INNER JOIN [Order Details] AS OD
ON O.OrderID = OD.OrderID INNER JOIN Products AS P
ON OD.ProductID = P.ProductID
WHERE CustomerID LIKE 'VINET' AND O.OrderID = 10274


-- 380. 依照貨運公司，哪一家貨運公司承接最多訂單金額 (加總訂單價格)
SELECT TOP 1 ShipVia,SUM(Total) Total
FROM
(
	SELECT O.OrderID,SUM(UnitPrice*Quantity*(1-Discount)) Total,ShipVia
	FROM Orders AS O INNER JOIN [Order Details] AS OD
	ON O.OrderID = OD.OrderID
	GROUP BY O.OrderID,ShipVia
)AS A
GROUP BY ShipVia
ORDER BY Total DESC

-- SELECT ShipVia,A.Total
-- FROM
-- (
-- 	SELECT *
-- 	FROM SHIP
-- )AS A,
-- (
-- 	SELECT MAX(Total) Total
-- 	FROM SHIP
-- )AS B
-- WHERE A.Total = B.Total

--CREATE VIEW SHIP AS
--	SELECT ShipVia,SUM(Total) Total
--	FROM
--	(
--		SELECT O.OrderID,SUM(UnitPrice*Quantity*(1-Discount)) Total,ShipVia
--		FROM Orders AS O INNER JOIN [Order Details] AS OD
--		ON O.OrderID = OD.OrderID
--		GROUP BY O.OrderID,ShipVia
--	)AS A
--	GROUP BY ShipVia