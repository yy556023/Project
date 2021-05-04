



-- 3.暫存資料表(Temporary Table)與通用資料表運算式(Common Table Expressions, CTE)的使用
--   3-1:區域暫存資料表(Local Temporary Tables) #
--   3-2:全域暫存資料表(Global Temporary Tables) ##
--   3-3:使用通用資料表運算式(Common Table Expressions)
SELECT *
-- INTO Lab.dbo.Categories
FROM Northwind.dbo.Categories

--無須創建的複製寫法
-- SELECT 欄位名稱
-- INTO 資料庫名稱.資料夾.資料表
-- FROM 資料庫名稱.資料夾.資料表


--- SQL Server 2017/2019
--      p 7-33 暫存資料表的建立
--      p 9-29 CTE 一般資料表運算式



-- 10. 建立並測試 Local Temporary Tables：#LabCategories
--	透過 select into 語法
 -- 將 Northwind 資料庫中 的 Categories 資料表寫入到 Lab 資料庫

SELECT *
INTO #Test
FROM Northwind.dbo.Categories

INSERT #Test VALUES (
	'A','B',0x151C
)

SELECT *
FROM #Test
-- 11. 建立完畢後，請測試寫入資料至#LabCategories，是否有錯誤訊息？ (O)

SELECT *
FROM Northwind.dbo.Categories



-- 13. 請新增一個查詢視窗，是否還能查到 #LabCategories? (X)




-- 20. 建立並測試 Global Temporary Tables：##LabShippers
-- 透過 Northwind 資料庫中 的 Shippers 資料表

-- 21. 請新增一個查詢視窗，是否還能查到 ##LabShippers? (X)

SELECT *
INTO ##TEST
FROM Northwind.dbo.Categories

SELECT *
FROM ##TEST


-- 30. 使用 CTE 進行遞迴查詢
--  一般資料表運算式 (Common Table Expressions)
--  簡單來說，就是建立一個暫存資料表給予該次查詢使用，改查詢使用後，將會自動釋放

		--  with cte_table_name (欄位1, 欄位2..) as
		--  (
		--  	--查詢語法
		--  )
			-- WITH TEST (欄位1,欄位2) AS
			-- (
			-- 	SELECT * FROM AddressBook.dbo.UserInfo
			-- )
			-- SELECT * FROM TEST

-- 31. 測試透過 with 關鍵字 建立員工資料表
-- WITH ID AS
-- (
-- 	SELECT * FROM Northwind.dbo.Employees
-- )
-- SELECT * FROM ID
