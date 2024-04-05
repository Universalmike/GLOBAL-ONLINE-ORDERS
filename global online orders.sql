SELECT *
FROM orders$ o
INNER JOIN ordersdetails$ d
ON o.OrderID=d.OrderID
INNER JOIN employees_profile e
ON o.EmployeeID=e.EmployeeID
SELECT *
FROM ordersdetails$

SELECT *
FROM customers$

--no. of customers from each city
SELECT City, COUNT(City) as no_of_customers_from_each_city
FROM customers$
GROUP BY City ORDER BY no_of_customers_from_each_city DESC

--average number of times customer revisit to order
SELECT AVG(no_of_retained_customers) as Average_no_of_times_customer_is_retained
FROM (SELECT CustomerID, COUNT(CustomerID) as no_of_retained_customers
FROM orders$
GROUP BY CustomerID
) as subquery

SELECT *
FROM products$

--top 10 highest revenue per product
SELECT top(10) o.ProductID, p.ProductName, ROUND(SUM(p.price * o.quantity), 0) as total_revenue
FROM ordersdetails$ o
INNER JOIN products$ p
ON o.ProductID=p.ProductID
GROUP BY o.ProductID, p.ProductName
order by total_revenue DESC

--the law of demand
SELECT o.ProductID, p.ProductName, o.Quantity, p.Price, p.Unit 
FROM ordersdetails$ o
INNER JOIN products$ p
ON o.ProductID=p.ProductID


--no of times each product is ordered
SELECT p.ProductName, COUNT(p.ProductName) as no_of_times_each_productOrdered
FROM ordersdetails$ o
INNER JOIN products$ p
ON o.ProductID=p.ProductID
GROUP BY p.ProductName ORDER BY no_of_times_each_productOrdered DESC

--checking the relationship between the price of each product and no. of times ordered
SELECT TOP (35)p.ProductName, p.price, COUNT(p.ProductName) as no_of_times_each_productOrdered
FROM ordersdetails$ o
INNER JOIN products$ p
ON o.ProductID=p.ProductID
GROUP BY p.ProductName,p.price

SELECT *
FROM categories$

SELECT COUNT(DISTINCT(ProductID))
FROM ordersdetails$

--categories each sales revenue
SELECT c.CategoryName,
SUM(p.price * o.quantity) as total_revenue
FROM ordersdetails$ o
INNER JOIN products$ p
ON o.ProductID=p.ProductID
INNER JOIN categories$ c
ON p.CategoryID=c.CategoryID
GROUP BY c.CategoryName


--Category of product that is most ordered
WITH table1 as (SELECT p.ProductName, c.CategoryName, COUNT(p.ProductName) as no_of_times_productSold
				FROM ordersdetails$ o
				INNER JOIN products$ p
				ON o.ProductID=p.ProductID
				INNER JOIN categories$ c
				ON p.CategoryID=c.CategoryID
				GROUP BY p.ProductName, c.CategoryName
)
SELECT CategoryName, SUM(no_of_times_productSold) as category_productOrdered
FROM table1
GROUP BY categoryName ORDER BY category_productOrdered


SELECT *
FROM suppliers$

SELECT *
FROM employees_profile

--CREATING EMPLOYEES_PROFILE FROM THE EMPLOYEES$ TABLE
SELECT *
INTO employees_profile
FROM employees$

--ADDING THE NEW COLUMNS TO THE NEW TABLE, EDUCATION, POSITION, AGE, DISCIPLINE
ADD Education VARCHAR(50); 

ALTER TABLE employees_profile
ADD Position VARCHAR(50);

ALTER TABLE employees_profile
ADD Age VARCHAR(50); 

SELECT *
FROM employees_profile

ALTER TABLE employees_profile
ADD Discipline VARCHAR(50); 

--DONE WITH ADDING THE NEW COLUMNS


---filling up the new columns with the related columns using the Notes column

--filling the Education column
UPDATE employees_profile
SET Education =
CASE
	WHEN EmployeeID = 1 THEN 'Bachelor'
    WHEN EmployeeID = 2 THEN 'PHD'
	WHEN EmployeeID = 3 THEN 'Bachelor'
	WHEN EmployeeID = 4 THEN 'Masters'
	WHEN EmployeeID = 5 THEN 'Bachelor'
	WHEN EmployeeID = 6 THEN 'Masters'
	WHEN EmployeeID = 7 THEN 'Bachelor'
	WHEN EmployeeID = 8 THEN 'Bachelor'
	WHEN EmployeeID = 9 THEN 'Bachelor'
	WHEN EmployeeID = 10 THEN 'Not stated'
END
WHERE EmployeeID IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10)

--Filling the Position column
UPDATE employees_profile
SET Position =
CASE
    WHEN EmployeeID = 2 THEN 'Vice-President'
	WHEN EmployeeID = 3 THEN 'sales representative'
	WHEN EmployeeID = 5 THEN 'sales manager'
	ELSE 'Not Stated'
END
WHERE EmployeeID IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10)

--filling up the Age column
UPDATE employees_profile
SET Age = 1996 - Year(BirthDate)
WHERE EmployeeID IN (2, 3, 4, 5, 6, 7, 8, 9, 10)

UPDATE employees_profile
SET Age = 1996 - Year(BirthDate)
WHERE EmployeeID = 1

--Filling up the Discipline Columns
UPDATE employees_profile
SET Discipline =
CASE
	WHEN EmployeeID = 1 THEN 'Psycology'
    WHEN EmployeeID = 2 THEN 'International Marketing'
	WHEN EmployeeID = 3 THEN 'Chemistry'
	WHEN EmployeeID = 4 THEN 'English'
	WHEN EmployeeID = 5 THEN 'Not stated'
	WHEN EmployeeID = 6 THEN 'Economics'
	WHEN EmployeeID = 7 THEN 'English'
	WHEN EmployeeID = 8 THEN 'Psycology'
	WHEN EmployeeID = 9 THEN 'English'
	WHEN EmployeeID = 10 THEN 'Not stated'
END
WHERE EmployeeID IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10)

---DONE COMPLETING THE EMPLOYEES_PROFILE TABLE