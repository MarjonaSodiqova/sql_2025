CREATE TABLE data_types_demo (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    salary DECIMAL(10,2),
    birth_date DATE,
    hire_datetime DATETIME,
    is_active BIT,
    large_text TEXT,
    binary_data VARBINARY(MAX),
    json_data NVARCHAR(MAX)
);

INSERT INTO data_types_demo VALUES
(1, 'John Doe', 75000.50, '1985-06-15', '2020-01-15 09:30:00', 1, 'This is a long text', 
 CAST('Sample binary' AS VARBINARY(MAX)), '{"key": "value"}'),
(2, 'Jane Smith', 82500.75, '1990-03-22', '2019-11-05 08:45:00', 1, 'Another long text', 
 CAST('More binary data' AS VARBINARY(MAX)), '{"name": "Jane", "age": 32}');

SELECT * FROM data_types_demo;