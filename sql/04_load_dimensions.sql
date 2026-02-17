-- Sempre limpar fact primeiro por causa das FKs
TRUNCATE TABLE
  dw.fact_sales,
  dw.dim_customers,
  dw.dim_products
RESTART IDENTITY;

-- =========================
-- LOAD DIM_CUSTOMERS
-- =========================

INSERT INTO dw.dim_customers (
  customer_id,
  customer_name,
  city,
  state,
  region,
  signup_date
)
SELECT
  customer_id,
  customer_name,
  city,
  state,
  region,
  signup_date
FROM staging.customers;

-- =========================
-- LOAD DIM_PRODUCTS
-- =========================

INSERT INTO dw.dim_products (
  product_id,
  product_name,
  category,
  brand,
  cost,
  price
)
SELECT
  product_id,
  product_name,
  category,
  brand,
  cost,
  price
FROM staging.products;

-- =========================
-- LOAD FACT_SALES
-- =========================

INSERT INTO dw.fact_sales (
  customer_key,
  product_key,
  date_key,
  order_id,
  quantity,
  unit_price,
  discount,
  total_amount
)
SELECT
  dc.customer_key,
  dp.product_key,
  dd.date_key,
  so.order_id,
  so.quantity,
  so.unit_price,
  so.discount,
  so.total_amount
FROM staging.orders so
JOIN dw.dim_customers dc
  ON so.customer_id = dc.customer_id
JOIN dw.dim_products dp
  ON so.product_id = dp.product_id
JOIN dw.dim_date dd
  ON so.order_date = dd.full_date;
