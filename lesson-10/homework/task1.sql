WITH AllShipments AS (
    
    SELECT Num FROM Shipments
    UNION ALL
    SELECT 0 FROM (SELECT TOP 8 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS r FROM sys.all_objects) AS zeros
),
Ranked AS (
    SELECT 
        Num,
        ROW_NUMBER() OVER (ORDER BY Num) AS rn
    FROM AllShipments
),
Median AS (
    SELECT 
        CAST(AVG(Num * 1.0) AS DECIMAL(10,2)) AS MedianValue
    FROM Ranked
    WHERE rn IN (20, 21)
)
SELECT MedianValue
FROM Median;
