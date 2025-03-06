-- Active Schema
USE superstore;

-- Table Dataset
SELECT * FROM sales_data;

-- Table Structure
DESCRIBE sales_data;

-- Total Number of Records
SELECT count(*) Row_Count FROM sales_data;

-- Total Sales
SELECT round(sum(sales),2) Total_Sales 
FROM sales_data;

-- Total Number of Customer
SELECT count(distinct `Customer ID`) Total_Customer 
FROM sales_data;

-- Top 5 Most Sold Products
SELECT `Product Name`, SUM(`Quantity ordered new`) Total_Quantity_Sold
FROM sales_data
GROUP BY `Product Name`
ORDER BY Total_Quantity_Sold DESC
LIMIT 5;

-- Product Category wise Sales
select `product category` Product_Category,
round(sum(sales),2) Total_Sales
from sales_data
group by `product category`
order by Total_Sales desc;

-- Top 5 Best-Selling Products
select `product name` Product_Name,
round(sum(sales),2) Total_Sales  
from sales_data
group by `product name`
order by Total_Sales desc
limit 5;


