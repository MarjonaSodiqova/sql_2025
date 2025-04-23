CREATE TABLE photos (
    id INT PRIMARY KEY,
    image_data VARBINARY(MAX)
);

INSERT INTO photos (id, image_data)
SELECT 1, BulkColumn 
FROM OPENROWSET(BULK 'C:\path\to\image.jpg', SINGLE_BLOB) AS image;
