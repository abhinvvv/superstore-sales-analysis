
--    Project 1: Superstore Sales Analysis
--    Tool: MySQL
--    Table: samplesuperstore

use p1;
-- Q1: Total Sales & Total Profit
SELECT 
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit
FROM samplesuperstore;


-- Q2: Number of Unique Orders
SELECT 
    COUNT(DISTINCT `Order ID`) AS total_orders
FROM samplesuperstore;


-- Q3: Profit Margin
SELECT 
    p / s AS profit_margin
FROM (
    SELECT 
        SUM(Profit) AS p,
        SUM(Sales) AS s
    FROM samplesuperstore
) t;


-- Q4: Year-wise Sales
SELECT 
    YEAR(
        CASE 
            WHEN `Order Date` LIKE '%-%'
                THEN STR_TO_DATE(`Order Date`, '%m-%d-%Y')
            ELSE STR_TO_DATE(`Order Date`, '%m/%d/%Y')
        END
    ) AS order_year,
    SUM(Sales) AS total_sales
FROM samplesuperstore
GROUP BY order_year
ORDER BY order_year;


-- Q5: Top Categories by Total Sales
SELECT  
    Category,
    SUM(Sales) AS total_sales
FROM samplesuperstore 
GROUP BY Category
ORDER BY total_sales DESC
LIMIT 5;


-- Q6: Most Profitable Regions
SELECT
    Region,
    SUM(Profit) AS total_profit
FROM samplesuperstore
GROUP BY Region
ORDER BY total_profit DESC;


-- Q7: High Sales but Low Profit (Category-wise)
SELECT
    Category,
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit
FROM samplesuperstore
GROUP BY Category
ORDER BY total_sales DESC, total_profit ASC;


-- Q8: Loss-making Sub-Categories
SELECT
    `Sub-Category`,
    SUM(Profit) AS total_profit
FROM samplesuperstore
GROUP BY `Sub-Category`
HAVING SUM(Profit) < 0
ORDER BY total_profit;


-- Q9: Profit by Discount Level
SELECT
    Discount,
    SUM(Profit) AS total_profit
FROM samplesuperstore
GROUP BY Discount
ORDER BY Discount;


-- Q10: Average Shipping Delay (in days)
SELECT  
    AVG(
        DATEDIFF(
            CASE 
                WHEN `Ship Date` LIKE '%/%'
                    THEN STR_TO_DATE(`Ship Date`, '%m/%d/%Y') 
                ELSE STR_TO_DATE(`Ship Date`, '%m-%d-%Y')
            END,
            CASE 
                WHEN `Order Date` LIKE '%/%' 
                    THEN STR_TO_DATE(`Order Date`, '%m/%d/%Y') 
                ELSE STR_TO_DATE(`Order Date`, '%m-%d-%Y')
            END
        )
    ) AS avg_shipping_delay
FROM samplesuperstore;
