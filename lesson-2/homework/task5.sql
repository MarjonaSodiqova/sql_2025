CREATE TABLE worker (
    id INT PRIMARY KEY,
    name VARCHAR(100)
);

BULK INSERT worker
FROM 'D:\sql_2025\sql_2025\lesson-2\homework\workers.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);

SELECT * FROM worker;