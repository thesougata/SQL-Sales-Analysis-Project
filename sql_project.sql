-- -----------------------------------------------------
-- Project: SQL Sales Analysis Project
-- Author: Saugata Das
-- Description: A beginner-friendly SQL project that analyzes
--              sample sales data by creating three tables
--              and answering 8 real-world business questions.
-- 
-- Tables Used:
--   - orders
--   - products
--   - order_details
--
-- Steps Included:
--   1. Database and table creation
--   2. Data insertion using INSERT INTO queries
--   3. Business query writing to analyze sales, profits, regions, and more
--
-- Tools Used:
--   - MySQL Workbench
--   - GitHub (for hosting and documentation)
-- -----------------------------------------------------

create database project1;
use project1;
create table orders (
    order_id VARCHAR(20) PRIMARY KEY,
    order_date DATE,
    ship_date DATE,
    customer_name VARCHAR(100),
    region VARCHAR(50),
    city VARCHAR(50)
);
create table products (
    product_id VARCHAR(20) PRIMARY KEY,
    category VARCHAR(50)
);
create table order_details (
    order_id VARCHAR(20),
    product_id VARCHAR(20),
    sales DECIMAL(10,2),
    quantity INT,
    profit DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
-- ---------------------------------------------
-- STEP: Insert Data into Tables from Text File
-- ---------------------------------------------
-- Data was extracted from a CSV file and converted into SQL queries
-- using ChatGPT.
-- Then, all INSERT INTO statements were pasted directly into this script.

-- INSERT statements were used to populate the following tables:
-- orders
-- products
-- order_details

-- This allowed the database to be fully functional without CSV import.

SELECT COUNT(*) FROM orders;
SELECT COUNT(*) FROM products;
SELECT COUNT(*) FROM order_details;
SELECT * FROM orders LIMIT 10;
SELECT * FROM products LIMIT 10;
SELECT * FROM order_details LIMIT 10;
SELECT DISTINCT region FROM orders;
SELECT DISTINCT category FROM products;

-- What is the total sales and profit made in each region?
select o.region,sum(od.sales) as total_sales,sum(od.profit) as total_profit
from orders o 
join order_details od on o.order_id=od.order_id
group by o.region;

-- What is the total sales by product category?
select p.category,sum(od.sales) as total_sales
from order_details od 
join products p on od.product_id=p.product_id
group by p.category;

-- Who are the Top 5 Customers by Total Sales?
select o.customer_name,sum(od.sales) as total_sales from orders o
join order_details od on o.order_id=od.order_id
group by o.customer_name
order by total_sales desc limit 5;

-- What is the monthly sales trend?
select  date_format(o.order_date, '%Y-%m') as month,sum(od.sales) as total_sales                 
from orders o
join order_details od on o.order_id = od.order_id
group by month                                        
order by month;  

-- Which Cities Have the Highest Total Sales?
select o.city,sum(od.sales) as total_sales from orders o
join order_details od 
on o.order_id=od.order_id
group by o.city 
order by total_sales desc;      

-- What is the total sales for each product category in each region?
select p.category ,o.region,sum(od.sales) as total_sales from products p
join order_details od on p.product_id=od.product_id
join orders o on  o.order_id = od.order_id
group by p.category,o.region
order by total_sales desc;    

-- Which Product Categories Are Most Profitable? 
select p.category, sum(od.profit) as total_profit from products p
join order_details od on p.product_id=od.product_id
group by p.category
order by total_profit desc;      

-- What is the total quantity sold for each product?
select p.product_id,p.category, sum(od.quantity) as total_qty from products p
join order_details od on p.product_id=od.product_id
group by p.product_id,p.category
order by total_qty desc;     

-- End of Project: SQL Sales Analysis Project
-- Project Completed by Sougata Das
-- Data Source: sample_orders_dataset.csv (structured & inserted via text conversion)
