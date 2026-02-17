-- Popular dim_date com calendário completo
-- Período: 2023-01-01 até 2024-12-31

TRUNCATE TABLE dw.dim_date;

INSERT INTO dw.dim_date (
  date_key, full_date, day, month, month_name, quarter, year, day_of_week, is_weekend
)
SELECT
  (TO_CHAR(d, 'YYYYMMDD'))::INT AS date_key,
  d AS full_date,
  EXTRACT(DAY FROM d)::SMALLINT AS day,
  EXTRACT(MONTH FROM d)::SMALLINT AS month,
  TO_CHAR(d, 'TMMonth')::TEXT AS month_name,
  EXTRACT(QUARTER FROM d)::SMALLINT AS quarter,
  EXTRACT(YEAR FROM d)::SMALLINT AS year,
  EXTRACT(ISODOW FROM d)::SMALLINT AS day_of_week,
  (EXTRACT(ISODOW FROM d) IN (6, 7)) AS is_weekend
FROM generate_series('2023-01-01'::DATE, '2024-12-31'::DATE, '1 day'::INTERVAL) AS d;
