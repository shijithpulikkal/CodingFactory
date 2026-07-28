
WITH     FirstPurchase  AS (
         SELECT   Customer_id,
                   Min(Order_Date) AS FirstOrderDate
          FROM     superstore
          GROUP BY Customer_ID),

         NewCustomersPerMonth AS (
         SELECT   DATEFROMPARTS(year(FirstOrderDate), Month(FirstOrderDate), 1) AS SalesMonth,
                   Count(*) AS NewCustomers
          FROM     FirstPurchase
          GROUP BY DATEFROMPARTS(year(FirstOrderDate), Month(FirstOrderDate), 1))

SELECT   SalesMonth,
         NewCustomers,
         SUM(NewCustomers) OVER (ORDER BY SalesMonth) AS CumulativeDistinctCustomers
FROM     NewCustomersPerMonth
ORDER BY SalesMonth;