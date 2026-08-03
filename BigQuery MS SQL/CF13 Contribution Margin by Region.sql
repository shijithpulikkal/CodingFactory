
select 
	Region,
	Round(SUM(Sales),2) as TotalSales,
	Round(SUM(Profit),2) as TotalProfit,
	Round((SUM(Profit)*100/Nullif(SUM(Sales),0)),2) as ProfitMarginPct
from superstore
group BY Region
order by ProfitMarginPct DESC