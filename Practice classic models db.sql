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

select *,
sum (Share) over share_window
from share_by_customers
window share_window as ();
