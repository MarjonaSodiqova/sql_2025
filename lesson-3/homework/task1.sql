WITH TopEarners AS (
    SELECT TOP 10 PERCENT *
    FROM Employees
    ORDER BY Salary DESC
),
SalaryGrouped AS (
    SELECT
        Department,
        AVG(Salary) AS AverageSalary,
        CASE
            WHEN Salary > 80000 THEN 'High'
            WHEN Salary BETWEEN 50000 AND 80000 THEN 'Medium'
            ELSE 'Low'
        END AS SalaryCategory
    FROM TopEarners
    GROUP BY Department, Salary
)
SELECT *
FROM SalaryGrouped
ORDER BY AverageSalary DESC
OFFSET 2 ROWS FETCH NEXT 5 ROWS ONLY;
