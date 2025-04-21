
CREATE TABLE product (
    product_id INT UNIQUE,
    product_name VARCHAR(100),
    price DECIMAL(10, 2)
);

ALTER TABLE product
DROP CONSTRAINT UQ__product__product_id; 

ALTER TABLE product
ADD CONSTRAINT uq_product_id UNIQUE (product_id);

ALTER TABLE product
ADD CONSTRAINT uq_product_id_name UNIQUE (product_id, product_name);
