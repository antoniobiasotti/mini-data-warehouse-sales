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

-- =========================
-- DIM_DATE
-- =========================

DROP TABLE IF EXISTS dw.dim_date;

CREATE TABLE dw.dim_date (
  date_key     INT PRIMARY KEY,          -- formato YYYYMMDD (ex: 20240115)
  full_date    DATE NOT NULL,
  day          SMALLINT NOT NULL,
  month        SMALLINT NOT NULL,
  month_name   TEXT NOT NULL,
  quarter      SMALLINT NOT NULL,
  year         SMALLINT NOT NULL,
  day_of_week  SMALLINT NOT NULL,         -- 1=Mon ... 7=Sun (ISO)
  is_weekend   BOOLEAN NOT NULL
);

-- =========================
-- FACT_SALES
-- =========================

DROP TABLE IF EXISTS dw.fact_sales;

CREATE TABLE dw.fact_sales (
  sale_key      SERIAL PRIMARY KEY,

  customer_key  INT REFERENCES dw.dim_customers(customer_key),
  product_key   INT REFERENCES dw.dim_products(product_key),
  date_key      INT REFERENCES dw.dim_date(date_key),

  order_id      INT,  -- degenerate dimension

  quantity      INT,
  unit_price    NUMERIC(10,2),
  discount      NUMERIC(4,2),
  total_amount  NUMERIC(12,2)
);
