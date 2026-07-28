With YearlySales as (
select Customer_ID,
Customer_Name,
YEAR(Order_Date) as OrderYear,
Round(SUM(Sales),2) as TotalSales
from superstore
Group by Customer_ID,Customer_Name, YEAR(Order_Date)),

Ranked as(
select Customer_ID,
Customer_Name,
OrderYear,
TotalSales,
Rank() over (Partition by OrderYear  order by TotalSales DESC) as Ranker
from YearlySales)

select OrderYear,
Customer_ID,
Customer_Name,
TotalSales,
Ranker
From Ranked
where Ranker = 1

