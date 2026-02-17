-- Schema: staging
-- Objetivo: armazenar dados brutos (raw) exatamente como chegam do CSV

DROP TABLE IF EXISTS staging.customers;
CREATE TABLE staging.customers (
  customer_id    INT,
  customer_name  TEXT,
  city           TEXT,
  state          TEXT,
  region         TEXT,
  signup_date    DATE
);

DROP TABLE IF EXISTS staging.products;
CREATE TABLE staging.products (
  product_id     INT,
  product_name   TEXT,
  category       TEXT,
  brand          TEXT,
  cost           NUMERIC(10,2),
  price          NUMERIC(10,2)
);

DROP TABLE IF EXISTS staging.orders;
CREATE TABLE staging.orders (
  sale_id       INT,
  order_id      INT,
  order_date    DATE,
  customer_id   INT,
  product_id    INT,
  quantity      INT,
  unit_price    NUMERIC(10,2),
  discount      NUMERIC(4,2),
  total_amount  NUMERIC(12,2)
);
