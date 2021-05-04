



-- 6.檢視表(Views) 的設計與實作
--    6-1:使用 CREATE VIEW 建立檢視表物件
--    6-2:如何查詢某一檢視表原始定義的內容
--    6-3:如何修改檢視表、刪除檢視表



--- SQL Server 2017/2019
--      p 11-3 檢視表的優缺點
--      p 11-5 建立檢視表
--      p 11-7 建立檢視表（使用指令）




-- 10. 先將 Northwind 資料庫的 Employees 搬移至 Lab 資料庫中
--   複習：select .. into ..

SELECT * INTO Lab.dbo.Employees FROM Northwind.dbo.Employees

-- 20. 新增 檢視表 vEmployeeBoss 可帶出員工和對應的長官名字
--   複習：self join
-- CREATE VIEW vEmployees
-- AS SELECT A.EmployeeID ID,A.FirstName FN,A.LastName LN,A.ReportsTo RE,B.FirstName as 'Boss'
-- FROM Lab.dbo.Employees AS A LEFT JOIN Lab.dbo.Employees AS B
-- ON A.ReportsTo = B.EmployeeID



-- 21. 查詢檢視表 vEmployeeBoss
-- SELECT * FROM vEmployees


-- 30. 更新 Lab_Employee 資料表的資料
--     並查看 檢視表 vEmployeeBoss 是否有改變？

-- SELECT * FROM Employees
-- UPDATE vEmployees
-- SET FirstName = 'CAT'
-- WHERE EmployeeID = 1

-- SELECT * FROM vEmployees

-- 31. 更新 檢視表 vEmployeeBoss 同一筆資料，是否可以成功？

UPDATE Employees
SET FirstName = 'COW'
WHERE EmployeeID = 1




-- 40. 將訂單明細資料表寫入 Lab 資料庫中
SELECT * INTO Lab.dbo.OrderDetail FROM Northwind.dbo.[Order Details]
-- 41. 新增 訂單的檢視表 vOrderInfo ，依照訂單號碼加總總金額

-- CREATE VIEW vOrderDetail AS
-- SELECT OrderID,SUM(Quantity*UnitPrice*(1-Discount)) Total
-- FROM OrderDetail
-- GROUP BY OrderID

-- 42. 讀取 vOrderInfo 查看是否成功

-- SELECT * FROM vOrderDetail
-- -- 43. 試著更新 訂單編號為 10248 的總金額為 999，是否可以成功？
-- UPDATE vOrderDetail
-- SET Total = 999
-- WHERE OrderID = 10248

--檢視表依條件可被更新也不可
--出來的資料如果經過運算則不可被UPDATE OR INSERT

--DEFAULT CHECK
--與INSERT一起使用時才會有效果

-- DROP TABLE T30
-- DROP TABLE T40


-- CREATE TABLE T30 (ID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,SEQ INT)
-- CREATE TABLE T40 (ID INT                                   ,SEQ INT)

-- INSERT INTO T40 SELECT * FROM T30

-- INSERT INTO T30 (SEQ) VALUES (NEXT VALUE FOR seq_T30)
-- GO 100

-- SELECT * FROM T30
-- SELECT * FROM T40

-- ALTER SEQUENCE seq_T30 restart with 1

-- INSERT T40 SELECT * FROM T30

-- SELECT * FROM T30 WHERE ID = 99
-- SELECT * FROM T40 WHERE ID = 99

-- ALTER TABLE T30 ADD (SEQ INT)
-- ALTER TABLE T40

-- create nonclustered index IX_T40_SEQ ON Lab.dbo.T40 (SEQ);

-- select * from INFORMATION_SCHEMA.COLUMNS