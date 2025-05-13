WITH Hierarchy AS (
    SELECT 
        EmployeeID,
        ManagerID,
        JobTitle,
        0 AS Depth
    FROM Employees
    WHERE ManagerID IS NULL

    UNION ALL

    SELECT 
        e.EmployeeID,
        e.ManagerID,
        e.JobTitle,
        h.Depth + 1
    FROM Employees e
    INNER JOIN Hierarchy h ON e.ManagerID = h.EmployeeID
)
SELECT *
FROM Hierarchy
ORDER BY Depth, EmployeeID;
