-- 23-04-25 SQL Sales data 
use salesdata23;
select * from sales_data;
-- total sales value
select quantity*price Total_sales from sales_data;
-- Monthly Sales Trends
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(quantity*price) AS Total_sales
FROM
    sales_data
GROUP BY
    month
ORDER BY
    month;
-- TOP FIVE PRODUCTS BY SALES values
SELECT
    product_name,
    SUM(quantity * price) AS Total_revenue
FROM
    sales_data
GROUP BY
    product_name
ORDER BY
    Total_revenue DESC
LIMIT 5;

-- sales by Region
SELECT
    region,
    SUM(quantity * price) AS Total_revenue
FROM
    sales_data
GROUP BY
    region
ORDER BY
    Total_revenue DESC;
-- 5.	Customer Purchase Frequency
select * from sales_data;
SELECT
    customer_id,
    COUNT(DISTINCT order_id) AS Total_orders
FROM
    sales_data
GROUP BY
    customer_id
ORDER BY
    total_orders DESC
LIMIT 10;
-- 6.	Category-wise Revenue Contribution
SELECT * FROM sales_data;
SELECT
    category,
    SUM(quantity * price) AS Total_revenue
FROM
    sales_data
GROUP BY
    category
ORDER BY
    Total_revenue DESC;
    -- 7.	Repeat Customer Rate
    SELECT * FROM sales_data;
    SELECT 
        COUNT(*) AS customers_with_multiple_purchases
FROM (
    SELECT customer_id
    FROM sales_data
    GROUP BY customer_id
    HAVING COUNT(DISTINCT order_id) > 1
) AS sub;
    
