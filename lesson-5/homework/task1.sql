Employees:
    - EmployeeID    INT
    - Name          VARCHAR(50)
    - Department    VARCHAR(50)
    - Salary        DECIMAL(10,2)
    - HireDate      DATE
--1
SELECT *, RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
FROM Employees;

--2
SELECT Salary, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY Salary
HAVING COUNT(*) > 1;

--3
SELECT *
FROM (
    SELECT *, DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS DeptSalaryRank
    FROM Employees
) AS Ranked
WHERE DeptSalaryRank <= 2;

--4
SELECT *
FROM (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY Department ORDER BY Salary ASC) AS rn
    FROM Employees
) AS Ranked
WHERE rn = 1;

--5
SELECT *, 
       SUM(Salary) OVER (PARTITION BY Department ORDER BY HireDate) AS RunningTotal
FROM Employees;

--6
SELECT *, 
       SUM(Salary) OVER (PARTITION BY Department) AS DeptTotalSalary
FROM Employees;

--7
SELECT *, 
       AVG(Salary) OVER (PARTITION BY Department) AS DeptAvgSalary
FROM Employees;

--8
SELECT *, 
       Salary - AVG(Salary) OVER (PARTITION BY Department) AS SalaryDifference
FROM Employees;

--9
SELECT *, 
       AVG(Salary) OVER (
           ORDER BY HireDate 
           ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
       ) AS MovingAvg3
FROM Employees;

--10
SELECT SUM(Salary) AS TotalOfLast3
FROM (
    SELECT TOP 3 Salary
    FROM Employees
    ORDER BY HireDate DESC
) AS Last3;

--11
SELECT *, 
       AVG(Salary) OVER (
           ORDER BY HireDate 
           ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ) AS RunningAvg
FROM Employees;

--12
SELECT *, 
       MAX(Salary) OVER (
           ORDER BY HireDate 
           ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING
       ) AS MaxSlidingWindow
FROM Employees;

--13
SELECT *, 
       MAX(Salary) OVER (
           ORDER BY HireDate 
           ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING
       ) AS MaxSlidingWindow
FROM Employees;
