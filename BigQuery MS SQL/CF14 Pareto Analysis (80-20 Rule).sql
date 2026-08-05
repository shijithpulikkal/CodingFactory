
With CustomerSales as(
select 
	Customer_ID,
	Customer_Name,
	Round(SUM(Sales),2) as TotalSales

from superstore
group by Customer_ID,Customer_Name),

Ranked as (
Select
	Customer_ID,Customer_Name,TotalSales,
	Round(SUM(TotalSales) over(Order by TotalSales DESC),2) as RunningSales,
	Round(SUM(TotalSales) over(),2) as GrandTotal,
	row_number() over(Order by TotalSales DESC) as CustomerRank,
	Count(*) over() as TotalCustomers
From CustomerSales)

Select 
	Customer_ID,
	Customer_Name,
	TotalSales,
	RunningSales,
	GrandTotal,
	Round(RunningSales * 100.0 / GrandTotal,2) as CumulativePctSales,
	Round(CustomerRank * 100.0 / TotalCustomers,2) as CumulativePctCustomers,
	Case
		when RunningSales * 100.0 / GrandTotal <= 80 THEN 'Top 80%' Else 'Bottom 20%' end as Segment
from Ranked
