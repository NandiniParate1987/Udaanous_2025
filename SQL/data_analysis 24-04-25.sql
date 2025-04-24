use database5;
select * from customers; -- customer_id, customer_name, region , signup_date
select * from order_items; -- order_item_id ,  order_id, product_id, quantity, price
select * from orders; -- order_id , customer_id , order_date, total_amount
select * from products; -- product_id, product_name, category, cost

-- 1.	Monthly Revenue
-- o	Calculate total revenue per month.
-- o	Format: YYYY-MM, total_revenue

SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS Month,
    SUM(total_amount) AS Total_revenue
FROM
    orders
GROUP BY
    Month
ORDER BY
    Month;
    
--    2.	Customer Lifetime Value
-- o	For each customer, calculate their total spend (total_amount from orders).
-- o	Show top 5 customers by lifetime value.
SELECT 
    c.customer_id,
    SUM(total_amount) AS Customer_lifetime_value
FROM 
    orders o 
    JOIN customers c ON c.customer_id = o.customer_id
GROUP BY 
c.customer_id
ORDER BY 
    Customer_lifetime_value DESC
LIMIT 5;

-- 3.	Most Popular Product by Region
-- o	Join data to find the most frequently ordered product in each region.
    
    WITH product_orders AS (
    SELECT c.region,oi.product_id,
        COUNT(*) AS order_count
    FROM order_items oi JOIN orders o ON oi.order_id = o.order_id
    JOIN customers c ON o.customer_id = c.customer_id
    GROUP BY c.region, oi.product_id),
ranked_products AS (
    SELECT *, RANK() OVER (PARTITION BY region ORDER BY order_count DESC) AS renk_no
    FROM product_orders
)
SELECT rp.region,p.product_name,rp.order_count
FROM ranked_products rp JOIN products p ON rp.product_id = p.product_id
WHERE rp.renk_no = 1;

-- 4.	Profit Analysis
-- o	For each product, compute total profit:
-- 	Profit = (price - cost) * quantity
-- 	Show top 5 most profitable products.
SELECT 
    p.product_id,
    p.product_name,
    SUM((oi.price - p.cost) * oi.quantity) AS total_profit
FROM 
    order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY 
    p.product_id, p.product_name
ORDER BY 
    total_profit DESC
LIMIT 5;

-- 5.	New vs Returning Customers
-- In each month, count how many orders were placed by:
-- New customers (first-time order)
-- Returning customers (second order or later)


-- Step 1: Get first order date for each customer
WITH customer_first_order AS (
    SELECT 
        customer_id,
        MIN(order_date) AS first_order_date
    FROM orders
    GROUP BY customer_id
),

-- Step 2: Classify each order as New or Returning
orders_with_type AS (
    SELECT 
        o.order_id,
        o.customer_id,
        o.order_date,
        CASE 
            WHEN o.order_date = cfo.first_order_date THEN 'New'
            ELSE 'Returning'
        END AS customer_type
    FROM orders o
    JOIN customer_first_order cfo ON o.customer_id = cfo.customer_id
),

-- Step 3: Count orders by month and customer type
monthly_summary AS (
    SELECT 
        DATE_FORMAT(order_date, '%Y-%m') AS order_month,
        customer_type,
        COUNT(*) AS order_count
    FROM orders_with_type
    GROUP BY order_month, customer_type
)

-- Final output
SELECT 
    order_month,
    customer_type,
    order_count
FROM 
    monthly_summary
ORDER BY 
    order_month, customer_type;

