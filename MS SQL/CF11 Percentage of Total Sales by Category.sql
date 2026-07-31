
With CategorySales as (
select Category,
	CAST(Sum(Sales) as DECIMAL(8,2)) as TotalSales
	from superstore
	Group by Category)

select 
	Category,
	TotalSales,
	Cast(TotalSales *100 /SUM(TotalSales) over () as Decimal(5,2)) as PctOfTotalSales
	from CategorySales 
	Order by PctOfTotalSales DESC