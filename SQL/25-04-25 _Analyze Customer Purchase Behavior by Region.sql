use database6;
select * from customers;
select * from orders;

-- 25-04-25 Task Title: Analyze Customer Purchase Behavior by Region
-- Objective:
-- To analyze customer spending patterns and identify the most valuable customers in each region based on their purchasing activity in the last 12 months.


WITH recent_orders AS (
    SELECT *
    FROM orders
    WHERE order_date >= DATE_SUB(CURDATE(), INTERVAL 12 MONTH)
),
customer_orders AS (
    SELECT 
        c.customer_id,
        c.name,
        c.region,
        COUNT(o.order_id) AS order_count,
        SUM(o.total_amount) AS total_spending
    FROM customers c
    JOIN recent_orders o ON c.customer_id = o.customer_id
    GROUP BY c.customer_id, c.name, c.region
    HAVING COUNT(o.order_id) > 3
),
ranked_customers AS (
    SELECT *,
           RANK() OVER (PARTITION BY region ORDER BY total_spending DESC) AS spending_rank
    FROM customer_orders
)
SELECT 
    name,
    region,
    total_spending,
    order_count
FROM ranked_customers
WHERE spending_rank <= 3;

-- By  analyzing customer spending patterns, I have identify the 5 most valuable customers in each region based
--  on their purchasing activity in the last 12 months.
-- Customer 17 from East region have total_spending is '1361.0700000000002' having highest order_count according to purchasing activity.
