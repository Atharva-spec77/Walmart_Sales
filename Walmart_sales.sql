create database walmart_db;
use walmart_db;
-- drop table walmart;
select * from walmart;
select count(*) from walmart;
select 
		payment_method,
        count(*)
from walmart
Group by payment_method;

select count(distinct branch)
from walmart;

-- Bussiness problem 
-- Q1. Find diffrent  payment method and number of transaction, no of qty sold 
SELECT 
	payment_method,
    COUNT(*) as no_payment,
    SUM(quantity) as no_qty_sold
from walmart
GROUP BY payment_method;


-- Q2 . Identify the highest-rated category in each branch. display the branch category 
-- AVG rating 
SELECT *  
FROM
(
    SELECT  
        branch,
        category,
        AVG(rating) AS avg_rating,
        RANK() OVER (PARTITION BY branch ORDER BY AVG(rating) DESC) AS `rank`
    FROM walmart
    GROUP BY branch, category
) AS ranked_data
WHERE `rank` = 1;


-- Q3. identify the busiest day for each branch based on the number of transaction
SELECT * 
FROM (
    SELECT  
        branch,
        DAYNAME(STR_TO_DATE(date, '%d/%m/%y')) AS day_name,
        COUNT(*) AS no_transactions,
        RANK() OVER (PARTITION BY branch ORDER BY COUNT(*) DESC) AS `rank`
    FROM walmart
    GROUP BY branch, day_name
) AS ranked_data
WHERE `rank` = 1;

-- Q4. determine the average,minimum, and maximum rating of category for each city .
-- 	List the city , average_rating,min_rating, and max_rating.

SELECT
     city,
     category,
	 MIN(rating) as min_rating,
     MAX(rating) as max_rating,
     AVG(rating) as avg_rating
FROM walmart
GROUP BY 1,;

-- Q5. Calculate the total profit for each category by considering total_profit as
-- (unit price * quantity * profft_margin) -
-- List category and total_profit, ordered from highest to lowest profit.

SELECT
		category,
		SUM(total)as total_revenue,
        SUM(total * profit_margin) as profit
FROM walmart
GROUP BY 1




