
use pizza_sales;
select * from pizza_sales;
-- Q1
select sum(total_price) from pizza_sales;

-- Q2
select sum(total_price)/ count(distinct(order_id)) AVG_ord_Value from pizza_sales;

-- Q3
select sum(quantity) total_pizza_sold from pizza_sales;

-- Q4
select count(distinct(order_id)) from pizza_sales;

-- Q5
select sum(quantity)/count(distinct(order_id)) Avg_Pizzas_per_order from pizza_sales;

-- Q6
SELECT 
    DAYNAME(order_date) Order_day,
    COUNT(DISTINCT (order_id)) Total_orders
FROM
    pizza_sales
GROUP BY DAYNAME(order_date)
ORDER BY 2;

-- Q7
SELECT 
    MONTHNAME(order_date) AS month_name,
    COUNT(DISTINCT order_id) AS Total_orders
FROM
    pizza_sales
GROUP BY 
    MONTH(order_date), MONTHNAME(order_date)
ORDER BY 
    MONTH(order_date);

-- Q8
select * from pizza_sales;

SELECT 
    pizza_category, 
    SUM(total_price) AS total_revenue,
    SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales)  AS PCT
FROM 
    pizza_sales
GROUP BY 
    pizza_category;
    
-- Q9
select pizza_category, sum(quantity) Total_Quantity_Sold from pizza_sales group by pizza_category;

-- Q10
SELECT 
    pizza_name, SUM(total_price) Tot_rev
FROM
    pizza_sales
GROUP BY pizza_name
ORDER BY 2 DESC
LIMIT 5;

-- Q11
SELECT 
    pizza_name, SUM(total_price) Tot_rev
FROM
    pizza_sales
GROUP BY pizza_name
ORDER BY 2 
LIMIT 5;

-- Q12 
SELECT 
    pizza_name, COUNT(DISTINCT order_id) Tot_qut
FROM
    pizza_sales
GROUP BY pizza_name
ORDER BY 2 desc
LIMIT 5;

-- Q13
SELECT 
    pizza_name, COUNT(DISTINCT order_id) Tot_qut
FROM
    pizza_sales
GROUP BY pizza_name
ORDER BY 2 
LIMIT 5;

