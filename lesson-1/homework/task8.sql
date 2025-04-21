CREATE TABLE books (
    book_id INT IDENTITY(1,1) PRIMARY KEY,
    title VARCHAR(200) NOT NULL CHECK (LEN(title) > 0),
    price DECIMAL(10, 2) CHECK (price > 0),
    genre VARCHAR(100) DEFAULT 'Unknown'
);

INSERT INTO books (title, price) VALUES ('Harry Potter', 29.99);
