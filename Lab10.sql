CREATE DATABASE Lab10
GO
--code theo ví dụ
USE AdventureWorks2019
SELECT*INTO Lab10.dbo.WorkOrder FROM Production.WorkOrder
GO

USE Lab10
SELECT*INTO WorkOrderIX FROM WorkOrder
GO

SELECT*FROM WorkOrder
SELECT*FROM WorkOrderIX
GO

CREATE INDEX IX_WorkOrderID ON WorkOrderIX(WorkOrderID)
GO

SELECT*FROM WorkOrder where WorkOrderID=72000
SELECT*FROM WorkOrderIX where WorkOrderID=72000
GO

--Bài tập tự làm
CREATE DATABASE Aptech
GO

CREATE TABLE Classes(
   ClassName char(6),
   Teacher varchar(30),
   TimeSlot varchar(30),
   Class int,
   Lab int
) 
GO
/*1.Tạo an unique, clustered index tên là MyClusteredIndex trên trường ClassName với thuộc tính sau:
Pad_index = on
FillFactor =70
Ignore_ Dup_Key=on*/

CREATE UNIQUE CLUSTERED INDEX MyClusteredIndex1 ON Classes(ClassName) WITH(Pad_index = ON ,FillFactor =70 , Ignore_Dup_Key=ON)
GO

--2.Tạo a nonclustered index tên là TeacherIndex trên trường Teacher

CREATE NONCLUSTERED INDEX TeacherIndex ON Classes(Teacher)
GO

--3.Xóa chỉ mục TeacherIndex

DROP INDEX TeacherIndex ON Classes
GO

--4.Tạo một composite index tên là ClassLabIndex trên 2 trường Class và Lab.
CREATE INDEX ClassLabIndex ON Classes(Class,Lab)
GO

--5.Viết câu lệnh xem toàn bộ các chỉ mục của cơ sở dữ liệu Aptech.
SELECT DB_NAME() AS Database_Name
, sc.name AS Schema_Name
, o.name AS Table_Name
, i.name AS Index_Name
, i.type_desc AS Index_Type
FROM sys.indexes i
INNER JOIN sys.objects o ON i.object_id = o.object_id
INNER JOIN sys.schemas sc ON o.schema_id = sc.schema_id
WHERE i.name IS NOT NULL
AND o.type = 'U'
ORDER BY o.name, i.type
