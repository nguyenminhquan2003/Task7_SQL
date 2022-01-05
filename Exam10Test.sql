USE master
GO

IF(DB_ID('Exam10Test') IS NOT NULL)
   DROP DATABASE Exam10Test
ELSE
   CREATE DATABASE Exam10Test
GO

USE Exam10Test
GO

CREATE TABLE Classes(
   ClassID int IDENTITY,
   ClassName nvarchar(10),
   CONSTRAINT PK_Classes PRIMARY KEY(ClassID),
   CONSTRAINT UQ_ClassesClassName UNIQUE(ClassName)
)
GO

CREATE TABLE Students(
   RollNo varchar(6) CONSTRAINT PK_Students PRIMARY KEY ,
   FullName nvarchar(50) NOT NULL ,
   Email varchar(100) CONSTRAINT UQ_StudentsEmail UNIQUE , 
   ClassName nvarchar(10) CONSTRAINT FK_StudentsClass FOREIGN KEY REFERENCES Classes(ClassName) ON UPDATE CASCADE
)
GO

CREATE INDEX IX_Email ON Students(Email)
GO

CREATE TABLE Subjects(
   SubjectID int PRIMARY KEY,
   SubjectName nvarchar(100)
)

CREATE CLUSTERED INDEX IX_SubjectID
ON Subjects(SubjectID)

CREATE NONCLUSTERED INDEX IX_SubjectName
ON Subjects(SubjectName)

CREATE UNIQUE INDEX IX_UQ_SubjectName ON Subjects(SubjectName)

CREATE INDEX IX_Name_Email ON Students(FullName,Email)

GO

DROP INDEX IX_SubjectID ON Subjects
GO

CREATE CLUSTERED INDEX IX_SubjectID ON Subjects(SubjectID) WITH (FILLFACTOR=60)

DROP INDEX IX_SubjectID ON Subjects
GO

CREATE CLUSTERED INDEX IX_SubjectID ON Subjects(SubjectID) WITH (PAD_INDEX=ON,FILLFACTOR=60)
GO

EXEC sp_helpindex 'Subjects'

EXECUTE sp_helpindex 'Subjects'
GO

ALTER INDEX IX_SubjectName ON Subjects REBUILD

ALTER INDEX IX_SubjectName ON Subjects REBUILD WITH (FILLFACTOR=60)


ALTER INDEX IX_SubjectName ON Subjects DISABLE 

ALTER INDEX IX_SubjectName ON Subjects REBUILD

ALTER INDEX IX_SubjectName ON Subjects REORGANIZE

ALTER INDEX IX_SubjectName ON Subjects REBUILD WITH(ONLINE=ON)

ALTER INDEX IX_SubjectName ON Subjects REBUILD WITH(MAXDOP=4)


CREATE INDEX IX_FullName_Include ON Students(FullName) INCLUDE(Email, ClassName)

SELECT FullName,Email,ClassName FROM Students WHERE FullName LIKE '%a%'

DROP INDEX IX_FullName_Include ON Students

CREATE STATISTICS Statistics_Subjects ON Subjects(SubjectID)

UPDATE STATISTICS Subjects Statistics_Subjects

DBCC SHOW_STATISTICS(Subjects,Statistics_Subjects)