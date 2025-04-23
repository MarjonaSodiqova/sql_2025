WITH FilteredOrders AS (
    SELECT
        CustomerName,
        TotalAmount,
        CASE
            WHEN Status IN ('Shipped', 'Delivered') THEN 'Completed'
            WHEN Status = 'Pending' THEN 'Pending'
            WHEN Status = 'Cancelled' THEN 'Cancelled'
        END AS OrderStatus
    FROM Orders
    WHERE OrderDate BETWEEN '2023-01-01' AND '2023-12-31'
)
SELECT
    OrderStatus,
    COUNT(*) AS TotalOrders,
    SUM(TotalAmount) AS TotalRevenue
FROM FilteredOrders
GROUP BY OrderStatus
HAVING SUM(TotalAmount) > 5000
ORDER BY TotalRevenue DESC;
