
select 
	a.Product_Name as ProductA,
	b.Product_Name as ProductB,
	Count(Distinct a.Order_ID)  as TimeBoughtTogether

from superstore a
join superstore b
	on a.Order_ID = b.Order_ID
	AND a.Product_Name  < b.Product_Name 
Group by a.Product_Name,b.Product_Name

having COUNT(Distinct a.Order_ID) > 1
Order by TimeBoughtTogether DESC

	