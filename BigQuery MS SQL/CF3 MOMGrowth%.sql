WITH   CurrentSales
AS     (SELECT   DATEFROMPARTS(Year(Order_Date), Month(Order_Date), 1) AS Sales_Month,
                 SUM(Sales) AS Total_Sales
        FROM     superstore
        GROUP BY DATEFROMPARTS(Year(Order_Date), Month(Order_Date), 1)),
       PrevSales
AS     (SELECT Sales_Month,
               Total_Sales,
               LAG(Total_Sales) OVER (ORDER BY Sales_Month) AS PrevMonth_Sales
        FROM   CurrentSales)
SELECT FORMAT(Sales_Month, 'MMM yyyy') AS Sales_Month,
       Total_Sales,
       PrevMonth_Sales,
       Round(((Total_Sales - PrevMonth_Sales) * 100 / PrevMonth_Sales), 2) AS "MOM%"
FROM   PrevSales;