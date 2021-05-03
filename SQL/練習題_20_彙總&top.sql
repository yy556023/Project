-- ** 請練習撰寫底下指令，大部分使用 Products 產品資料表；若有其他資料表會在題目補充說明 **

-- 210 確定打開的是 Northwind 資料庫
USE Northwind


-- 210 請列出單價最高的前三項產品。
SELECT TOP 3 *
FROM Products
ORDER BY UnitPrice DESC


-- 220 請列出產品的平均單價。
SELECT AVG(UnitPrice) 平均單價
FROM Products

-- 230 挑選類別編號(CategoryID)為 1, 4, 8 為範圍, 計算挑選範圍內產品的平均單價。
SELECT AVG(UnitPrice) '1,4,8平均單價'
FROM Products
WHERE CategoryID IN (1,4,8)

SELECT SUM(UnitPrice) 總價格, COUNT(CategoryID) , CategoryID
FROM Products
WHERE CategoryID IN (1,4,8)
GROUP BY CategoryID
-- 240 請列出各類產品的平均單價。
SELECT CategoryID,AVG(UnitPrice)
FROM Products
GROUP BY CategoryID
-- 250 請列出平均單價最高的前三類產品。
SELECT TOP 3 CategoryID, AVG(UnitPrice) 平均單價
FROM Products
GROUP BY CategoryID
ORDER BY 平均單價 DESC

SELECT CategoryID, AVG(UnitPrice) 平均單價
FROM Products
GROUP BY CategoryID
HAVING AVG(UnitPrice) > 30
ORDER BY 平均單價 DESC


-- 260 找出 價格最高 的產品 (使用 TOP 關鍵字)
SELECT TOP 1 *
FROM Products
ORDER BY UnitPrice DESC


-- 270 找出 價格最低 的產品 (使用 TOP 關鍵字)
SELECT TOP 1 *
FROM Products
ORDER BY UnitPrice


-- 275 使用 MIN() 關鍵字改寫，取得價格最低產品單價是多少？
SELECT A.*
FROM
(
    SELECT *
    FROM Products
)AS A,
(
    SELECT MIN(UnitPrice) MIN
    FROM Products
)AS B
WHERE A.UnitPrice = B.[MIN]

SELECT TOP 1 ProductName,UnitPrice
FROM Products
ORDER BY UnitPrice

SELECT ProductName,UnitPrice
FROM Products
WHERE UnitPrice = (SELECT MIN(UnitPrice)FROM Products)