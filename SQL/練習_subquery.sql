

-- 410 請列出各項產品的類別、編號、品名、單價、
--     該類產品平均單價、單價與產品平均單價的「價差」。
SELECT P.CategoryID,ProductID,ProductName,UnitPrice,[AVG] 平均單價,(UnitPrice-[AVG]) 價差
FROM Products AS P,
(
    SELECT AVG(UnitPrice) AVG,CategoryID
    FROM Products
    GROUP BY CategoryID
)AS A
WHERE P.CategoryID = A.CategoryID
ORDER BY CategoryID


-- 420 請列出有訂第三類產品的訂單
SELECT  OrderID,CategoryID --OrderID
FROM [Order Details] AS A,
(
   SELECT *
   FROM Products
   WHERE CategoryID = 3
)AS B
WHERE A.ProductID = B.ProductID
ORDER BY OrderID


-- 430 請列出 銷售數量最多 的前三項產品
SELECT TOP 3 A.ProductID,A.ProductName,B.銷售數量
FROM Products AS A,
(
    SELECT ProductID,SUM(Quantity) 銷售數量
    FROM [Order Details]
    GROUP BY ProductID
)AS B
WHERE A.ProductID = B.ProductID
ORDER BY B.銷售數量 DESC


-- 440 有哪些產品是日商提供的?
SELECT A.*
FROM Products AS A,
(
    SELECT *
    FROM Suppliers
    WHERE Country LIKE 'Japan'
)AS B
WHERE A.SupplierID = B.SupplierID

