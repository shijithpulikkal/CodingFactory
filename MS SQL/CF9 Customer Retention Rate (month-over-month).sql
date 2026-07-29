
With MonthlyCustomer as (
	select 
	Distinct
	DATEFROMPARTS(year(Order_Date), MOnth(Order_Date), 1) as Sales_Month,
	Customer_ID
	from superstore),

PrevMonthly as(
select 
	Sales_Month,
	Customer_ID,
	Lag(Sales_Month) Over(partition by Customer_ID order by Sales_Month) as PrevPurchaseMonth
	from MonthlyCustomer),

RetensionFlag as(
select
	Sales_Month,
	Customer_ID,
	Case 
	When DateDiff(Month, PrevPurchaseMonth, Sales_Month) = 1
	then 1 else 0
	end as IsRetained
	from PrevMonthly),

MonthlyTotals as(
Select 
	Sales_Month,
	Count(*) as TotalCustomers,
	SUM(IsRetained) as RetainedCustomers

	from RetensionFlag
	group by Sales_Month)


Select Format(Sales_Month,'MMM yyyy') as Sales_Month_Display,
	TotalCustomers,
	Lag(TotalCustomers) over(order by Sales_Month) AS LastMonthCustomers,
	RetainedCustomers,
	CAST(
		RetainedCustomers * 100.0 / (Lag(TotalCustomers) over(order by Sales_Month))
		AS DECIMAL(5,2)) 
		as RetentionRatePct

	from MonthlyTotals



	