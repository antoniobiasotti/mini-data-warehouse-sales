-- =========================
-- INDEXES FOR PERFORMANCE
-- =========================

CREATE INDEX IF NOT EXISTS idx_fact_date
ON dw.fact_sales(date_key);

CREATE INDEX IF NOT EXISTS idx_fact_product
ON dw.fact_sales(product_key);

CREATE INDEX IF NOT EXISTS idx_fact_customer
ON dw.fact_sales(customer_key);
