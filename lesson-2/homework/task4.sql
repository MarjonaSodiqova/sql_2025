CREATE TABLE student (
    student_id INT PRIMARY KEY,
    name VARCHAR(100),
    classes INT,
    tuition_per_class DECIMAL(10,2),
    total_tuition AS (classes * tuition_per_class) PERSISTED
);

INSERT INTO student (student_id, name, classes, tuition_per_class) VALUES
(1, 'Alice Johnson', 5, 500.00),
(2, 'Bob Smith', 3, 600.00),
(3, 'Charlie Brown', 4, 550.00);

SELECT * FROM student;
