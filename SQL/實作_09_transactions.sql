



-- 9.資料庫的交易(Transactions) 控制簡介
--   9-1:交易(Transactions) 的 A.C.I.D. 四種屬性 
--   9-2:SQL Server 主要的交易管理模式(Transaction Management Mode)
--   9-3:@@TRANCOUNT 的值與 COMMIT、ROLLBACK 的關係
  


--- SQL Server 2017/2019
--      p 17-5 交易的四大特性    
--      p 17-6 交易的處理        
--      p 17-8 T-SQL 交易處理指令



-- 補充資料:交易基本概念
--https://docs.microsoft.com/zh-tw/sql/relational-databases/sql-server-transaction-locking-and-row-versioning-guide?view=sql-server-ver15#transaction-basics

-- 補充資料:交易 (Transact-SQL)
--https://docs.microsoft.com/zh-tw/sql/t-sql/language-elements/transactions-transact-sql?view=sql-server-ver15



-- 10. 交易的 A.C.I.D. 四種屬性/特性，請參考課本說明


-- 20. 交易的三種模式：明確交易

	-- 20-1. 新增暫存表格
		create table #A  (a INT PRIMARY KEY, b CHAR(3)); 

	-- 20-2. BEGIN TRANSACTION 定義開始交易範圍
		BEGIN TRANSACTION;     -- 交易開始   
			INSERT INTO #A VALUES (1, 'A');  
			INSERT INTO #A VALUES (2, 'B');  
			INSERT INTO #A VALUES (3, 'C');  
		COMMIT;  -- 交易結束 (遇到 COMMIT 或者 ROLLBACK 都算結束)

    -- 20-3. 觀察回傳的結果：
		SELECT * FROM #A;  
		
		
	-- 20-4. 寫入三筆資料，但是有兩筆鍵值重複，觀察訊息
		BEGIN TRANSACTION;   -- 交易開始
			INSERT INTO #A VALUES (1, 'A');  
			INSERT INTO #A VALUES (4, 'D');  
			INSERT INTO #A VALUES (3, 'C');  
		COMMIT;  -- 交易結束 (遇到 COMMIT 或者 ROLLBACK 都算結束)

    -- 20-3. 觀察回傳的結果：
		SELECT * FROM #A;  
		
	-- 20-5. ROLLBACK，取消交易
		BEGIN TRANSACTION;  -- 交易開始
			INSERT INTO #A VALUES (1, 'A');  
			INSERT INTO #A VALUES (5, 'E');  
			INSERT INTO #A VALUES (3, 'C');   
		ROLLBACK;           -- 交易結束 (遇到 COMMIT 或者 ROLLBACK 都算結束)

	-- 20-6. 觀察回傳的結果：
		SELECT * FROM #A;  

-- 21. 透過 @@TRANCOUNT 變數取得目前巢狀階層的層級

	-- 21-1. 單層測試

		PRINT '------ START ------';
		PRINT @@TRANCOUNT; 

		BEGIN TRANSACTION
			PRINT '------ BEGIN TRANSACTION ------';
			PRINT @@TRANCOUNT; 
			SELECT 'APPLE'
		COMMIT

		PRINT '------ END ------';
		PRINT @@TRANCOUNT; 


	-- 21-2. 多層測試
		PRINT '------ START ------';
		PRINT @@TRANCOUNT; 

		BEGIN TRANSACTION
			PRINT '------ BEGIN TRANSACTION 1------';
			PRINT @@TRANCOUNT; 
			
			BEGIN TRANSACTION
				PRINT '------ BEGIN TRANSACTION 2------';
				PRINT @@TRANCOUNT; 
			COMMIT
			PRINT '------ END TRANSACTION 2------';
			PRINT @@TRANCOUNT; 
		COMMIT

		PRINT '------ END ------';
		PRINT @@TRANCOUNT; 




-- 22. 加入 TRY .. CATCH 的錯誤處理
	
	--22-1. 第一次執行底下指令，應該沒有錯誤訊息
		BEGIN TRANSACTION 
			BEGIN TRY
				INSERT INTO #A VALUES (6, 'F');  
			END TRY
			BEGIN CATCH
				ROLLBACK; 
			END CATCH
		COMMIT;

	-- 22-2. 再一次重複執行上述指令，為什麼會有錯誤訊息？

	-- 22-3. 請協助加入判斷條件，如果交易沒有完成，就不執行 commit 動作


-- 30. 交易的三種模式：自動認可交易，sql server 預設的模式

	-- 30-1 新增測試資料表
		CREATE TABLE #B (
			
			-- 新增價格，預設為0

			-- 新增檢查條件，價格必須大於0

		)
	
	-- 30-2 寫入測試資料，並且查看
		INSERT INTO #B VALUES (300),(100),(200);
		SELECT * FROM #B;

	-- 30-3 下列指令是否可以成功被執行？
		UPDATE #B SET PRICE = PRICE - 150;


-- 40. 交易的三種模式：隱含交易

	-- 40-1 執行 update 更新資料，並且查看是否有更新成功？
		UPDATE #B SET PRICE = 333
		SELECT * FROM #B

	-- 40-2 底下指令框選一起執行，資料是否有更新成功？
		UPDATE #B SET PRICE = 555
		ROLLBACK  TRANSACTION
		SELECT * FROM #B

	-- 40-3 底下指令框選一起執行，資料是否有更新成功？
		SET IMPLICIT_TRANSACTIONS ON
		GO

		UPDATE #B SET PRICE = 998
		UPDATE #B SET PRICE = 999
		ROLLBACK  TRANSACTION
		SELECT * FROM #B;

		SET IMPLICIT_TRANSACTIONS OFF
		GO

