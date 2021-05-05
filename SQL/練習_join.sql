


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

-- 360. VINET的訂單中，所有經手業務的名字 (JOIN)



-- 370. VINET的訂單中，找出訂單編號為10274所購買的產品清單，請找出產品名稱、產品價格
SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'Production'


-- 380. 依照貨運公司，哪一家貨運公司承接最多訂單金額 (加總訂單價格)

