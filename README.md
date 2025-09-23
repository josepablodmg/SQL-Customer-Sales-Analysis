# Customer Sales Analysis with SQL

This project demonstrates the use of **SQL views and window functions** to analyze customer sales, calculate their share of total sales, and rank them by performance. The dataset is based on a typical **customer-orders-orderdetails schema**, similar to classic business datasets.  

## 🔹 Project Highlights
- Created **SQL views** to simplify complex queries and ensure reusability:
  - `sales_by_customers` – total sales per customer.
  - `share_by_customers` – customer sales as a percentage of total sales.
  - `cumulative_view` – cumulative sales and cumulative share calculations.
- Applied **window functions** to:
  - Calculate running totals and cumulative sales.
  - Rank customers by sales and cumulative contribution.
- Practiced **data aggregation, grouping, and ordering** to extract business insights.
- Generated actionable metrics such as **sales share, total sales, and rankings**.  

## 🛠️ Technologies
- **SQL** (MySQL / PostgreSQL / other relational database)  
- Concepts used:
  - **JOINs** (INNER JOIN between customers, orders, and orderdetails)
  - **GROUP BY** and **SUM()**
  - **Window functions** (`SUM() OVER`, `RANK() OVER`)
  - **Views** for modular query design  
