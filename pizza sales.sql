create database pizza;
use pizza;
create table pizza_sales(
pizza_id int,
order_id int,
pizza_name_id varchar(50),	
quantity int,
order_date	datetime,
order_time	time,
unit_price	DECIMAL(4,2),
total_price	DECIMAL(4, 2),
pizza_size	varchar(2),
pizza_category	varchar(20),
pizza_ingredients	varchar(200),
pizza_name varchar(100)
);

-- Total revenue
select sum(total_price) as total_revenue from pizza_sales;

-- Average order value
select sum(total_price)/count(distinct(order_id)) as average_order_value from pizza_sales;

-- Total pizzas sold
select sum(quantity) as pizzas_sold from pizza_sales;

-- Total orders  
select count(distinct(order_id)) as total_orders from pizza_sales;

-- Average pizza per order
select sum(quantity)/count(distinct(order_id)) as average_pizza_per_order  from pizza_sales;

--  Daily trend of total orders over a specific time period
SELECT 
    DATE(order_date) AS order_day,
    COUNT(distinct(order_id)) AS total_orders
FROM pizza_sales
WHERE order_date BETWEEN '2015-01-01' AND '2015-01-08'
GROUP BY order_day;


-- Percentage of sales by pizza category
select pizza_category, sum(total_price)*100 / (select sum(total_price) from pizza_sales) as percentage
from pizza_sales
group by pizza_category;

-- Percentage of sales by pizza size
select pizza_size, sum(total_price)*100 / (select sum(total_price) from pizza_sales) as percentage
from pizza_sales
group by pizza_size;

-- Total pizza sold by pizza category
select pizza_category, sum(quantity) as total_pizza_sold
from pizza_sales
group by pizza_category;

-- Top 5 best selling pizza by total pizza sold
select pizza_name , sum(quantity) as total_pizza_sold
from pizza_sales
group by pizza_name
order by sum(quantity) desc limit 5;

-- Bottom 5 worst selling pizza by total pizza sold
select pizza_name , sum(quantity) as total_pizza_sold
from pizza_sales
group by pizza_name
order by sum(quantity) asc limit 5;
