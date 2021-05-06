



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

	-- 22. 請觀察 @@ERROR 錯誤訊息是什麼 ==> 記錄錯誤代碼 2627
	INSERT INTO #TEMP VALUES ( 1 );
	PRINT @@ERROR ;

	-- 22. 請觀察 ERROR_NUMBER() 錯誤訊息是什麼 ==> 空白?
	EXEC sp_addmessage 55555,5,'ERROR',
		@lang = 'us_english'
	GO
	EXEC sp_addmessage 55555,5,'顯示錯誤',
		@lang = '繁體中文'



	BEGIN TRY
		RAISERROR(55555,17,10)
	END TRY
	BEGIN CATCH
		SELECT
			ERROR_NUMBER() AS ErrorNumber,
			ERROR_SEVERITY() AS ErrorSeverity,
			ERROR_STATE() AS ErrorState,
			ERROR_PROCEDURE() AS EP,
			ERROR_LINE() AS ErrorLine,
			ERROR_MESSAGE() AS ErrorMessage
	END CATCH
	-- 23. 一筆有錯，一筆沒有錯的情況下，@@ERROR 會如何記錄?  ==> 最近一次的執行結果
	BEGIN TRY
		INSERT INTO #TEMP VALUES ( 1 );
		INSERT INTO #TEMP VALUES ( 2 );
	END TRY
	BEGIN CATCH
		THROW 55554,'顯示錯誤',3
	END CATCH
	PRINT @@ERROR ;
