



-- 7.叢集索引(Clustered Index) 的規劃與建立
--   7-1:叢集索引的結構 
--   7-2:如何建立叢集索引
--   7-3:如何設計有效的叢集索引
  

--- SQL Server 2017/2019
--      p 12-1 索引的簡介              
--      p 12-8 索引的優缺點及注意事項  


-- SQL Server 索引架構和設計指南
--https://docs.microsoft.com/zh-tw/sql/relational-databases/sql-server-index-design-guide?view=sql-server-ver15
-- 叢集與非叢集索引說明
--https://docs.microsoft.com/zh-tw/sql/relational-databases/indexes/clustered-and-nonclustered-indexes-described?view=sql-server-ver15


-- 10. 測試建立 叢集索引(Clustered Index) 和 非叢集索引(Nonclustered Index) 
    
	-- 10.2 建立測試資料


	-- 10.3 查詢 > 包括實際執行計畫 (Ctrl + M) > 觀察SQL執行的過程
	--  沒有使用索引
		select * from Lab.dbo.T30;
		select * from Lab.dbo.T40;

	-- 10.4 查詢 > 包括實際執行計畫 (Ctrl + M) > 觀察SQL執行的過程
	--  使用索引
		select * from Lab.dbo.T30 where id = 2190;
		select * from Lab.dbo.T40 where id = 2190;

	-- 10.5 查詢 > 包括實際執行計畫 (Ctrl + M) > 觀察SQL執行的過程
		select * from Lab.dbo.T30 where seq = 2190;
		select * from Lab.dbo.T40 where seq = 2190;

	-- 10.6 建立非叢集索引(Nonclustered Index) 
		create nonclustered index IX_T40_SEQ ON Lab.dbo.T40 (SEQ);   

	-- 10.7 查詢 > 包括實際執行計畫 (Ctrl + M) > 觀察SQL執行的過程
		select * from Lab.dbo.T30 where seq = 2190;
		select * from Lab.dbo.T40 where seq = 2190;
