Employees

EmployeeID	Name	DepartmentID	Salary
1	Alice	101	60000
2	Bob	102	70000
3	Charlie	101	65000
4	David	103	72000
5	Eva	NULL	68000
Departments

DepartmentID	DepartmentName
101	IT
102	HR
103	Finance
104	Marketing
Projects

ProjectID	ProjectName	EmployeeID
1	Alpha	1
2	Beta	2
3	Gamma	1
4	Delta	4
5	Omega	NULL

--INNER JOIN
SELECT e.EmployeeID, e.Name, d.DepartmentName
FROM Employees e
INNER JOIN Departments d
    ON e.DepartmentID = d.DepartmentID;

--LEFT JOIN
SELECT e.EmployeeID, e.Name, d.DepartmentName
FROM Employees e
LEFT JOIN Departments d
    ON e.DepartmentID = d.DepartmentID;

-- RIGHT JOIN
SELECT e.EmployeeID, e.Name, d.DepartmentName
FROM Employees e
RIGHT JOIN Departments d
    ON e.DepartmentID = d.DepartmentID;

--FULL OUTER JOIN
SELECT e.EmployeeID, e.Name, d.DepartmentName
FROM Employees e
FULL OUTER JOIN Departments d
    ON e.DepartmentID = d.DepartmentID;

--JOIN with Aggregation 
SELECT d.DepartmentName, 
       SUM(e.Salary) AS TotalSalary
FROM Departments d
LEFT JOIN Employees e
    ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName;

--CROSS JOIN
SELECT d.DepartmentName, p.ProjectName
FROM Departments d
CROSS JOIN Projects p;

--MULTIPLE JOINS
SELECT e.EmployeeID, e.Name, d.DepartmentName, p.ProjectName
FROM Employees e
LEFT JOIN Departments d
    ON e.DepartmentID = d.DepartmentID
LEFT JOIN Projects p
    ON e.EmployeeID = p.EmployeeID;