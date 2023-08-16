create database Day4
use Day4
--create proc procName
--@parameters
--as
--sql statement
--------------------------------------------------------------------------
create table Employee
(Id int primary key,
Fname nvarchar(50),
Lname nvarchar(50),
Designation nvarchar(50),
salary float,
DOJ datetime)

insert into Employee values (10,'Priya','Elango','Pharmacist',20000.50,'10/08/2023')
insert into Employee values (3,'Kaviya','Gandhi','Software Engineer',65000.90,'03/05/2023')
insert into Employee values (4,'Gai-3','Karthik','Doctor',90000.50,'11/12/2023')
insert into Employee values (12,'Ganesh','Selvan','Developer',40000.50,'01/08/2023') 

select * from Employee
-------------------------------------------------------------------------------------------------
create proc usp_sPro
as
select * from Employee
exec usp_sPro

---------------------------------------------------------------------------------------------------
create proc usp_sEmpById
@id int
as
select * from Employee where Id=@id
exec usp_sEmpById 10
exec usp_sEmpById 3
exec usp_sEmpById 4

--default--

create proc usp_EmpById
@id int=1
as
select * from Employee where Id=@id
exec usp_EmpById 10
exec usp_EmpById 


alter proc usp_EmpById
@id int=2
as
select * from Employee where Id=@id
exec usp_EmpById 3
exec usp_EmpById

---------------------------------------------------------------
--write one stored procedure to update employee record based on Id 
create proc usp_uEmp
@id int,
@fn nvarchar(50),
@ln nvarchar(50),
@desg nvarchar(50),
@sal float,
@doj datetime
as
update Employee set Id=@id,Fname=@fn,Lname=@ln,Designation=@desg,Salary=@sal,DoJ=@doj where Id=@id
if(@@ROWCOUNT>=1) 
print 'Record Updated!!'

exec usp_uEmp 4,'Viya','K','S/W Developer',65000.30,'05/29/2023'
exec usp_sPro

--------------------------------------------------------------------------
create proc usp_dEmp
@id int 
as
delete from Employee where Id=@id
if(@@ROWCOUNT>=1)
print 'Record Deleted!!'

exec usp_dEmp 6

exec usp_sPro
-----------------------------------------------------------
exec sp_server_info
exec sp_tables
exec sp_help
exec sp_helptext 'usp_uEmp'
----------------------------------------------------------------------
exec sp_helptext usp_dEmp

alter proc usp_dEmp
@id int 
with encryption
as
delete from Employee where Id=@id
if(@@ROWCOUNT>=1)
print 'Record Deleted!!'

exec sp_helptext usp_dEmp
-------------------------------------------------
alter proc usp_uEmp
@id int,
@fn nvarchar(50),
@ln nvarchar(50),
@desg nvarchar(50),
@sal float,
@doj datetime
with encryption
as
update Employee set Id=@id,Fname=@fn,Lname=@ln,Designation=@desg,Salary=@sal,DoJ=@doj where Id=@id
if(@@ROWCOUNT>=1) 
print 'Record Updated!!'

exec sp_helptext usp_uEmp
-----------------------------

exec sp_helptext usp_uEmp

select * from Employee

insert into Employee values (10,'Priya','Elango','Pharmacist',20000.50,'10/08/2023')
insert into Employee values (19,'sam','Doss','Developer',35000.50,'02/08/2023') 
insert into Employee values (15,'Harish','Krish','Developer',41000.50,'05/08/2023') 
insert into Employee values (3,'Kaviya','Gandhi','Software Engineer',65000.90,'03/05/2023')
insert into Employee values (4,'Gai-3','Karthik','Doctor',90000.50,'11/12/2023')
insert into Employee values (12,'Ganesh','Selvan','Developer',40000.50,'01/08/2023') 

select * from Employee
select count (Id) from employee where Designation = 'Developer'

--output
create proc sp_DesgCount
@desig nvarchar(50),
@noe int output
as
select @noe=count(Id) from Employee where Designation=@design

declare @EmpCount int
execute sp_DesgCount 'Tester', @EmpCount output
print @EmpCount
----------------------------------------------------------------------


