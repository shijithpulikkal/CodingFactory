WITH   CurrentSales
AS     (SELECT   Year(Order_Date) AS Sales_Year,
                 SUM(Sales) AS Total_Sales
        FROM     superstore
        GROUP BY Year(Order_Date)),
       PrevSales
AS     (SELECT *,
               LAG(Total_Sales) OVER (ORDER BY Sales_Year) AS PrevYear_Sales
        FROM   CurrentSales)
SELECT *,
       Round(((Total_Sales - PrevYear_Sales) * 100 / PrevYear_Sales), 2) AS "YOY%"
FROM   PrevSales;