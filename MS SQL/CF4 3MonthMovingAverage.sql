With MonthlySales as (select 
DATEFROMPARTS(Year(Order_Date),Month(Order_Date),1) as SalesMonth,
Round(SUM(Sales),2) as TotalSales
from superstore
group by DATEFROMPARTS(Year(Order_Date),Month(Order_Date),1))

select *,
Round(AVG(TotalSales) over(order by SalesMonth rows between 2 preceding and current row),2) as MovingAverage

from MonthlySales
Order by SalesMonth