--1 Quantos clientes
select count(ContactName) from Customers

--2 Quantos clientes de berlin
select * from Orders
where ShipCity = 'Berlin'

--3 Quantas regioes e quais
select count (distinct ShipCountry), ShipCountry from Orders
group by ShipCountry

--4 Qual e o ultimo nome da laura e titulo
select FirstName, LastName, TitleOfCourtesy from Employees
where FirstName = 'Laura'

--5 Pessoa mais velha da northwind
SELECT age = Year(getDate()) - Year(BirthDate) FROM Employees			--o modificador da idade foi feito logo no select
where Title = 'Sales Manager'


--6 Todas as colunas da tabela regiao
-- IMPOSSIVEL DE FAZER NAO TEM TABELA DE REGIAO

--7 Selecionar primeiro e ultimo nome da tabela empregados
select FirstName, LastName from Employees

--8 selecionar primeiro e ultimo nome da tabela empregados sort by last name
select FirstName, LastName from Employees
order by LastName Asc

--9 criar um relatorio a mostrar das orders da northwind sorted by mais caro a mais barato 
-- mostrar orderID, OrderDate, ShippedDate, CustomerID e Freight
select OrderID, OrderDate, ShippedDate, CustomerID, Freight from Orders 
order by Freight Asc

--10 criar um relatorio onde mostra o titutlo e o primeiro e ultimo nome de todos os vendedores
select FirstName, LastName, Title from Employees
where Title = 'Sales Representative'
