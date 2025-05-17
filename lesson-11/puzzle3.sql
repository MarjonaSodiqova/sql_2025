CREATE TABLE WorkLog (
    EmployeeID INT,
    EmployeeName VARCHAR(50),
    Department VARCHAR(50),
    WorkDate DATE,
    HoursWorked INT
);

INSERT INTO WorkLog VALUES
(1, 'Alice', 'HR', '2024-03-01', 8),
(2, 'Bob', 'IT', '2024-03-01', 9),
(3, 'Charlie', 'Sales', '2024-03-02', 7),
(1, 'Alice', 'HR', '2024-03-03', 6),
(2, 'Bob', 'IT', '2024-03-03', 8),
(3, 'Charlie', 'Sales', '2024-03-04', 9);

CREATE VIEW vw_MonthlyWorkSummary AS
WITH
EmployeeSummary AS (
    SELECT
        EmployeeID,
        EmployeeName,
        Department,
        SUM(HoursWorked) AS TotalHoursWorked
    FROM WorkLog
    GROUP BY EmployeeID, EmployeeName, Department
),
DepartmentSummary AS (
    SELECT
        Department,
        SUM(HoursWorked) AS TotalHoursDepartment,
        AVG(CAST(HoursWorked AS FLOAT)) AS AvgHoursDepartment
    FROM WorkLog
    GROUP BY Department
)
SELECT 
    e.EmployeeID,
    e.EmployeeName,
    e.Department,
    e.TotalHoursWorked,
    d.TotalHoursDepartment,
    d.AvgHoursDepartment
FROM EmployeeSummary e
JOIN DepartmentSummary d ON e.Department = d.Department;

SELECT * FROM vw_MonthlyWorkSummary;
