
WITH     ProductCategorySales
AS       (SELECT   Category,
                   Product_Name,
                   Round(SUM(Sales), 2) AS TotalSales
          FROM     superstore
          GROUP BY Category, Product_Name),
         Ranker
AS       (SELECT Category,
                 Product_Name,
                 TotalSales,
                 Rank() OVER (PARTITION BY Category ORDER BY TotalSales DESC) AS Ranks
          FROM   ProductCategorySales)
SELECT   Category,
         Product_Name,
         TotalSales,
         Ranks
FROM     Ranker
WHERE    Ranks <= 3
ORDER BY Ranks;