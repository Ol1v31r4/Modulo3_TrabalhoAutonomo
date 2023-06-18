use Northwind

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
--Brazil, Mexico, ArgentinaVenezuela 
--It doesn’t make sense to use multiple Or statements anymore, it would get too convoluted. Use the "In" statement.

select * 
	from Orders
where ShipCountry in ('Brazil','Mexico','Argentina','Venezuela')

--10 - For all the employees in the Employees table, show the FirstName, LastName, Title, and BirthDate. 
--Order the results by BirthDate, so we have the oldest employees first.

select FirstName, LastName, Title, BirthDate 
	from Employees
order by BirthDate ASC

--11 - In the output of the query above, showing the Employees in order of BirthDate, we see the time of the 
--BirthDate field, which we don’t want. Show only the date portion of the BirthDate field.

select FirstName, LastName, Title, cast(BirthDate as date) as BirthDate 
	from Employees
order by BirthDate


--12 - Show the FirstName and LastName columns from the Employees table, and then create a new column 
--called FullName, showing FirstName and LastName joined together in one column, with a space in-between.
select (FirstName + ' ' + LastName) as FullName 
	from Employees

--13 - In the OrderDetails table, we have the fields UnitPrice and Quantity. Create a new field, TotalPrice, that multiplies these two together. 
--We’ll ignore the Discount field for now. In addition, show the OrderID, ProductID, UnitPrice, and Quantity. Order by OrderID and ProductID.

select (UnitPrice * Quantity) as TotalPrice, OrderID, ProductID, UnitPrice, Quantity 
	from OrderDetails 
order by OrderID , ProductID ASC

--14 - How many customers do we have in the Customers table? Show one value only, 
--and don’t rely on getting the recordcount at the end of a resultset.

select count (CustomerID) 
	from Customers

--15 - Show the date of the first order ever made in the Orders table.

select distinct year(OrderDate) 
	from Orders
order by year(OrderDate) asc

--16 - Show a list of countries where the Northwind company has customers.

select distinct Country 
	from Customers

--17 - Show a list of all the different values in the Customers table for ContactTitles. 
--Also include a count for each ContactTitle. This is similar in concept to the previous question 
--“Countries where there are customers”, except we now want a count for each ContactTitle.

select ContactTitle, count(1) as 'Number of Titles of Contact'
	from Customers
	group by ContactTitle 			

--18 - We’d like to show, for each product, the associated Supplier. 
--Show the ProductID, ProductName, and the CompanyName of the Supplier. Sort by ProductID.

select ProductID, ProductName, CompanyName 
from Suppliers
inner join Products
on Suppliers.SupplierId = Products.SupplierId 


--19 -We’d like to show a list of the Orders that were made, including the Shipper that was used. Show the OrderID, OrderDate (date only), 
--and CompanyName of the Shipper, and sort by OrderID. In order to not show all the orders (there’s more than 800), 
--show only those rows with an OrderID of less than 10300.

select OrderID, cast(OrderDate as date), CompanyName
	from Shippers, Orders 
where orderID < 10300
	order by OrderID

--select OrderID, cast(OrderDate as date), CompanyName
--	from Shippers
--inner join Orders
--on Shippers.ShipperID = Orders.
--where orderID < 10300
--	order by OrderID

--20 - For this problem, we’d like to see the total number of products in each category. 
--Sort the results by the total number of products, in descending order.

select CategoryID, count(1) as 'Counts Of Products'
from Products
group by CategoryID
order by CategoryID desc

--21 - In the Customers table, show the total number of customers per Country and City.

select Country, count (1) as 'Total number of costumers'
from Customers
group by Country


--22 - What products do we have in our inventory that should be reordered? For now, just use the fields UnitsInStock and ReorderLevel, 
--where UnitsInStock is less than the ReorderLevel, ignoring the fields UnitsOnOrder and Discontinued. Order the results by ProductID.

