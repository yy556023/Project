



-- 16.多表格聯結(Join) 的變形查詢語法
--   16-1:外部聯結(Outer Joins)
--   16-2:交叉聯結(Cross Joins)
--   16-3:自我聯結(Self-Joins)


--- SQL Server 2017/2019
--      p 9-4   外部合併查詢
--      p 9-14  交叉合併查詢
--      p 9-10  自身合併查詢



-- 外部連結 ==> outer joins ==> SQL 語法：left join / right join / full join
-- 交叉聯結 ==> cross joins ==> SQL 語法：cross join
-- 自我聯結 ==> self-joins  ==> SQL 語法：無，這是資料表自己join自己



-- 10. 我們想要找註冊以後卻從未下過訂單的客戶，進行行銷動作，該如何挑選對應資料？
--		先用統計的方式進行資料確認，再進行比對動作
SELECT * FROM Orders
SELECT * FROM Customers

--SELECT A.CustomerID , COUNT(*) , B.CustomerID
SELECT *
FROM Customers AS A LEFT JOIN Orders AS B
    ON A.CustomerID = B.CustomerID
WHERE B.CustomerID IS NULL
--GROUP BY A.CustomerID,B.CustomerID

-- 20. "假設" 北風資料庫中，產品資料表(Products) 和 產品類別資料表(Categories) 目前沒有關聯
--		如果每一個產品類別都包含所有於產品資料表的品項，該如何得到這樣的資料?


-- 30. 觀察 Employees 資料表可以知道，員工的主管也包含在其中；
--		請幫忙整理出員工以及員工的主管姓名
