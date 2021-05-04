



-- 13.預存程序(Stored Procedure) 的設計與實作
--    13-1:如何建立與執行預存程序
--    13-2:如何修改預存程序
--    13-3:如何刪除預存程序


--- SQL Server 2017/2019
--      p 14-3 建立和執行預存程序
--      p 14-6 執行預存程序


-- 10. 建立測試環境
--  1.員工： 員工ID 員工姓名 員工狀態'C' 'D'
--  2.薪水： 員工ID 發薪日 $

CREATE TABLE DemoEmp
(EmpID int,EmpName varchar(50),EmpStatus CHAR(1))

CREATE TABLE DemoSalary
(EmpID int,PayDate char(8), Salary int)

insert DemoEmp values (1,'Apple','C')
insert DemoSalary values (1,'20210310',42000),(1,'20210410',42000)


select * from DemoEmp
select * from DemoSalary
-- 20. 建立不需要傳入參數的 procedure：uspGetEmployee 查詢 #emp 資料表

CREATE PROCEDURE uspGetEmployee as
    select * from DemoEmp
    select * from DemoSalary

-- 21. 執行 uspGetEmployee 查看

EXEC uspInsertSalary 1,42500

CREATE PROCEDURE uspInsertSalary @id int,@s int as
    INSERT INTO DemoSalary
    (EmpID,PayDate,Salary)
    VALUES
    (@id,FORMAT(GETDATE(),'yyyyMMdd'),@s)


-- 31. 測試 uspInsertSalary
-- 1. 更新員工註記 => 'D' ==> update DemoEmp
-- set EmpStatus = 'D' where EmpID = ?

-- 2.計算薪水 5/4 ~ 5/5 insert into

-- 3.


-- 40. 假設離職需要更新 #emp 註記，也需要計算薪資..等，將相關指令打包起來 uspByeBye
--    a. 傳遞參數的sp：傳入 員工編號 以及 離職日
--    b. 回傳參數的sp：加入 output 關鍵字
--    c. 更新 #emp 註記
--    d. 計算薪資：( 離職日 - 系統日 ) * 8 * 150


-- 41. 測試執行，exec uspByeBye
--		a. 測試人員存在的情況
--		b. 測試人員不存在的情況


-- 50. 修改 40 產生的 sp
--    a. @@rowcount
--    b. len()


-- 51. 測試執行，exec uspByeBye
--    a. 需要增加一個變數接收 sp 回傳值
--    b. 記得呼叫時也要加上 output 關鍵字
