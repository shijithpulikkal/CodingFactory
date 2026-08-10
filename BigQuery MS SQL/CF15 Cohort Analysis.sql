
With FirstPurchase as(
select 
	Customer_ID,
	DATEFROMPARTS(YEAR(MIN(Order_Date)), Month(MIN(Order_Date)), 1) as CohortMonth
from superstore
Group by Customer_ID),

OrderMonths as (
Select s.Customer_ID,
	f.CohortMonth,
	DATEFROMPARTS(YEAR(Order_Date), Month(Order_Date), 1) as OrderMonth,
	s.Sales
From superstore s
JOIN FirstPurchase f ON s.Customer_ID = f.Customer_ID)

Select
	CohortMonth,
	DATEDIFF(Month,CohortMonth,OrderMonth) as MonthsSinceFirstPurchase,
	Round(SUM(Sales),2) as CohortRevenue,
	Count(Distinct Customer_ID) as ActiveCustomers
From OrderMonths
Group by CohortMonth,DATEDIFF(Month,CohortMonth,OrderMonth)
Order by CohortMonth, MonthsSinceFirstPurchase
