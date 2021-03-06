



-- 12.T-SQL 程式中的例外處理 - TRY/CATCH 語法 + RAISERROR vs THROW
--    12-1:使用結構化的例外處理 TRY/CATCH 語法來處理錯誤訊息
--    12-2:使用 RAISERROR() 將一般訊息或者是錯誤訊息傳回給應用程式
--    12-3:使用 THROW 來引發或者是重新引發例外狀況


--- SQL Server 2017/2019
--      p 13-33 錯誤處理
--      p 13-37 throw 指令


-- 補充資料：RAISERROR 和 THROW 之間的差異
-- https://docs.microsoft.com/zh-tw/sql/t-sql/language-elements/throw-transact-sql?view=sql-server-ver15#differences-between-raiserror-and-throw
-- 補充資料：ERROR_NUMBER (Transact-SQL)
-- https://docs.microsoft.com/zh-tw/sql/t-sql/functions/error-number-transact-sql?view=sql-server-ver15
-- 補充資料：Database Engine 錯誤嚴重性
-- https://docs.microsoft.com/zh-tw/sql/relational-databases/errors-events/database-engine-error-severities?view=sql-server-ver15
-- 補充資料：RAISERROR 的訊息自訂格式
-- https://docs.microsoft.com/zh-tw/sql/t-sql/language-elements/raiserror-transact-sql?view=sql-server-ver15#arguments


-- (底下範例來自 MSDN 改寫並說明)

-- 10. ERROR 相關函式 會傳回造成執行 TRY...CATCH 建構的 CATCH 區塊之錯誤的錯誤號碼。

		SELECT 1/0
		SELECT
			ERROR_NUMBER() AS ErrorNumber,
			ERROR_SEVERITY() AS ErrorSeverity,
			ERROR_STATE() AS ErrorState,
			ERROR_PROCEDURE() AS ErrorProcedure,
			ERROR_LINE() AS ErrorLine,
			ERROR_MESSAGE() AS ErrorMessage;

-- 11. 例外的處理 BEGIN TRY .. END TRY + BEGIN CATCH .. END CATCH
--		以及取得對應取得錯誤訊息的函式

--   底下範例來自MSDN：https://docs.microsoft.com/zh-tw/sql/t-sql/functions/error-number-transact-sql?view=sql-server-ver15#b-using-error_number-in-a-catch-block-with-other-error-handling-tools

	BEGIN TRY
		-- Generate a divide-by-zero error.
		SELECT 1/0;
	END TRY
	BEGIN CATCH
		SELECT
			ERROR_NUMBER() AS ErrorNumber,
			ERROR_SEVERITY() AS ErrorSeverity,
			ERROR_STATE() AS ErrorState,
			ERROR_PROCEDURE() AS ErrorProcedure,
			ERROR_LINE() AS ErrorLine,
			ERROR_MESSAGE() AS ErrorMessage;
	END CATCH;
	GO

-- 關於系統預設的訊息
	select * from sys.messages where message_id = 8134
	select * from sys.messages where language_id = 1028

-- 12. 如果說是 table 不存在的錯誤，是否能攔截？ (X) 在編輯時就出得錯不會跑到CATCH
BEGIN TRY
	SELECT * FROM AAAAAAAAAAA

END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS ErrorNumber, ERROR_MESSAGE() AS ErrorMessage
END CATCH


-- 20. RAISERROR (SQL 2005)  & THROW (SQL 2012) 差異
--		兩者都可以被用來對使用者拋出訊息

	-- RAISERROR
		RAISERROR ('test', 2, 1);
		PRINT '--- 分隔線 ---';

		RAISERROR (40655, 2, 1);
		PRINT '--- 分隔線 ---';

		EXEC sp_addmessage 50001,1,'ERROR FOR PURPOSE',
			@lang = 'us_english'
		GO
		EXEC sp_addmessage 50001,1,'故意犯錯',
			@lang = '繁體中文'

		BEGIN TRY
			RAISERROR (50001, 12, 5);
			PRINT '--- 分隔線 ---';
		END TRY
		BEGIN CATCH
			SELECT
				ERROR_NUMBER() AS 錯誤代碼,
				ERROR_SEVERITY() AS 錯誤等級,
				ERROR_STATE() AS 錯誤狀態,
				ERROR_MESSAGE() AS 錯誤訊息,
				ERROR_LINE() AS 錯誤行
		END CATCH
GO

-- 錯誤狀態 狀態非字面上的意義

CREATE PROCEDURE E_M @a varchar(50),@b int,@c int AS 
		BEGIN TRY
			RAISERROR (@a, @b, @c);
			PRINT '--- 分隔線 ---';
		END TRY
		BEGIN CATCH
			SELECT
				ERROR_NUMBER() AS 錯誤代碼,
				ERROR_SEVERITY() AS 錯誤等級,
				ERROR_STATE() AS 錯誤狀態,
				ERROR_MESSAGE() AS 錯誤訊息,
				ERROR_LINE() AS 錯誤行
		END CATCH
GO

EXEC E_M 測試等級大於10,15,3

declare @string nvarchar(50) = '測試玩玩看'
--set @string = '測試'
--select @string


		RAISERROR (N'%s', 2, 2, @string);
		PRINT '--- 分隔線 ---';

GO

CREATE PROCEDURE PLAY @a varchar(50),@b int,@c int AS 
		DECLARE @d varchar(50) = @a
		
		BEGIN TRY
			RAISERROR (N'%s', @b, @c, @d);
		END TRY
		BEGIN CATCH
			SELECT
				ERROR_NUMBER() AS 錯誤代碼,
				ERROR_SEVERITY() AS 錯誤等級,
				ERROR_STATE() AS 錯誤狀態,
				ERROR_MESSAGE() AS 錯誤訊息,
				ERROR_LINE() AS 錯誤行
		END CATCH
GO

EXEC PLAY 我來玩玩看的,15,5;

	-- THROW
		THROW 49999, 'test THROW', 0;
		PRINT 'THROW()';

		THROW 50000, 'test THROW', 0;
		PRINT 'THROW()';
