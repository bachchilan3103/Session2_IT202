CREATE TABLE book (
    book_id CHAR(5) PRIMARY KEY,
    book_title VARCHAR(200) NOT NULL,
    quantity INT NOT NULL CHECK (quantity >= 0),
    rent_price DECIMAL(10,2) DEFAULT 5000
);

ALTER TABLE book
ADD import_date DATE;

CREATE TABLE borrow_books (
    borrow_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id CHAR(5) NOT NULL,
    borrow_date DATE DEFAULT (CURRENT_DATE),

    FOREIGN KEY (book_id)
    REFERENCES book(book_id)
);