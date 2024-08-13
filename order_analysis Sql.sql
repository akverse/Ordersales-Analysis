use company
select * from df_orders

--Find top 10 highest revenue generating products
SELECT  TOP (10) product_id, SUM(sale_price) AS revenue
FROM df_orders
GROUP BY product_id
ORDER BY revenue DESC


--Find top 5 highest selling products in each region
with mycte as 
(SELECT region, product_id, SUM(sale_price) AS revenue,
Rank() over (partition by region order by SUM(sale_price) desc) as r_k
FROM  df_orders
GROUP BY region, product_id)
Select region, product_id, revenue
from mycte where r_k<=5


--Find month over month growth comparison for 2022 & 2023 sales eg. jan 2022 vs jan 2023
with mycet as (
Select year(order_date) as orderyear, MONTH(order_date) as ordermonth, sum(sale_price) as sales
from df_orders
group by year(order_date), MONTH(order_date)
)

select ordermonth,
sum(case when orderyear = 2022 then sales else 0 end)as sales_2022,
sum(case when orderyear = 2023 then sales else 0 end)as sales_2023
from mycet
group by ordermonth
order by ordermonth



-- For each category which month had highest sales
with mycte as 
(Select category, Month(order_date) as month, sum(sale_price) as sales,
RANK() over (partition by category order by  sum(sale_price) desc) as r_k 
from df_orders
group by  category, Month(order_date))
Select category, month, sales from mycte
where r_k=1


-- Which sub category had highest growth by profit  in 2023 compare to 2022
with mycet as (
Select sub_category, year(order_date) as orderyear, sum(profit) as profit
from df_orders
group by year(order_date), sub_category
)
Select top(1)sub_category,(profit_2023-profit_2022)* 100/profit_2022 as growth_byprofit from (
Select sub_category,
sum(case when orderyear  =2022 then profit else 0 end) as profit_2022,
sum(case when orderyear  =2023 then profit else 0 end) as profit_2023
from mycet
group by sub_category
) as temptable
order by growth_byprofit desc