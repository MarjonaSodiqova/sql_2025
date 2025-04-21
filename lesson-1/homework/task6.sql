CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50) DEFAULT 'Unknown'
);

ALTER TABLE customer DROP CONSTRAINT DF__customer__city;
ALTER TABLE customer ADD CONSTRAINT df_city DEFAULT 'Unknown' FOR city;
