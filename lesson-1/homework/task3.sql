
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    order_date DATE
);

ALTER TABLE orders
DROP CONSTRAINT PK__orders__order_id; 

ALTER TABLE orders
ADD CONSTRAINT pk_orders PRIMARY KEY (order_id);
