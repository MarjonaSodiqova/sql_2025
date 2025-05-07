WITH GroupedStatus AS (
    SELECT *,
           StepNumber - ROW_NUMBER() OVER (PARTITION BY Status ORDER BY StepNumber) AS grp
    FROM Groupings
)
SELECT 
    MIN(StepNumber) AS [Min Step Number],
    MAX(StepNumber) AS [Max Step Number],
    Status,
    COUNT(*) AS [Consecutive Count]
FROM GroupedStatus
GROUP BY Status, grp
ORDER BY MIN(StepNumber);
