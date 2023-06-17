use Northwind

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
