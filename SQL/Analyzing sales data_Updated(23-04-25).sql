-- 23-04-25 SQL Sales data 
drop table sales_data;
use salesdata23;
select * from sales_data_1;
-- total sales value
select quantity*price Total_sales from sales_data_1;
-- Monthly Sales Trends
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(quantity*price) AS Total_sales
FROM
    sales_data_1
GROUP BY
    month
ORDER BY
    month;
-- TOP FIVE PRODUCTS BY SALES values
SELECT
    product_name,
    SUM(quantity * price) AS Total_revenue
FROM
    sales_data_1
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
    sales_data_1
GROUP BY
    region
ORDER BY
    Total_revenue DESC;
-- 5.	Customer Purchase Frequency
select * from sales_data_1;
SELECT
    customer_id,
    COUNT(DISTINCT order_id) AS Num_orders
FROM
    sales_data_1
GROUP BY
    customer_id
ORDER BY
    Num_orders DESC
LIMIT 10;
-- 6.	Category-wise Revenue Contribution
SELECT * FROM sales_data_1;
SELECT
    category,
    SUM(quantity * price) AS Total_revenue
FROM
    sales_data_1
GROUP BY
    category
ORDER BY
    Total_revenue DESC;
    
   -- Corrected another way to find out category wise reveneu in percentage
   SELECT 
  category,
  ROUND(SUM(quantity * price) * 100.0 / 
        (SELECT SUM(quantity * price) FROM sales_data_1), 2) AS percentage_of_total_revenue
FROM sales_data_1
GROUP BY category
ORDER BY percentage_of_total_revenue DESC;
   
    -- 7.	Repeat Customer Rate
    SELECT * FROM sales_data_1;
    SELECT 
        COUNT(*) AS customers_with_multiple_purchases
FROM (
    SELECT customer_id
    FROM sales_data_1
    GROUP BY customer_id
    HAVING COUNT(DISTINCT order_id) > 1
) AS sub;
-- currected anotherway
SELECT COUNT(*) AS repeat_customers
FROM (
  SELECT customer_id
  FROM sales_data_1
  GROUP BY customer_id
  HAVING COUNT(DISTINCT order_id) > 1
) AS repeated;

    
