



-- 11.T-SQL 程式中錯誤訊息 -  @@ERROR 與 ERROR_NUMBER() 之間的差異
--    11-1:錯誤訊息的類型及其所具有的屬性
--    11-2:透過 ERROR_XXX()系統函數取得錯誤訊息  
--    11-3:系統函數 @@ERROR 與 ERROR_NUMBER() 之間的差異
  

--- SQL Server 2017/2019
--      p 13-35 錯誤處理函數


-- 20. 比較 @@ERROR 與 ERROR_NUMBER() 之間的差異

	CREATE TABLE #TEMP( id int primary key);

	-- 21. 沒有錯誤的情況
	INSERT INTO #TEMP VALUES ( 1 );

	-- 22. 請觀察 @@ERROR 錯誤訊息是什麼
	INSERT INTO #TEMP VALUES ( 1 );
	PRINT @@ERROR ;

	-- 22. 請觀察 ERROR_NUMBER() 錯誤訊息是什麼
	INSERT INTO #TEMP VALUES ( 1 );
	PRINT ERROR_NUMBER() ;

	-- 23. 一筆有錯，一筆沒有錯的情況下，@@ERROR 會如何記錄?
	INSERT INTO #TEMP VALUES ( 1 );
	INSERT INTO #TEMP VALUES ( 2 );
	PRINT @@ERROR ;