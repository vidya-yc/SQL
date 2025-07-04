select * from sales;

-- -------------------------------------------------------------------------------------------------------------
-- --------------------Feature Engineering----------------------------------------------------------------------
-- ---1.Add new column named time_of_day to give insights of sales in the morning,afternoon,evening-------------
select 
time,
(case 
when `time` between "00:00:00" and "12:00:00" then "Morning"
when `time` between "12:01:00" and "16:00:00" then "Afternoon"
else "Evening"
end) as time_of_date
from sales;

alter table sales add column time_of_day varchar(20);

update sales
set time_of_day = (
case 
when `time` between "00:00:00" and "12:00:00" then "Morning"
when `time` between "12:01:00" and "16:00:00" then "Afternoon"
else "Evening"
end);


-- ----------2.add a new column named day_name that conatins exracted days of week---------------------------------

select date,
dayname(date)
from sales;

alter table sales add column day_name varchar(10);

update sales
set day_name = dayname(date);


-- ------------------3.add a new column named month_name that contains exracted months of the year----------------

select date,
monthname(date)
from sales;

alter table sales add column month_name varchar(10);

update sales
set month_name = monthname(date);

-- -----------------------------------------------------------------------------------


-- ------------------------------------EDA---------------------------------------------
-- ---------------------ANSWERS FOR QUESTIONS------------------------------------------

-- ------GENERIC QUESTIONS
-- --1. How many unique cities does the data have?

select 
distinct city 
from sales;


-- --2.In which city is each branch?

select 
distinct city,branch 
from sales;

-- ------------------------------------------------------------------------------------------------------

-- ----PRODUCT BASED QUESTIONS
-- ---1.How many unquie product lines does the data have?

select 
distinct product_line 
from sales;

select 
count(distinct product_line) 
from sales;

-- ---2.what is the most common payment method?

select
payment_method, 
count(payment_method)
from sales
group by payment_method
order by count(payment_method) desc;


-- ---3.What is the most selling product line?

select 
product_line,
count(product_line)
from sales
group by product_line
order by count(product_line) desc;

-- ---4.What is the total revenue by month?

select
month_name,
sum(total) as total_revenue
from sales
group by month_name
order by total_revenue desc;

-- ---5.Which month had a largest COGS?

select 
month_name,sum(COGS) as COGS
from sales
group by month_name
order by COGS Desc;

-- ---6.What product line had the largest revenue?

select
product_line,
sum(total) as total_revenue
from sales
group by product_line
order by total_revenue desc;

-- ---7.Which is the city with largest revenue?

select
city,branch,
sum(total) as total_revenue
from sales
group by city,branch
order by total_revenue desc;

-- ---8.What product line had the largest VAT?

select
product_line,
avg(VAT) as total_VAT
from sales
group by product_line
order by total_VAT desc;

-- ---9.Which branch sold more products than average product sold?

select
branch,
sum(quantity) as total_quantity
from sales
group by branch
having sum(quantity) > (select avg(quantity) from sales);

-- ---10.What is the most common product line by gender? 

select
gender,
product_line,
count(gender) as total_count
from sales
group by gender,product_line
order by total_count desc;

-- ----11.What is the average rating of each product line?

select 
product_line,
round(avg(rating),2) as Avg_rating
from sales
group by product_line
order by Avg_rating desc; 

-- -----------------------------------------------------------------------------------------------

-- ----SALES BASED QUESTIONS
-- ---1.Number of sales made in each time of the day per weekday?

select
time_of_day,
count(*) as total_sales
from sales
where day_name = "Monday"
group by time_of_day
order by total_sales desc;

-- ---2.Which of the customer types brings most revenue?

select
customer_type,
sum(total) as total_revenue
from sales
group by customer_type
order by total_revenue desc;

-- ---3.Which city as the largest tax percent/VAT?

select
city,branch,
avg(VAT) as total_VAT
from sales
group by city,branch
order by total_VAT desc;

-- ---4.Which customer type pays the most in VAT?

select
customer_type,
round(avg(VAT),2) as total_VAT
from sales
group by customer_type
order by total_VAT desc;


-- ---------------------------------------------------------------------------------------------
-- -------CUSTOMER BASED QUESTIONS
-- ---1.How many unique customer types does the data have?

select
distinct customer_type
from sales;

-- ---2.How many unique payment methods does the data have?

select
distinct payment_method
from sales;

-- ---3.What is the most common customer type?

select
customer_type,
count(customer_type)
from sales
group by customer_type
order by count(customer_type) desc;


-- ---4.Which customer type buys the most?

select
customer_type,
count(*) as customer_count
from sales
group by customer_type
order by customer_count desc;

-- ---5.What is the gender of most of the customers?

select
gender,
count(*) as gender_count
from sales
group by gender
order by gender_count desc;

-- ---6.What is the gender distribution per branch?

select
gender,
count(*) as gender_count
from sales
where branch = "C"
group by gender
order by gender_count desc;

-- ---7.Which time of the day do customers give most ratings?

select
time_of_day,
round(avg(rating),2) as total_rating
from sales
group by time_of_day
order by total_rating desc;

-- ---8.Which time of the do customers give most rating per branch?

select
time_of_day,
round(avg(rating),2) as total_rating
from sales
where branch = "A"
group by time_of_day
order by total_rating desc;

-- ---9.Which day of the week has the best avg ratings?

select
day_name,
round(avg(rating),2) as total_rating
from sales
group by day_name
order by total_rating desc; 

-- ---10.Which day of the week has the best avg rating per branch?

select
day_name,
round(avg(rating),2) as total_rating
from sales
where branch="A"
group by day_name
order by total_rating desc; 

-- -----------------------------------------------------------------------------------------------