select UnitsInStock, ReorderLevel, ProductID 
from Products
where UnitsInStock < ReorderLevel
order by ProductID

--23 - Now we need to incorporate these fields—UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued—into our calculation. 
--We’ll define “products that need reordering” with the following:
--UnitsInStock plus UnitsOnOrder are less than or equal to ReorderLevel
--The Discontinued flag is false (0).

select UnitsInStock, ReorderLevel, ProductID 
from Products
where UnitsInStock + UnitsOnOrder <= ReorderLevel
order by ProductID

--24 -A salesperson for Northwind is going on a business trip to visit customers, and would like to see a list of all customers, sorted by region, 
--alphabetically. However, he wants the customers with no region (null in the Region field) to be at the end, instead of at the top, where you’d 
--normally find the null values. Within the same region, companies should be sorted by CustomerID.

select * 
from Customers
order by case 
when Region is null then'zzz'
else Region
end;

--25 - Some of the countries we ship to have very high freight charges. We'd like to investigate some more shipping options for our customers, 
--to be able to offer them lower freight charges. Return the three ship countries with the highest average 
--freight overall, in descending order by average freight.

select top 3
ShipCountry, AverageFreight = avg (freight)
from Orders
group by ShipCountry
order by AverageFreight desc;


--26 - We're continuing on the question above on high freight charges. 
--Now, instead of using all the orders we have, we only want to see orders from the year 2015.
select top 3
ShipCountry, AverageFreight = avg (freight)
from Orders
where year(OrderDate) = '2015'
group by ShipCountry
order by AverageFreight desc;


--27 - Another (incorrect) answer to the problem above is this:
Select Top 3
    ShipCountry
    ,AverageFreight = avg(freight)
From Orders
Where
    OrderDate between '1/1/2015' and '12/31/2015'
Group By ShipCountry
Order By AverageFreight desc;

--SOLUCAO

Select Top 3
    ShipCountry
    ,AverageFreight = avg(freight)
From Orders
Where
    year(OrderDate) = '2015'
Group By ShipCountry
Order By AverageFreight desc;

Select OrderID, ShipCountry, AverageFreight = avg(freight)
From Orders
Where Year(OrderDate) = '2015' 

--Notice when you run this, it gives Sweden as the ShipCountry with the third highest freight charges. However, this is wrong - it should be France. 
--What is the OrderID of the order that the (incorrect) answer above is missing?

--ao fazer o between ele vai saltar pedidos que foram feitos no dia 31/12. Os
--pedidos realizados nessas datas nao estao incluidos

--28 - We're continuing to work on high freight charges. We now want to get the three ship countries with the highest average freight charges. 
--But instead of filtering for a particular year, we want to use the last 12 months of order data, using as the end date the last OrderDate in Orders.

Select top 3
ShipCountry, AverageFreight = avg(freight)
From Orders
where OrderDate between '2015-05-06' and '2016-05-06'
group by ShipCountry
order by avg(freight) desc

--29 - We're doing inventory, and need to show information like the below, for all orders. Sort by OrderID and Product ID.

select Employees.EmployeeID, LastName, Orders.OrderID, ProductName, Quantity, Products.ProductID
from OrderDetails
inner join Orders
on Orders.OrderID = OrderDetails.OrderID
inner join Employees
on Employees.EmployeeID = Orders.EmployeeID
inner join Products
on Products.ProductID = OrderDetails.ProductID
Order by OrderID, Products.ProductID


--30 - There are some customers who have never actually placed an order. Show these customers.

select Customers.CustomerID 
from Customers
left join Orders
on Customers.CustomerID = Orders.CustomerID
where Orders.CustomerID is null

--31 - One employee (Margaret Peacock, EmployeeID 4) has placed the most orders. However, there are some customers who've never placed an order with her. 
--Show only those customers who have never placed an order with her.

select CustomerID
from Customers
where
CustomerID not in (select DISTINCT(CustomerID) from Orders);
