-- Active Schema
USE superstore;

-- Table Dataset
SELECT * 
FROM sales_data;

-- Table Structure
DESCRIBE sales_data;

-- Total Number of Records
SELECT 
	COUNT(*) Row_Count 
FROM sales_data;

SELECT
	COUNT(DISTINCT (`Row ID`)) RowID_Count
FROM sales_data;

-- Total Sales
SELECT 
	ROUND(SUM(sales),2) Total_Sales 
FROM sales_data;

-- Total Number of Customer
SELECT 
	COUNT(DISTINCT `Customer ID`) Total_Customer 
FROM sales_data;

-- Product Category wise Sales
SELECT 
	`Product Category` Product_Category,
	ROUND(SUM(sales),2) Total_Sales
FROM sales_data
GROUP BY `Product Category`
ORDER BY Total_Sales DESC;

-- Top 5 Most Sold Products
SELECT 
	`Product Name`, 
	SUM(`Quantity ordered new`) Total_Quantity_Sold
FROM sales_data
GROUP BY `Product Name`
ORDER BY Total_Quantity_Sold DESC
LIMIT 5;

-- Top 5 Best-Selling Products
SELECT 
	`Product Name` Product_Name,
	ROUND(SUM(sales),2) Total_Sales
FROM sales_data
GROUP BY `Product Name`
ORDER BY Total_Sales DESC
LIMIT 5;

-- Top 5 Customers by Sales
SELECT 
	`Customer Name` Customer_Name, 
	ROUND(SUM(sales),2) Total_Sales
FROM sales_data
GROUP BY `Customer Name`
ORDER BY total_sales DESC
LIMIT 5;

-- Customer Segment Sales Contribution 
SELECT 
	`Customer Segment` Customer_Segment,
	ROUND(SUM(sales),2) Total_Sales
FROM sales_data
GROUP BY `Customer Segment`;

-- Region wise Total Customer
SELECT 
	Region,
	COUNT(DISTINCT(`Customer ID`)) Total_Customer
FROM sales_data
GROUP BY Region;

-- Return by Product Category
SELECT 
	`Product Category` Product_Category,
	COUNT(*) Number_of_Return 
FROM sales_data 
WHERE `Return Status`="Returned" 
GROUP BY Product_Category;

-- Return Perentage
SELECT 
	SUM(CASE WHEN `Return Status`="Returned" THEN 1 ELSE 0 END) Returned,
	SUM(CASE WHEN `Return Status`="Not Returned" THEN 1 ELSE 0 END) Not_Returned,
	ROUND(SUM(CASE WHEN `Return Status`="Returned" THEN 1 ELSE 0 END)/(COUNT(`Return Status`))*100,2) Return_Percentage
FROM sales_data;
    
-- Yearly & Monthly Sales
SELECT 
    YEAR(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) YEAR,
    MONTH(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) MONTH,
	ROUND(SUM(sales),2) Total_Sales
FROM sales_data
GROUP BY YEAR, MONTH
ORDER BY YEAR, MONTH;

-- Order Priority wise Sales
SELECT 
	DISTINCT(`Order Priority`) Order_Priority,
	ROUND(SUM(Sales),2) Total_Sales
FROM sales_data
WHERE  `Order Priority`=TRIM(`Order Priority`)
GROUP BY `Order Priority`
ORDER BY Total_Sales DESC;
