-- =========================
-- DIM_CUSTOMERS
-- =========================

DROP TABLE IF EXISTS dw.dim_customers;

CREATE TABLE dw.dim_customers (
  customer_key  SERIAL PRIMARY KEY,
  customer_id   INT,
  customer_name TEXT,
  city          TEXT,
  state         TEXT,
  region        TEXT,
  signup_date   DATE
);
