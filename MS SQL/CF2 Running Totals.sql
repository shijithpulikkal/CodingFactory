--SELECT Order_Date,
--       Customer_Name,
--       Sales,
--       SUM(Sales) OVER (ORDER BY Order_Date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS Running_Sales
--FROM   superstore;

WITH   MonthlySalesData
AS     (SELECT   Year(Order_Date) AS SalesYear,
                 Month(Order_Date) AS SalesMonth,
                 SUM(Sales) AS MonthlySales
        FROM     superstore
        GROUP BY Year(Order_Date), Month(Order_Date))
SELECT *,
       SUM(MonthlySales) OVER (ORDER BY SalesYear, SalesMonth ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningTotal
FROM   MonthlySalesData;