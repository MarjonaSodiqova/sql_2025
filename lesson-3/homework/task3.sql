WITH MostExpensiveProducts AS (
    SELECT *
    FROM (
        SELECT *,
               RANK() OVER (PARTITION BY Category ORDER BY Price DESC) AS rnk
        FROM Products
    ) AS ranked
    WHERE rnk = 1
)
SELECT
    Category,
    ProductName,
    Price,
    IIF(Stock = 0, 'Out of Stock',
        IIF(Stock BETWEEN 1 AND 10, 'Low Stock', 'In Stock')) AS InventoryStatus
FROM MostExpensiveProducts
ORDER BY Price DESC
OFFSET 5 ROWS;
