CREATE SCHEMA IF NOT EXISTS source;
CREATE SCHEMA IF NOT EXISTS staging;
CREATE SCHEMA IF NOT EXISTS warehouse;
CREATE SCHEMA IF NOT EXISTS audit;

CREATE TABLE IF NOT EXISTS source.customers (
    customer_id VARCHAR(50),
    customer_name VARCHAR(100),
    email VARCHAR(100),
    country VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS source.products (
    product_id VARCHAR(50),
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE IF NOT EXISTS source.sales (
    transaction_id VARCHAR(50),
    customer_id VARCHAR(50),
    product_id VARCHAR(50),
    quantity INT,
    transaction_date VARCHAR(50)
);

INSERT INTO source.customers (customer_id, customer_name, email, country) VALUES
('C001', 'Nguyen Van A', 'a@gmail.com', 'Vietnam'),
('C002', 'John Doe', 'john@yahoo.com', 'USA'),
('C003', 'Tran Thi B', NULL, 'Vietnam');

INSERT INTO source.products (product_id, product_name, category, price) VALUES
('P001', 'Laptop Dell', 'Electronics', 1500.00),
('P002', 'Iphone 15', 'Electronics', 1000.00),
('P003', 'Balo', 'Accessories', 50.00);

INSERT INTO source.sales (transaction_id, customer_id, product_id, quantity, transaction_date) VALUES
('T001', 'C001', 'P001', 1, '2026-05-01'),
('T002', 'C002', 'P002', 2, '05/02/2026'), 
('T003', 'C003', 'P003', 5, '2026-05-03'),
('T004', NULL, 'P001', 1, '2026-05-04');


CREATE SCHEMA IF NOT EXISTS dw;
CREATE TABLE IF NOT EXISTS dw.dim_date (
    date_key INT PRIMARY KEY,         
    full_date DATE UNIQUE,           
    day INT,
    month INT,
    year INT,
    quarter INT
);

CREATE TABLE IF NOT EXISTS dw.dim_customer (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_name VARCHAR(255),
    country_code VARCHAR(10)
);

CREATE TABLE IF NOT EXISTS dw.dim_product (
    product_id VARCHAR(50) PRIMARY KEY,
    product_name VARCHAR(255),
    category VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS dw.dim_country (
    country_code VARCHAR(10) PRIMARY KEY, 
    country_name VARCHAR(100),            
    region VARCHAR(50)                   
);

CREATE TABLE IF NOT EXISTS dw.fact_sales (
    transaction_id VARCHAR(50) PRIMARY KEY,
    date_key INT,
    customer_id VARCHAR(50),
    product_id VARCHAR(50),
    quantity INT
);

SELECT transaction_id, COUNT(*) 
FROM staging.sales 
GROUP BY transaction_id 
HAVING COUNT(*) > 1;

CREATE SCHEMA IF NOT EXISTS audit;
CREATE TABLE IF NOT EXISTS audit.audit_log (
    log_id SERIAL PRIMARY KEY,
    event_name VARCHAR(100),
    status VARCHAR(20),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE SCHEMA IF NOT EXISTS audit;

CREATE TABLE IF NOT EXISTS audit.audit_log (
    log_id SERIAL PRIMARY KEY,
    event_name VARCHAR(100),
    status VARCHAR(20),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE VIEW dw.v_sales_report AS
SELECT 
    f.transaction_id,
    f.quantity,
    d.full_date,
    TO_CHAR(d.full_date, 'Month') AS month_name, 
    EXTRACT(YEAR FROM d.full_date) AS year,      
    c.customer_name,
    p.product_name,
    p.category,
    co.country_name,
    co.region
FROM dw.fact_sales f
JOIN dw.dim_date d ON f.date_key = d.date_key
JOIN dw.dim_customer c ON f.customer_id = c.customer_id
JOIN dw.dim_product p ON f.product_id = p.product_id
JOIN dw.dim_country co ON c.country_code = co.country_code;

CREATE OR REPLACE VIEW dw.v_sales_report AS
SELECT 
    f.transaction_id,
    f.quantity,
    d.full_date,
    TO_CHAR(d.full_date, 'Month') AS month_name, 
    EXTRACT(YEAR FROM d.full_date) AS year,      
    c.customer_name,
    p.product_name,
    p.category,
    co.country_name,
    co.region
FROM dw.fact_sales f
LEFT JOIN dw.dim_date d ON f.date_key = d.date_key
LEFT JOIN dw.dim_customer c ON f.customer_id = c.customer_id
LEFT JOIN dw.dim_product p ON f.product_id = p.product_id
LEFT JOIN dw.dim_country co ON c.country_code = co.country_code;

SELECT count(*) FROM dw.v_sales_report;
SELECT * FROM dw.dim_customer;
SELECT * FROM dw.dim_product;

UPDATE dw.dim_product SET product_name = 'Laptop Gaming', category = 'Điện tử' WHERE product_id = 'P001';
UPDATE dw.dim_product SET product_name = 'Chuột Không Dây', category = 'Phụ kiện' WHERE product_id = 'P002';
UPDATE dw.dim_product SET product_name = 'Bàn Phím Cơ', category = 'Phụ kiện' WHERE product_id = 'P003';
UPDATE dw.dim_product SET product_name = 'Màn Hình 4K', category = 'Điện tử' WHERE product_id = 'P004';
UPDATE dw.dim_product SET product_name = 'Tai Nghe Noise Cancelling', category = 'Âm thanh' WHERE product_id = 'P005';
UPDATE dw.dim_product SET product_name = 'Loa Bluetooth', category = 'Âm thanh' WHERE product_id = 'P006';
UPDATE dw.dim_product SET product_name = 'Ổ Cứng SSD', category = 'Lưu trữ' WHERE product_id = 'P007';

UPDATE dw.dim_customer
SET 
    customer_name = 'Khách hàng ' || SUBSTRING(customer_id FROM 2),
    country_code = 'VN'
WHERE customer_name IS NULL;

SELECT * FROM dw.dim_product;
