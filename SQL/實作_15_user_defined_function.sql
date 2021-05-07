



-- 15.使用者自訂函數(UDF) 的設計與實作
--   15-1:如何建立純量函數(Scalar Functions) 
--   15-2:如何建立內嵌資料表值函數(Inline TVFs)  
--   15-3:如何建立多重語句資料表值函數(Multi-Statement TVFs) 
  

--- SQL Server 2017/2019
--      p 15-1 自訂函數的基礎      
--      p 15-2 自訂函數的名稱和種類


-- 補充資料：CREATE FUNCTION 範例(Transact-SQL)
--https://docs.microsoft.com/zh-tw/sql/t-sql/statements/create-function-transact-sql?view=sql-server-ver15#examples
-- 補充資料：SET ANSI_NULLS 範例
--https://docs.microsoft.com/zh-tw/sql/t-sql/statements/set-ansi-nulls-transact-sql?view=sql-server-ver15#examples
-- 補充資料：SET QUOTED_IDENTIFIER 範例
--https://docs.microsoft.com/zh-tw/sql/t-sql/statements/set-quoted-identifier-transact-sql?view=sql-server-ver15#examples



-- (底下說明範例來自 MSDN，部分修改)


-- 10. 透過介面新增function templete
--		資料庫 > 可程式性 > 函數 > 右鍵 > 新增 > 嵌入資料表值函式


-- 11. 測試指令 SET ANSI_NULLS 設定為 ON (範例來自 MSDN) //打開時不允許NULL值 || 關閉時允許NULL
		create table #temp (col int)  
		insert into  #temp values (null),(0),(1)  
		
		SET ANSI_NULLS ON
		
		select col from #temp where col = null;  -- 空
		select col from #temp where col <> null; -- 空
		select col from #temp where col is null; -- NULL

-- 12. 測試 SET ANSI_NULLS 設定為 OFF
		--create table #temp (col int)  
		--insert into  #temp values (null),(0),(1)  

		
		SET ANSI_NULLS OFF
		
		select col from #temp where col = null;  -- NULL
		select col from #temp where col <> null; -- 0 1
		select col from #temp where col is null; -- NULL
		
-- 13. 測試 SET QUOTED_IDENTIFIER 的設定 
		
	-- 13-1 關於識別碼 SET QUOTED_IDENTIFIER ON
		SET QUOTED_IDENTIFIER ON  -- 打開時允許非正規語法 / 關閉時不允許非正規語法
		GO
		CREATE TABLE "select" ("identity" INT IDENTITY NOT NULL, "order" INT NOT NULL);
		GO

	-- 13-2 關於識別碼 SET QUOTED_IDENTIFIER OFF
		SET QUOTED_IDENTIFIER OFF  
		GO
		CREATE TABLE "select" ("identity" INT IDENTITY NOT NULL, "order" INT NOT NULL);
		GO
		CREATE TABLE 'select' ('identity' INT IDENTITY NOT NULL, 'order' INT NOT NULL);
		GO

	--  13-3 關於文字單/雙引號  SET QUOTED_IDENTIFIER ON //打開時綁定單雙引號用法 || 關閉時 單雙引號皆可代表字串
		SET QUOTED_IDENTIFIER ON
		GO
		select '"apple"' 
		select "'apple'" 

	--  13-4 關於文字單/雙引號  SET QUOTED_IDENTIFIER OFF
		SET QUOTED_IDENTIFIER OFF
		GO
		select '"apple"' 
		select "'apple'" 


GO
-- 20. 純量函數(Scalar Functions) 回傳一個單一值
--    CREATE FUNCTION 函式名稱 (參數) RETURNS 資料型態
	CREATE FUNCTION Test0507 (@oid int) RETURNS TABLE
		RETURN SELECT * FROM DemoSalary WHERE Salary = @oid

-- 21. 內嵌資料表值函數(Inline TVFs)  
--    CREATE FUNCTION 函式名稱 (參數) RETURN TABLE


-- 22. 多重語句資料表值函數(Multi-Statement TVFs) 
--    CREATE FUNCTION 函式名稱 (參數) RETURN 資料表名稱 Table(資料行)
go

	CREATE FUNCTION fnGetEmp () RETURNS @a table (id int ,EmpName varchar(50))
		BEGIN
			-- 寫入自己規劃的變數 @a (@a被定義為table變數)
			insert @a values(1,'cat')
			return
		END