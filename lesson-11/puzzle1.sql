
CREATE TABLE Employees (
    EmployeeID INT,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary INT
);

INSERT INTO Employees (EmployeeID, Name, Department, Salary) VALUES
(1, 'Alice', 'HR', 5000),
(2, 'Bob', 'IT', 7000),
(3, 'Charlie', 'Sales', 6000),
(4, 'David', 'HR', 5500),
(5, 'Emma', 'IT', 7200);

CREATE TABLE #EmployeeTransfers (
    EmployeeID INT,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary INT
);


INSERT INTO #EmployeeTransfers (EmployeeID, Name, Department, Salary)
SELECT 
    EmployeeID,
    Name,
    CASE Department
        WHEN 'HR' THEN 'IT'
        WHEN 'IT' THEN 'Sales'
        WHEN 'Sales' THEN 'HR'
    END AS Department,
    Salary
FROM Employees;

SELECT * FROM #EmployeeTransfers;

DROP TABLE #EmployeeTransfers;
