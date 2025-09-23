Drop view if exists sales_by_customers;

CREATE VIEW sales_by_customers AS
    SELECT c.customerNumber,
           c.customerName,
           c.city,
           c.country,
           round(sum(od.priceEach * od.quantityOrdered), 2) AS Sales
      FROM customers c
           JOIN
           orders o ON c.customerNumber = o.customerNumber
           JOIN
           orderdetails od ON o.orderNumber = od.orderNumber
     GROUP BY c.customerNumber
     order by Sales desc;
     
drop view if exists share_by_customers;

CREATE VIEW share_by_customers AS     
SELECT *,
       (Sales / (sum(Sales) OVER sales_window))*100 AS Share
  FROM sales_by_customers
WINDOW sales_window AS ();

SELECT *,
       sum(Share) OVER share_window,
       rank() OVER share_window AS Ranking
  FROM share_by_customers
WINDOW share_window AS ();


SELECT *,
       SUM(Share) OVER share_window AS total_share,
       RANK() OVER share_window AS sales_rank
  FROM share_by_customers
WINDOW share_window AS (ORDER BY Sales DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING);



SELECT customerNumber,
       customerName,
       sales,
       round(sum(sales) OVER all_sales, 2) as Total_sales,
       round((sales / sum(sales) OVER all_sales)*100, 2) as Share,
       rank() OVER all_sales as Ranking
  FROM sales_by_customers
WINDOW all_sales AS (ORDER BY sales DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING);

drop view if exists cumulative_sales;
drop view if exists cumulative_view;

create view cumulative_view as
SELECT *,
       SUM(sales) OVER (ORDER BY sales DESC) AS cumulative_sales,
       round(sum(sales) OVER (ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING),2) AS Total_sales
  FROM share_by_customers;

select *,
round(cumulative_sales/total_sales*100,2) as cumulative_share,
rank() over rank_window as Ranking
from cumulative_view
window rank_window as (order by sales desc)