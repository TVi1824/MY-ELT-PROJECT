-- 1. TẠO CÁC SCHEMA (Khu vực phân vùng)
CREATE SCHEMA IF NOT EXISTS source;
CREATE SCHEMA IF NOT EXISTS staging;
CREATE SCHEMA IF NOT EXISTS warehouse;
CREATE SCHEMA IF NOT EXISTS audit;

-- 2. TẠO BẢNG KHÁCH HÀNG (Trong khu vực source)
CREATE TABLE IF NOT EXISTS source.customers (
    customer_id VARCHAR(50),
    customer_name VARCHAR(100),
    email VARCHAR(100),
    country VARCHAR(50)
);

-- 3. TẠO BẢNG SẢN PHẨM (Trong khu vực source)
CREATE TABLE IF NOT EXISTS source.products (
    product_id VARCHAR(50),
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

-- 4. TẠO BẢNG GIAO DỊCH BÁN HÀNG (Trong khu vực source)
CREATE TABLE IF NOT EXISTS source.sales (
    transaction_id VARCHAR(50),
    customer_id VARCHAR(50),
    product_id VARCHAR(50),
    quantity INT,
    transaction_date VARCHAR(50)
);

-- 5. NẠP DỮ LIỆU MẪU (Sample Data)
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