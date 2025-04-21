CREATE TABLE account (
    account_id INT PRIMARY KEY,
    balance DECIMAL(10, 2) CHECK (balance >= 0),
    account_type VARCHAR(20) CHECK (account_type IN ('Saving', 'Checking'))
);

ALTER TABLE account DROP CONSTRAINT CK__account__balance;
ALTER TABLE account ADD CONSTRAINT ck_balance CHECK (balance >= 0);

ALTER TABLE account DROP CONSTRAINT CK__account__account_type;
ALTER TABLE account ADD CONSTRAINT ck_account_type CHECK (account_type IN ('Saving', 'Checking'));
