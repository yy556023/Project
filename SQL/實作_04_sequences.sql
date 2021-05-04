-- 4.產生流水號的方法
--    4-3:透過順序物件(Sequences) 來產生序號


--- SQL Server 2017/2019
--      p 14-22 建立和使用順序物件 Sequence



-- 20. Sequences
--		資料庫 > 可程式性 > 順序 > 右鍵 > 新增順序 > seq_Test
--		資料庫 > 可程式性 > 順序 > seq_Test > 右鍵 > 編寫順序的指令碼為 > Create


	-- 執行底下語法新增 table，測試 identity 和 sequences 取號與跳號情形


	-- 20-1. 測試結果： (X)
	insert into Lab.dbo.TestSEQ (ID) values(1);
	select * from Lab.dbo.TestSEQ;

	-- 20-2. 測試結果： (O)
	insert into Lab.dbo.TestSEQ (memo) values('test ID');
	select * from Lab.dbo.TestSEQ;

	-- 20-3. 測試結果： (X)
	insert into Lab.dbo.TestSEQ (CreateDate) values('abc');

	-- 20-4. 測試結果： (O)
	insert into Lab.dbo.TestSEQ (memo) values('test ID');
	select * from Lab.dbo.TestSEQ;

	-- 20-5. 測試結果： (X) IDENTITY_INSERT 設為 OFF 時，無法將外顯值插入資料表 'TestSEQ' 的識別欄位中
	insert into Lab.dbo.TestSEQ (ID, SEQ) values(1, next value for seq_test);
	select * from Lab.dbo.TestSEQ;

	-- 20-6. 測試結果： (X) 轉換 expression到資料類型int時發生溢位錯誤
	insert into Lab.dbo.TestSEQ (SEQ) values(next value for seq_test);
	select * from Lab.dbo.TestSEQ;

	--SEQUENCE如果查詢錯誤一樣會跳號

	-- 20-7. 測試結果： (X) 從字元字串轉換成日期及/或時間時，轉換失敗。
	insert into Lab.dbo.TestSEQ (SEQ,CreateDate) values(next value for seq_test,'abc');
	select * from Lab.dbo.TestSEQ;

	-- 20-8. 測試結果： (O)
	insert into Lab.dbo.TestSEQ (SEQ,memo) values(next value for seq_test,'test SEQ');
	select * from Lab.dbo.TestSEQ;

	-- 20-9. 測試結果： (O)
	select next value for seq_test

	-- 20-10. 測試結果： SEQ號碼重設回1
	ALTER SEQUENCE seq_test RESTART WITH 1

	-- 20-11. 測試結果：
	SELECT current_value FROM sys.sequences WHERE name = 'seq_test' ;

	-- 20-12. 測試結果：
	insert into Lab.dbo.TestSEQ (SEQ,memo) values(next value for seq_test,'test Restart');
	select * from Lab.dbo.TestSEQ;

	----測試 drop delete truncate

	create table Apple (id int identity(1,1) , memo varchar(10))
	insert  Apple values ('hey')

	select * from Apple

	delete Apple
	drop table Apple
	truncate table Apple

	--網路上的刪除 其實是update來更改狀態
	--而不會靠delete刪除掉紀錄
	-- delete
	-- drop
	-- truncate