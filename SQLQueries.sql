SELECT * FROM pizza_sales;

### Update type for order_date và order_time to date
UPDATE pizza_sales
SET order_time = STR_TO_DATE(order_time, '%H:%i:%s'),
    order_date = STR_TO_DATE(order_date, '%d-%m-%Y');


### KPI's Requirement
# 1. Total Revenue
SELECT 
	SUM(total_price) AS Total_Revenue 
FROM 
	pizza_sales;

#2. Average Order values
SELECT 
	CAST(SUM(total_price) / COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS AVG_Order_Value 
FROM 
	pizza_sales;

#3. Total Pizzas Sold
SELECT 
	SUM(quantity) AS Total_Pizza_Sold 
FROM 
	pizza_sales;

#4. Total Orders
SELECT 
	COUNT(DISTINCT order_id) AS Total_Order 
FROM 
	pizza_sales;

#5. Average Pizzas Per Order
SELECT 
	CAST(SUM(quantity) / COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS AVG_Pizza_Per_Order
FROM 
	pizza_sales;
    
### Daily Trend for Total Orders
SELECT 
	DAYNAME(order_date) AS Order_Day, 
    COUNT(DISTINCT order_id) AS Order_Count
FROM
	pizza_sales
GROUP BY
	DAYNAME(order_date)
ORDER BY
	Order_Count DESC;
    
### Monthly Trend for Total Orders
SELECT
	MONTHNAME(order_date) as Month, 
    COUNT(DISTINCT order_id) AS Total_Orders
FROM 
	pizza_sales
GROUP BY  
	MONTHNAME(order_date)
ORDER BY 
	COUNT(DISTINCT order_id) DESC;
    
### Percentage of Sales by Pizza Category
SELECT 
	pizza_category,
    CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_revenue,
    CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM 
	pizza_sales
GROUP BY 
	pizza_category;

### Percentage of Sales by Pizza Size
SELECT 
	pizza_size,
    CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_revenue,
    CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM 
	pizza_sales
GROUP BY 
	pizza_size
ORDER BY
	pizza_size;

### Total Pizzas Sold by Pizza Category
SELECT 
	pizza_category, 
	SUM(quantity) as Total_Quantity_Sold
FROM 
	pizza_sales
GROUP BY 
	pizza_category
ORDER BY 
	Total_Quantity_Sold DESC;

### Top 5 Pizzas by Revenue
SELECT 
	pizza_name, 
	SUM(total_price) AS Total_Revenue
FROM 
	pizza_sales
GROUP BY 
	pizza_name
ORDER BY 
	Total_Revenue DESC
LIMIT 5;

### Bottom 5 Pizzas by Revenue
SELECT 
	pizza_name, 
	SUM(total_price) AS Total_Revenue
FROM 
	pizza_sales
GROUP BY 
	pizza_name
ORDER BY 
	Total_Revenue ASC
LIMIT 5;

### Top 5 Pizzas by Quantity
SELECT 
	pizza_name, 
	SUM(quantity) AS Total_Pizza_Sold
FROM 
	pizza_sales
GROUP BY 
	pizza_name
ORDER BY 
	Total_Pizza_Sold DESC
LIMIT 5;

### Bottom 5 Pizzas by Quantity
SELECT 
	pizza_name, 
	SUM(quantity) AS Total_Pizza_Sold
FROM 
	pizza_sales
GROUP BY 
	pizza_name
ORDER BY 
	Total_Pizza_Sold ASC
LIMIT 5;

### Top 5 Pizzas by Total Orders
SELECT 
	pizza_name, 
	COUNT(DISTINCT order_id) AS Total_Orders
FROM 
	pizza_sales
GROUP BY 
	pizza_name
ORDER BY 
	Total_Orders DESC
LIMIT 5;

### Bottom 5 Pizzas by Total Orders
SELECT 
	pizza_name, 
	COUNT(DISTINCT order_id) AS Total_Orders
FROM 
	pizza_sales
GROUP BY 
	pizza_name
ORDER BY 
	Total_Orders ASC
LIMIT 5;