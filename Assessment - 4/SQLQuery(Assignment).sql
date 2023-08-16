create database Assessment04Db
use Assessment04Db

create table Products (
    pid int primary key identity(500, 1),
    pname nvarchar(255) not null,
    pprice float null,
    ptax float,
    pcompany nvarchar(50) check (pcompany in ('samsung', 'apple', 'redmi', 'htc', 'realme', 'xiaomi')),
    pqty int default 10 check (pqty >= 1),
    ppricewithtax as (pprice + (ptax * pprice / 100)) persisted,
    totalprice as (pprice * pqty) persisted
)

insert into products (pname, pprice, ptax, pcompany, pqty) values('Product 1',18000.00,10,'Samsung', 2),
('Product 2',120000.00,10,'Apple', 1),
('Product 3',12000.00,10,'Redmi', 4),
('Product 4',10000.00,10,'HTC', 2),
('Product 5',21000.00,10,'Realme', 5),
('Product 6',11000.00,10,'Xiaomi', 2),
('Product 7',15500.00,10,'Vivo', 2),
('Product 8',193000.00,10,'Oppo', 3),
('Product 9',8000.00,10,'Nokia', 1),
('Product 10',42000.00,10,'OnePlus', 3)

create procedure dbo.displayproductdetails
as
begin
    select pid, pname, ppricewithtax, pcompany, totalprice from products;
end
go

exec dbo.displayproductdetails

alter procedure dbo.displayproductdetails
with encryption
as
begin
    select pid, pname, ppricewithtax, pcompany, totalprice
    from products;
end
go

create procedure dbo.calculatetotaltax
    @inputpcompany nvarchar(50),
    @outputtotaltax float output
as
begin
    select @outputtotaltax = sum(ptax * pprice / 100)
    from products
    where pcompany = @inputpcompany
end
go

declare @outputTotalTax float
exec dbo.calculatetotaltax 'samsung', @outputTotalTax output;
print 'Total Tax for Samsung: ' + cast(@outputTotalTax as nvarchar)

alter procedure dbo.calculatetotaltax
    @inputpcompany nvarchar(50),
    @outputtotaltax float output
with encryption
as
begin
    select @outputtotaltax = sum(ptax * pprice / 100)
    from products
    where pcompany = @inputpcompany
end
go


