
CREATE TABLE category (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100)
);

CREATE TABLE item (
    item_id INT PRIMARY KEY,
    item_name VARCHAR(100),
    category_id INT,
    CONSTRAINT fk_item_category FOREIGN KEY (category_id) REFERENCES category(category_id)
);

ALTER TABLE item
DROP CONSTRAINT fk_item_category;

ALTER TABLE item
ADD CONSTRAINT fk_item_category FOREIGN KEY (category_id) REFERENCES category(category_id);
