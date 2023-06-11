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




