create database coffee_shop;
CREATE TABLE coffee_shop (
    transaction_id INT,
    transaction_date DATE,
    transaction_time TIME,
    transaction_qty INT,
    store_id INT,
    store_location VARCHAR(50),
    product_id INT,
    unit_price DECIMAL(10, 2),
    product_category VARCHAR(50),
    product_type VARCHAR(50),
    product_detail VARCHAR(50),
    total_sale DECIMAL(10, 2)
);









use coffee_shop;

-- TOTAL SALES
SELECT 
    ROUND(SUM(unit_price * transaction_qty)) AS Total_Sales
FROM
    coffee_shop
WHERE
    MONTH(transaction_date) = 5;

-- TOTAL SALES KPI - MOM DIFFERENCE AND MOM GROWTH
SELECT  
    MONTH(transaction_date) AS Month, 
    SUM(unit_price * transaction_qty) AS Total_Sale,
    round((
        SUM(unit_price * transaction_qty) - 
        LAG(SUM(unit_price * transaction_qty), 1) OVER(Order BY MONTH(transaction_date))
    ) / 
    LAG(SUM(unit_price * transaction_qty), 1) OVER(Order BY MONTH(transaction_date)) * 100,2) AS MoM_Increase_Percentage 
FROM 
    coffee_shop
WHERE 
    MONTH(transaction_date) IN (4, 5) 
GROUP BY 
    Month 
ORDER BY 
    Month;


-- TOTAL ORDERS
SELECT 
    COUNT(DISTINCT (transaction_id))
FROM
    coffee_shop;
    
-- TOTAL SALES KPI - MOM DIFFERENCE AND MOM GROWTH
SELECT  
    MONTH(transaction_date) AS Month, 
    COUNT(DISTINCT (transaction_id)) AS Total_order,
   round((
        COUNT(DISTINCT (transaction_id)) - 
        LAG(COUNT(DISTINCT (transaction_id)), 1) OVER(Order BY MONTH(transaction_date))
    ) / 
    LAG(COUNT(DISTINCT (transaction_id)), 1) OVER(Order BY MONTH(transaction_date)) * 100,2) AS MoM_Increase_Percentage 
FROM 
    coffee_shop
WHERE 
    MONTH(transaction_date) IN (4, 5) 
GROUP BY 
    Month 
ORDER BY 
    Month;


-- TOTAL QUANTITY SOLD
SELECT 
    SUM(transaction_qty) total_quantity_sold
FROM
    coffee_shop;



SELECT  
    MONTH(transaction_date) AS Month, 
    sum(transaction_qty) AS Total_quantity,
    round((
        sum(transaction_qty) - 
        LAG(sum(transaction_qty), 1) OVER(Order BY MONTH(transaction_date))
    ) / 
    LAG(sum(transaction_qty), 1) OVER(Order BY MONTH(transaction_date)) * 100,2) AS MoM_Increase_Percentage 
FROM 
    coffee_shop
WHERE 
    MONTH(transaction_date) IN (4, 5) 
GROUP BY 
    Month 
ORDER BY 
    Month;


-- CALENDAR TABLE – DAILY SALES, QUANTITY and TOTAL ORDERS
SELECT
CONCAT(ROUND(SUM(unit_price * transaction_qty) / 1000, 1),"k") total_sales,
CONCAT(ROUND(COUNT(transaction_id) / 1000, 1),"k") total_orders,
CONCAT(ROUND(SUM(transaction_qty) / 1000, 1),"k") total_quantity_sold
FROM
coffee_shop
WHERE
transaction_date =  "2023-03-27";



-- WEEKEND AND WEEK DAY SALES 
SELECT CASE WHEN DAYOFWEEK(transaction_date) IN (1,7) THEN "WEEKEND"
 ELSE "WEEKDAY"
 END AS DAY_TYPE,
  concat(ROUND(SUM(UNIT_PRICE * TRANSACTION_QTY)/1000,1),"K")
 FROM coffee_shop 
 WHERE MONTH (transaction_date) = 2 
 GROUP BY CASE WHEN DAYOFWEEK(transaction_date) IN (1,7) THEN "WEEKEND"
 ELSE "WEEKDAY"
 END ;

-- SALES BY STORE LOCATION
SELECT
store_location,
concat(round(SUM(unit_price * transaction_qty)/1000 ,1),"k")as Total_Sales
FROM coffee_shop
WHERE
MONTH(transaction_date) = 6 
GROUP BY store_location
ORDER BY SUM(unit_price * transaction_qty) DESC;

-- DAILY SALES FOR MONTH SELECTED
SELECT
day_of_month,
CASE
WHEN total_sales>avg_sales then "Above Average"
WHEN total_sales < avg_sales then "Above Average"
ELSE "Average"
END AS sales_status,
total_sales
FROM (
SELECT
DAY(transaction_date) AS day_of_month,

SUM(unit_price * transaction_qty) AS total_sales,
AVG(SUM(unit_price * transaction_qty)) OVER () AS avg_sales
FROM
coffee_shop
WHERE
MONTH(transaction_date) = 5 -- Filter for May
GROUP BY
DAY(transaction_date)
) AS sales_data
ORDER BY day_of_month;
    
-- SALES BY PRODUCT CATEGORY

SELECT 
    product_category,
    ROUND(SUM(unit_price * transaction_qty), 1) AS Total_Sales
FROM
    coffee_shop
WHERE
    MONTH(transaction_date) = 5
GROUP BY product_category
ORDER BY SUM(unit_price * transaction_qty) DESC ;

-- SALES BY PRODUCTS (TOP 10)
SELECT 
    product_type,
    ROUND(SUM(unit_price * transaction_qty), 1) AS Total_Sales
FROM
    coffee_shop
WHERE
    MONTH(transaction_date) = 5 And product_category = "coffee"
GROUP BY product_type
ORDER BY SUM(unit_price * transaction_qty) DESC 
limit 10;

-- SALES BY DAY | HOUR 


SELECT 
    ROUND(SUM(unit_price * transaction_qty), 1) AS Total_Sales,
    count(*)total_orders,
    sum(transaction_qty) total_quantity
FROM
    coffee_shop
WHERE
    MONTH(transaction_date) = 5 And 
    dayofweek(transaction_date) = 3 and
    hour(transaction_time) = 8;



-- TO GET SALES FOR ALL HOURS FOR MONTH OF MAY
SELECT 
    HOUR(transaction_time) AS Hour_of_Day,
    ROUND(SUM(unit_price * transaction_qty)) AS Total_Sales
FROM
    coffee_shop
WHERE
    MONTH(transaction_date) = 5
GROUP BY HOUR(transaction_time)
ORDER BY HOUR(transaction_time);

