-- kich ban rui ro: so tien nhap bi am, so tien gdich am hoac = 0, tao gdich cho vi kh ton tai
CREATE TABLE customers (
    customer_id INT PRIMARY KEY
);

CREATE TABLE wallets (
    wallet_id INT PRIMARY KEY,
    customer_id INT NOT NULL UNIQUE,
    balance DECIMAL(12,2) NOT NULL DEFAULT 0 CHECK (balance >= 0),
    FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id)
);

CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    wallet_id INT NOT NULL,
    transaction_type VARCHAR(20) NOT NULL,
    amount DECIMAL(12,2) NOT NULL CHECK (amount > 0),
    transaction_date DATETIME DEFAULT (CURRENT_TIMESTAMP),
    status VARCHAR(20) NOT NULL DEFAULT 'pending',
    FOREIGN KEY (wallet_id)
    REFERENCES wallets(wallet_id)
);
