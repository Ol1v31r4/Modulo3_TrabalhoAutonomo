use Northwind

-- Diferença de ano e data de nascimento
SELECT age = Year(getDate()) - Year(BirthDate) FROM Employees
where Title = 'Sales Manager'
 
-- Date Diff
SELECT DateDiff(YY, Birthdate, getDate()) - Year(BirthDate) as AGE FROM Employees
where Title = 'Sales Manager'


--1 - Which shippers do we have? We have a table called Shippers. Return all the fields from all the shippers.
select * 
	from Shippers

--2 -  In the Categories table, selecting all the fields using this SQL: 
-- "Select * from Categories" will return 8 columns. We only want to see two columns, CategoryName and Description.
select CategoryName, Description 
	from Categories

--3 - We’d like to see just the FirstName, LastName, and HireDate of all the employees with the Title of Sales Representative. 
--Write a SQL statement that returns only those employees.
select FirstName, LastName, HireDate, Title 
	from Employees 
where Title = 'Sales Representative'

--4 - Now we’d like to see the same columns as above, but only for those employees 
--that both have the title of Sales Representative, and also are in the United States.
select FirstName, LastName, HireDate, Country, Title 
	from Employees 
where Title + Country = 'Sales Representative' + 'USA'

--5 - Show all the orders placed by a specific employee. 
--The EmployeeID for this Employee (Steven Buchanan) is 5.
select EmployeeID, OrderID 
	from Orders
where EmployeeID = 5

--6 - In the Suppliers table, show the SupplierID, ContactName, and ContactTitle for 
--those Suppliers whose ContactTitle is not Marketing Manager.
select SupplierID, ContactName, ContactTitle 
	from Suppliers
where ContactTitle != 'Marketing Manager'

--7 - In the products table, we’d like to see the ProductID and ProductName for 
--those products where the ProductName includes the string “queso”.
select ProductName, ProductID 
	from Products
where ProductName like '%queso%'

--8 - Looking at the Orders table, there’s a field called ShipCountry. 
--Write a query that shows the OrderID, CustomerID, and ShipCountry for the orders where the ShipCountry is either France or Belgium.
select * 
	from Orders
where ShipCountry = 'France' or ShipCountry = 'Belgium'

--9 - Now, instead of just wanting to return all the orders from France of Belgium, we want to show all the orders from any Latin American country. 
--But we don’t have a list of Latin American countries in a table in the Northwind database. So, we’re going to just use this list of Latin American countries that happen to be in the Orders table:
--Brazil
--Mexico
--Argentina
--Venezuela 
--It doesn’t make sense to use multiple Or statements anymore, it would get too convoluted. Use the In statement.

select * 
	from Orders
where ShipCountry in ('Brazil','Mexico','Argentina','Venezuela')

--10 - For all the employees in the Employees table, show the FirstName, LastName, Title, and BirthDate. 
--Order the results by BirthDate, so we have the oldest employees first.

select FirstName, LastName, Title, BirthDate 
	from Employees
order by BirthDate ASC





