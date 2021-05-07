



-- 17.透過 DML觸發程序(DML Triggers)來處理相關資料 
--    17-1:如何建立 AFTER INSERT Triggers 
--    17-2:如何建立 AFTER DELETE Triggers  
--    17-3:如何建立 AFTER UPDATE Triggers 
   

--- SQL Server 2017/2019
--      p 16-4 Create Trigger 指令建立觸發程序


-- 10. 建立測試環境，確認資料是否存在
--		將訂單資料寫入 Lab 資料庫中
SELECT * INTO Lab.dbo.NWOrder from Northwind.dbo.Orders
SELECT * INTO Lab.dbo.NWOrderD from Northwind.dbo.[Order Details]
use Lab
select * from NWOrder
select * from NWOrderD


-- 15. 建立 MyLog 資料表，欄位：流水號、trigger名稱、來源id、備註、更新時間
CREATE TABLE MyLog (
	SEQ int identity(1,1),
	TR_N nvarchar(50),
	S_ID int,
	Memo nvarchar(50),
	UPT datetime default getdate()
	)

-- 20. 測試刪除訂單
--		(!!! 注意，這裡是測試，實務上僅會更改訂單註記 !!!)

--  triggrt 語法結構
	-- CREATE TRIGGER trigger_name  ON  table_name
	-- { FOR | AFTER | INSTEAD OF }    
	-- { [ INSERT ] [ , ] [ UPDATE ] [ , ] [ DELETE ] }   
	-- AS ()


	-- 20-1 撰寫 trigger => utrDeleteOrder
	--   a. 偵測當 NWOrder 有刪除動作時，寫入一筆資料至 MyLog
	--   b. 測試 刪除  OrderID = 10248


	-- 20-2 修改上一個 trigger Alter TRIGGER dbo.utrDeleteOrder 
	--   a. 增加條件，判斷是否有訂單明細
	--   b. 如果有訂單明細，則不允許刪除
