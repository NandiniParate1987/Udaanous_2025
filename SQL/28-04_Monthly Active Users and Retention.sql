use database_7;
select * from logins; -- login_id, user_id login_data

select * from users; -- user_id, name, signup_data, country

-- 28-04-25 SQL Task: Monthly Active Users and Retention
/* 1.	Monthly Active Users (MAU) – Count of distinct users who logged in during each month over the last 12 months.
	2. 1-Month Retention Rate – For each signup month, calculate the percentage of users who signed up in that month and also logged in again in the following month.
	3. Format your results to show:
	month (e.g., "2023-06")
	signup_users (number of new users)
	retained_users (number who logged in next month)
	retention_rate (percentage) */


    -- ------------------------------------
    -- Step 1: Common Table Expressions (CTEs) for clean logic
WITH 

-- Extract signup month for each user
signup_data AS (
    SELECT 
        user_id, 
        DATE_FORMAT(STR_TO_DATE(signup_date, '%Y-%m-%d'), '%Y-%m') AS signup_month
    FROM users
),

-- Extract login month for each login
login_data AS (
    SELECT 
        user_id, 
        DATE_FORMAT(STR_TO_DATE(login_date, '%Y-%m-%d'), '%Y-%m') AS login_month
    FROM logins
),

-- Find the first login month after signup
first_logins_after_signup AS (
    SELECT 
        s.signup_month,
        s.user_id,
        MIN(l.login_month) AS first_login_month
    FROM signup_data s
    LEFT JOIN login_data l 
      ON s.user_id = l.user_id 
     AND l.login_month > s.signup_month
    GROUP BY s.signup_month, s.user_id
),

-- Count signup users and retained users
signup_retention AS (
    SELECT
        signup_month,
        COUNT(user_id) AS signup_users,
        SUM(CASE WHEN first_login_month = DATE_FORMAT(DATE_ADD(STR_TO_DATE(CONCAT(signup_month, '-01'), '%Y-%m-%d'), INTERVAL 1 MONTH), '%Y-%m') THEN 1 ELSE 0 END) AS retained_users
    FROM first_logins_after_signup
    GROUP BY signup_month
),

-- Monthly Active Users (MAU)
monthly_active_users AS (
    SELECT
        DATE_FORMAT(STR_TO_DATE(login_date, '%Y-%m-%d'), '%Y-%m') AS month,
        COUNT(DISTINCT user_id) AS monthly_active_users
    FROM logins
   -- WHERE STR_TO_DATE(login_date, '%Y-%m-%d') >= DATE_SUB(CURDATE(), INTERVAL 12 MONTH)
    WHERE login_date BETWEEN '2023-01-01' AND '2023-12-31'
    GROUP BY month
)

-- Final Select
SELECT
    COALESCE(sa.signup_month, ma.month) AS month,
    sa.signup_users,
    sa.retained_users,
    ROUND((sa.retained_users / sa.signup_users) * 100, 2) AS retention_rate,
    ma.monthly_active_users
FROM signup_retention sa
LEFT JOIN monthly_active_users ma
  ON sa.signup_month = ma.month
ORDER BY month;

-- ----------------------------------------------------------------
