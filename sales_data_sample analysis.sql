create database sales_data;
use sales_data;
select *from sales_data_sample;
alter table sales_data_sample
rename sales_data;
select * from sales_data;


describe sales_data;

--- convert string to date 

ALTER table sales_data 
add column orderdate_datetime datetime;

update sales_data
set orderdate_datetime = str_to_date(orderdate, '%c/%e/%Y %H:%i');
CREATE VIEW month AS
SELECt*,MONTH(orderdate) AS month
FROM 
    sales_data;
    SELECT * FROM month;
    
ALTER TABLE sales_data
ADD COLUMN year INT;
 
 update sales_data
 set year = year(orderdate);


alter table sales_data 
drop column orderdate;

alter table sales_data
rename column orderdate_datetime to orderdate;
 
 -- Q1total sales 
 create view total_sales as
 select sum(sales) total_sale
 from sales_data;
  
  -- Q2 total order
  create view total_order as
  select count(orderlinenumber) as total_order
  from sales_data;
   
   -- Q3 average order value, average value of each  order,
   
   create view `average order value` as
   select avg(sales) as  `average order value`
   from sales_data;
   select * from sales_data;
   -- Q4 total customer
   create view `total customer` as
   select count(distinct ordernumber) as `total customer`
   from sales_data;
   
   -- Q5sales by quater
   create view `quaterly sale` as
   select QTR_ID, sum(sales) as  quaterly_sale 
   from sales_data
   group by QTR_id
   order by qtr_id;
   
---- Q6 monthly sales
create view `monthly_sales` as
select date_format(orderdate, '%Y-%m'), sum(sales) as monthly_sales
from sales_data
group by date_format(orderdate, '%Y-%m')
order by date_format(orderdate, '%Y-%m');
    
--- Q7 top selling product
create view `top selling product` as
select productline, sum(sales) as `monthly sales`
from sales_data
group by productline
order by `monthly sales`desc;

-- Q8 monthly sales growth
   
--- Q9 repeat customer rate the percentage of customer who made more than one purchase
select * from sales_data;

select count(distinct(customername)) from  sales_data
;

create view  `percentage of cust with one purchase` as

with ola as (select count(distinct(customername)) `total customer`, count(customername)  `total count of purchase` from  sales_data)
select *, (`total customer`/`total count of purchase`) * 100 `cent` from ola;


select count(customername) from  sales_data
union
select count(distinct(customername)) from  sales_data
;
-- territory by region (territory)
create view territory as
select territory, sum(sales) as `total sales`
from sales_data 
group by territory 
order by `total sales`desc;

--- Q11 deal size analysis
create view dealsize as
select dealsize, sum(sales) as `total sales`
from sales_data
group by dealsize
order by `total sales`desc;
