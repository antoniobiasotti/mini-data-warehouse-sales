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

-- =========================
-- DIM_PRODUCTS
-- =========================

DROP TABLE IF EXISTS dw.dim_products;

CREATE TABLE dw.dim_products (
  product_key   SERIAL PRIMARY KEY,
  product_id    INT,
  product_name  TEXT,
  category      TEXT,
  brand         TEXT,
  cost          NUMERIC(10,2),
  price         NUMERIC(10,2)
);