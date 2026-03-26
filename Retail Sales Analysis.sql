-- Showing performance by Region and Segment , sort to show region with highest order by Segment first
 SELECT  Region, Segment,
	COUNT(`Order ID`) AS Order_count,
	ROUND(sum(Sales),2) AS total_sales,
	ROUND(avg(Sales),2) AS avg_sales
 FROM superstore_sales
 GROUP BY  Region, Segment
 ORDER BY Region DESC, Segment;
 
 --  Showing geographic Trends among Regions using Total Sales as a metric
SELECT Region, 
	ROUND(SUM(Sales),2) AS total_sales
FROM superstore_sales
GROUP BY Region
ORDER BY total_sales DESC;
 
 -- Showing Percentage Distribution among States
SELECT State, 
	ROUND(SUM(Sales),0) AS State_Sales, 
	ROUND((SUM(Sales) * 100.0 / SUM(SUM(Sales)) OVER()),2) AS Percentage
FROM superstore_sales
GROUP BY State
ORDER BY Percentage DESC;

-- Identifying states that are most represented
SELECT State, 
	COUNT(*) AS total_records
FROM superstore_sales
GROUP BY State
ORDER BY total_records DESC;

--  Showing Products Performance characteristics (count of orders, distinct customers, total sales and average quantity) where number of products sold > 5 and Sales >= 5000
SELECT `Product ID`, 
	COUNT(`Order ID`) AS order_count,
	COUNT(DISTINCT `Customer ID`) AS customer_count,
    ROUND(SUM(Sales),0) AS total_sales,
	ROUND(AVG(Quantity),2) AS avg_quantity
FROM superstore_sales
GROUP BY `Product ID`
HAVING order_count > 10 AND SUM(Sales) >=5000;

-- Determining if discounts drive higher sales and profit where Discount = 0, No Discount, Discount is between 0 and 0.10, 1-10%, Discount is between 0.11 and 0.20, 11-20% and Discount >20&, Above 20%
SELECT
    CASE
        WHEN Discount = 0 THEN 'No Discount'
        WHEN Discount BETWEEN 0.01 AND 0.10 THEN '1-10%'
        WHEN Discount BETWEEN 0.11 AND 0.20 THEN '11-20%'
        ELSE 'Above 20%'
    END AS Discount_Range,
    ROUND(SUM(Sales),0) AS Total_Sales,
    ROUND(SUM(Profit),0) AS Total_Profit,
    ROUND(AVG(Profit),2) AS Avg_Profit
FROM superstore_sales
GROUP BY
    CASE
        WHEN Discount = 0 THEN 'No Discount'
        WHEN Discount BETWEEN 0.01 AND 0.10 THEN '1-10%'
        WHEN Discount BETWEEN 0.11 AND 0.20 THEN '11-20%'
        ELSE 'Above 20%'
    END
ORDER BY Total_Profit DESC;

-- identifying percentage of good and bad profit margin (WHERE Profit_margin >= 30 is Very Good, Profit_margin >= 20 is Good,  Profit_margin < 20 is  Fair, Profit_margin < 0 is  Very Bad)
WITH enriched_superstore_sales AS (
SELECT *,
	ROUND((100 * Profit / Sales),2) AS Profit_margin
   FROM superstore_sales
    )
SELECT `Order ID`, Sales, Profit, Profit_margin,
CASE 
	WHEN Profit_margin >= 30 THEN 'Very Good'
	WHEN Profit_margin >= 20 THEN 'Good'
	WHEN Profit_margin >0 THEN 'Fair'
ELSE 'Bad'
END AS Profit_margin_status
FROM enriched_superstore_sales
LIMIT 10;

-- Showing top 10 customers and their region
SELECT `Customer ID`, Region, sales
FROM superstore_sales
ORDER BY SALES DESC
LIMIT 10;

-- Showing 5 top Products with highest profit
SELECT  `Product ID`, profit
FROM superstore_sales
ORDER BY profit DESC
LIMIT 5; 

-- Showing the number of unique customers that placed orders
SELECT
	COUNT(DISTINCT `Customer ID`) AS customer_count
FROM superstore_sales;
 
 -- Showing Order ID with sales between 5000 and 10000 
SELECT `order ID`, sales
FROM superstore_sales
WHERE sales BETWEEN 5000 AND 10000;

 --  Showing cutomers with orders above $5000 in west region
    SELECT `order id`, sales, region
FROM superstore_sales  
WHERE sales >5000  AND Region = "West"
    ORDER BY sales DESC;    
    
-- Showing cutomers with orders above $5000 outside west region
    SELECT `order id`, sales, region
FROM superstore_sales  
WHERE sales >5000  AND Region <> "West"
    ORDER BY sales DESC;    
    
    USE superstore_db;

SELECT * FROM superstore_sales;