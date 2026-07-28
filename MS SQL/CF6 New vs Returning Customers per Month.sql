WITH   FirstPurchase
AS     (SELECT   Customer_ID,
                 MIN(Order_Date) AS FirstOrderDate
        FROM     superstore
        GROUP BY Customer_ID),
       Classified
AS     (SELECT s.Order_Date,
               s.Customer_ID,
               Round(s.Sales, 2) AS Sales,
               CASE WHEN YEAR(s.Order_Date) = YEAR(f.FirstOrderDate)
                         AND MONTH(s.Order_Date) = MONTH(f.FirstOrderDate) THEN 'new' ELSE 'returning' END AS CustomerType
        FROM   superstore AS s
               INNER JOIN
               FirstPurchase AS f
               ON s.Customer_ID = f.Customer_ID)
SELECT 
Year(Order_Date) as SalesYear,
MOnth(Order_Date) as SalesMonth,
CustomerType,
Count(distinct Customer_ID) as CustomerCount,
SUM(Sales) as TotalSales
FROM   Classified
group by Year(Order_Date), MOnth(Order_Date),CustomerType
order by SalesYear,SalesMonth
