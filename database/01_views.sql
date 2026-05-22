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