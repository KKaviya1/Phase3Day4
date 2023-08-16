create database TriggersDb
use TriggersDb

--syntax to create DML trigger

--create trigger [schema_name.] trigger_name
--on [schema_name.]  table_name [with encryption]
--{after insert} as
--[if update (column_name)...]
--[{and | or} update (column_name)...]
--<sql_statements>

create table Emps
(Id int primary key,
Fname nvarchar(50),
Lname nvarchar(50),
Salary float,
Designation nvarchar(50),
DOJ date)

create table Emps_LogInfo
(LogId int primary key identity,
Id int,
Fname nvarchar(50),
Lname nvarchar(50),
Salary float,
Designation nvarchar(50),
DOJ date,
Log_Action nvarchar(100),
Action_Time date)

select * from Emps
select * from Emps_LogInfo

Create trigger afterITrg
On Emps
After Insert
as
begin
Declare @id int
Declare @Fn nvarchar(50)
Declare @Ln nvarchar(50)
Declare @sal float
Declare @Desg nvarchar(50)
Declare @doj date
Declare @action nvarchar(100)
Select @id=id,@fn=Fname,@Ln=lname,@sal=salary,@desg=Designation,@Doj=doj 
From Inserted
Select @action='AfterInsert : Record Inserted'

Insert into Emps_Loginfo(id,Fname,Lname,Salary,Designation,Doj,Log_Action,Action_Time)
Values (@id,@fn,@ln,@sal,@desg,@doj,@action,getdate())

if(@@ROWCOUNT>=1)
Begin
Print 'After Trigger Says : Record Inserted & Your Action has captured in Log_infoTable'
End
End

insert into Emps(Id, Fname,Lname,Designation,Salary,DOJ)values (1,'Raj','Kumar','Manager',98000.5,'12/12/2012')
select * from Emps

select * from Emps_LogInfo