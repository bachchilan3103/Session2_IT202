CREATE DATABASE dtb_ss02
USE dtb_ss02;

CREATE TABLE books(
   book_id CHAR(5) PRIMARY KEY,
   title VARCHAR(200) NOT NULL,
   quantity INT CHECK (quantity >= 0),
   rental_price DECIMAL(10,2) DEFAULT 5000
); 

ALTER TABLE books
ADD COLUMN date_input DATE;

CREATE TABLE borrow_books(
    borrow_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id CHAR(5),
    borrow_date DATE DEFAULT (CURRENT_DATE),
    CONSTRAINT FOREIGN KEY (book_id) REFERENCES books(book_id)
);

ALTER TABLE books
DROP COLUMN date_input;

ALTER TABLE borrow_books
DROP COLUMN borrow_date;
 
ALTER TABLE borrow_books
MODIFY borrow_date DATETIME DEFAULT CURRENT_TIMESTAMP;