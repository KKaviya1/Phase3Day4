create database BasicDb
use BasicDb

create table Salary
(Grade nvarchar(5) primary key,
BSalary float not null,
HRA as BSalary*0.10 persisted,
TA as BSalary*0.15 persisted,
DA as BSalary*0.18 persisted)

insert into Salary values('A',50000)
select * from Salary
insert into Salary values('B',50000)
update Salary set Bsalary=30000 where Grade='B'
select * from Salary