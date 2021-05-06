
-- 底下請使用 AdventureWorks 來做搜尋和撰寫
-- AdventureWorks 資料庫說明參考網址：https://dataedo.com/samples/html/AdventureWorks/


-- 01. ContactType 表格中，代號屬於 11, 14, 15 分別代表什麼意思 A:11 Owner/14 Purchasing Agent/15 Purchasing Manager
SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME like 'ContactType'

SELECT * FROM Person.ContactType where ContactTypeID in (11,14,15)


-- 02. Person 資料表中，使用人員類型進行分類統計，每一種類型裡面共有幾位?
SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME LIKE 'Person'

SELECT PersonType,COUNT(PersonType) 人數 FROM Person.Person
GROUP BY PersonType

-- 03. PC 是哪一種度量單位的縮寫?
SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA LIKE 'Production'
ORDER BY TABLE_NAME

SELECT * FROM Production.UnitMeasure
WHERE UnitMeasureCode = 'PC'
--WHERE UnitMeasureCode like 'PC ' UnitMeasureCode 資料類型為nchar(3) 不會變動 所以用like條件去執行時 需把空白補上


-- 04. 請列出商品描述中有 「rim」 單字的商品，列出 商品描述id 和 商品描述
SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA LIKE 'Production'
ORDER BY COLUMN_NAME

SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'ProductID'

SELECT ProductDescriptionID,Description FROM Production.ProductDescription WHERE Description LIKE '% rim%'


-- 05. 有一個資料表為銷售員業績總表
--     請列出 銷售員姓名、負責行銷的區域名稱、去年度的銷售業績
SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'BusinessEntityID'
SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'TerritoryID'
SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'SalesTerritoryHistory'

SELECT * FROM Sales.SalesPerson
SELECT * FROM Sales.SalesTerritory
SELECT * FROM Person.Person

SELECT P.BusinessEntityID,P.FirstName,P.LastName,ST.TerritoryID,ST.Name,SP.SalesLastYear
FROM Sales.SalesPerson AS SP,Person.Person AS P,Sales.SalesTerritory AS ST
WHERE SP.BusinessEntityID = P.BusinessEntityID AND SP.TerritoryID = ST.TerritoryID

--老師解答
SELECT * FROM Sales.SalesPerson
SELECT * FROM Person.Person WHERE PersonType = 'SP'
SELECT * FROM Sales.SalesTerritory



SELECT *
FROM Sales.SalesPerson AS SP
LEFT JOIN Person.Person AS P
ON SP.BusinessEntityID = P.BusinessEntityID
LEFT JOIN Sales.SalesTerritory AS ST
ON SP.TerritoryID = ST.TerritoryID

-- 06. 那些 員工 上晚班? 請列出 員工的姓名、工作起始時間、工作迄止時間
--     (晚班定義：深夜到次日凌晨)
SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'HumanResources'
SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'ShiftID'
SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'BusinessEntityID'
SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'FirstName'

SELECT * FROM HumanResources.Shift
SELECT * FROM HumanResources.EmployeeDepartmentHistory WHERE ShiftID = 3
SELECT * FROM Person.Person

SELECT P.FirstName,P.LastName,StartTime,EndTime
FROM HumanResources.Shift AS S,HumanResources.EmployeeDepartmentHistory AS EDH,Person.Person AS P
WHERE S.ShiftID = EDH.ShiftID AND EDH.BusinessEntityID = P.BusinessEntityID AND S.ShiftID = 3
--老師作法




-- 07. 請協助統計暑假期間有被銷售過的商品，並依照商品銷售總金額進行排序，總金額越高越前面
--     (暑假定義：每年的 7-9月)
SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'Production'
SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'Sales' and COLUMN_NAME = 'ProductID'
SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'Sales' and COLUMN_NAME = 'SalesOrderID'

SELECT * FROM Sales.SalesOrderDetail ORDER BY ProductID
SELECT * FROM Production.Product ORDER BY ProductID

SELECT P.ProductID,P.Name,sum(UnitPrice*OrderQty*(1-UnitPriceDiscount)) Total
FROM Sales.SalesOrderDetail AS SOD,Production.Product AS P
WHERE SOD.ProductID = P.ProductID AND MONTH(SOD.ModifiedDate) BETWEEN 7 AND 9
GROUP BY P.ProductID,P.Name
ORDER BY Total DESC

--老師作法
SELECT * FROM Sales.SalesOrderHeader
SELECT * FROM Sales.SalesOrderDetail

SELECT SalesOrderID,OrderDate
FROM Sales.SalesOrderHeader AS SOH
 --WHERE MONTH(OrderDate) BETWEEN 7 AND 9
WHERE SUBSTRING(FORMAT(OrderDate,'yyyyMMdd'),5,2) BETWEEN '07' AND '09'

SELECT SalesOrderID,ProductID,LineTotal
FROM Sales.SalesOrderDetail


-- 08. 請協助統計時薪最高的前10筆數值，並找到對應的員工
SELECT  P.BusinessEntityID,P.FirstName,P.LastName,EPH.Rate
FROM HumanResources.EmployeePayHistory AS EPH,Person.Person AS P
WHERE EPH.BusinessEntityID = P.BusinessEntityID
ORDER BY Rate DESC

SELECT P.BusinessEntityID,P.FirstName,EPH.Rate
FROM HumanResources.EmployeePayHistory AS EPH,Person.Person AS P
WHERE EPH.Rate IN
(SELECT DISTINCT TOP 10 Rate FROM HumanResources.EmployeePayHistory ORDER BY Rate DESC)
AND EPH.BusinessEntityID = P.BusinessEntityID
ORDER BY Rate DESC,BusinessEntityID

SELECT * FROM Person.Person
SELECT * FROM HumanResources.EmployeePayHistory