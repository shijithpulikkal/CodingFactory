
With RefDate as(
select 
	max(Order_Date) as MaxDate
from superstore),

CustomerRFM as(
Select s.Customer_ID,
	DATEDIFF(Day, Max(s.Order_Date), r.MaxDate) AS Recency,
	Count(Distinct s.Order_Date) as Frequency,
	CAST(SUM(Sales) AS DECIMAL(7,2)) as Monetary
from superstore s
Cross Join RefDate r
Group by s.Customer_ID,r.MaxDate),

Scored as (
Select Customer_ID,
	Recency, Frequency, Monetary,
	Ntile(5) Over (Order BY Recency DESC) as R_Score,
	Ntile(5) Over (Order by Frequency ASC) as F_Score,
	Ntile(5) Over (Order by Monetary ASC) as M_Score
from CustomerRFM)

Select 
	Customer_ID,
	Recency, Frequency, Monetary,
	R_Score,F_Score,M_Score,
	Concat(R_Score,F_Score,M_Score) as RFM_Segment
From Scored
Order by RFM_Segment DESC
