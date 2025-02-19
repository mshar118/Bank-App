-- Drop existing tables if they exist
DROP TABLE IF EXISTS transaction;
DROP TABLE IF EXISTS account;
DROP TABLE IF EXISTS customer_accountxref; -- Add this line
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS bank_info;
DROP TABLE IF EXISTS contact;
DROP TABLE IF EXISTS address;

-- Drop existing sequence if it exists
DROP SEQUENCE IF EXISTS CUSTOMER_SEQ;

-- Create sequence for customer IDs
CREATE SEQUENCE CUSTOMER_SEQ START WITH 1 INCREMENT BY 1;

-- Create Address table
CREATE TABLE IF NOT EXISTS address (
    addr_id UUID DEFAULT RANDOM_UUID() PRIMARY KEY,
    address1 VARCHAR(100),
    address2 VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(2),
    zip VARCHAR(10),
    country VARCHAR(50)
);

-- Create Contact table
CREATE TABLE IF NOT EXISTS contact (
    contact_id UUID DEFAULT RANDOM_UUID() PRIMARY KEY,
    email_id VARCHAR(100),
    home_phone VARCHAR(15),
    work_phone VARCHAR(15)
);

-- Create Bank_Info table
CREATE TABLE IF NOT EXISTS bank_info (
    bank_id UUID DEFAULT RANDOM_UUID() PRIMARY KEY,
    branch_name VARCHAR(100),
    branch_code INTEGER,
    routing_number INTEGER,
    branch_address_addr_id UUID,
    FOREIGN KEY (branch_address_addr_id) REFERENCES address(addr_id)
);

-- Create Customer table
CREATE TABLE IF NOT EXISTS customer (
    cust_id BIGINT DEFAULT NEXTVAL('CUSTOMER_SEQ') PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    middle_name VARCHAR(50),
    customer_number BIGINT UNIQUE,
    status VARCHAR(20),
    create_date_time TIMESTAMP,
    update_date_time TIMESTAMP,
    customer_address_addr_id UUID,
    contact_details_contact_id UUID,
    FOREIGN KEY (customer_address_addr_id) REFERENCES address(addr_id),
    FOREIGN KEY (contact_details_contact_id) REFERENCES contact(contact_id)
);

-- Create Account table
CREATE TABLE IF NOT EXISTS account (
    acct_id UUID DEFAULT RANDOM_UUID() PRIMARY KEY,
    account_number BIGINT UNIQUE,
    account_status VARCHAR(20),
    account_type VARCHAR(20),
    account_balance DECIMAL(10,2),
    create_date_time TIMESTAMP,
    update_date_time TIMESTAMP,
    bank_information_bank_id UUID,
    customer_id BIGINT,
    FOREIGN KEY (bank_information_bank_id) REFERENCES bank_info(bank_id),
    FOREIGN KEY (customer_id) REFERENCES customer(cust_id)
);

-- Create Customer_AccountXref table
CREATE TABLE IF NOT EXISTS customer_accountxref (
    cust_acc_xref_id UUID DEFAULT RANDOM_UUID() PRIMARY KEY,
    account_number BIGINT NOT NULL,
    customer_number BIGINT NOT NULL,
    FOREIGN KEY (account_number) REFERENCES account(account_number),
    FOREIGN KEY (customer_number) REFERENCES customer(customer_number)
);

-- Create Transaction table
CREATE TABLE IF NOT EXISTS transaction (
    tx_id UUID DEFAULT RANDOM_UUID() PRIMARY KEY,
    account_number BIGINT,
    tx_date_time TIMESTAMP,
    tx_type VARCHAR(20),
    tx_amount DECIMAL(10,2),
    FOREIGN KEY (account_number) REFERENCES account(account_number)
);

-- Insert sample data
-- 1. Insert bank branch address
INSERT INTO address (address1, address2, city, state, zip, country)
VALUES ('789 Bank St', 'Floor 1', 'Nashville', 'TN', '37201', 'USA');

-- 2. Insert bank information
INSERT INTO bank_info (branch_name, branch_code, routing_number, branch_address_addr_id)
SELECT 
    'Downtown Branch',
    1001,
    084000026,
    addr_id
FROM address 
WHERE address1 = '789 Bank St';

-- 3. Insert customer address
INSERT INTO address (address1, address2, city, state, zip, country)
VALUES ('123 Main St', 'Suite 100', 'Nashville', 'TN', '37203', 'USA');

-- 4. Insert customer contact
INSERT INTO contact (email_id, home_phone, work_phone)
VALUES ('john.doe@email.com', '6151234567', '6159876543');

-- 5. Insert customer
INSERT INTO customer (
    first_name,
    last_name,
    middle_name,
    customer_number,
    status,
    create_date_time,
    update_date_time,
    customer_address_addr_id,
    contact_details_contact_id
)
SELECT 
    'John',
    'Doe',
    'M',
    1002,
    'ACTIVE',
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    a.addr_id,
    c.contact_id
FROM 
    address a,
    contact c
WHERE 
    a.address1 = '123 Main St'
    AND c.email_id = 'john.doe@email.com';

-- 6. Insert account
INSERT INTO account (
    account_number,
    account_status,
    account_type,
    account_balance,
    create_date_time,
    update_date_time,
    bank_information_bank_id,
    customer_id
)
SELECT 
    1001001001001,
    'ACTIVE',
    'SAVINGS',
    1000.00,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    b.bank_id,
    c.cust_id
FROM 
    bank_info b,
    customer c
WHERE 
    b.branch_code = 1001
    AND c.customer_number = 1002;

-- 7. Insert sample transaction
INSERT INTO transaction (
    account_number,
    tx_date_time,
    tx_type,
    tx_amount
)
VALUES (
    1001001001001,
    CURRENT_TIMESTAMP,
    'CREDIT',
    1000.00
);