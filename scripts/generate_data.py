import pandas as pd
import numpy as np
from faker import Faker
from datetime import datetime, timedelta
import random
import os

fake = Faker("pt_BR")
random.seed(42)
np.random.seed(42)
Faker.seed(42)

# -------------------------
# CONFIGURAÇÕES
# -------------------------
NUM_CUSTOMERS = 5000
NUM_PRODUCTS = 500

start_date = datetime(2023, 1, 1)
end_date = datetime(2024, 12, 31)

date_range_days = (end_date - start_date).days

os.makedirs("data/raw", exist_ok=True)

# -------------------------
# GERAR CUSTOMERS
# -------------------------

customers = []

regions = {
    "SP": "Sudeste",
    "RJ": "Sudeste",
    "MG": "Sudeste",
    "RS": "Sul",
    "PR": "Sul",
    "SC": "Sul",
    "BA": "Nordeste",
    "PE": "Nordeste",
    "CE": "Nordeste"
}

states = list(regions.keys())

for i in range(1, NUM_CUSTOMERS + 1):
    state = random.choice(states)
    signup = start_date + timedelta(days=random.randint(0, date_range_days))

    customers.append([
        i,
        fake.name(),
        fake.city(),
        state,
        regions[state],
        signup.date()
    ])

df_customers = pd.DataFrame(customers, columns=[
    "customer_id",
    "customer_name",
    "city",
    "state",
    "region",
    "signup_date"
])

df_customers.to_csv("data/raw/customers.csv", index=False)

# -------------------------
# GERAR PRODUCTS
# -------------------------

categories = ["Eletronicos", "Casa", "Moda", "Esporte", "Informatica"]

products = []

for i in range(1, NUM_PRODUCTS + 1):
    cost = round(random.uniform(10, 500), 2)
    price = round(cost * random.uniform(1.2, 2.0), 2)

    products.append([
        i,
        f"Produto_{i}",
        random.choice(categories),
        fake.company(),
        cost,
        price
    ])

df_products = pd.DataFrame(products, columns=[
    "product_id",
    "product_name",
    "category",
    "brand",
    "cost",
    "price"
])

df_products.to_csv("data/raw/products.csv", index=False)

# Criar lookup rápido de preços (evita consulta lenta dentro do loop)
price_lookup = df_products.set_index("product_id")["price"].to_dict()

# -------------------------
# GERAR ORDERS (Order + Items)
# -------------------------

NUM_ORDERS = 20000
MAX_ITEMS_PER_ORDER = 5

orders = []
current_sale_id = 1

for order_id in range(1, NUM_ORDERS + 1):

    customer_id = random.randint(1, NUM_CUSTOMERS)
    order_date = start_date + timedelta(days=random.randint(0, date_range_days))

    num_items = random.randint(1, MAX_ITEMS_PER_ORDER)

    for _ in range(num_items):

        product_id = random.randint(1, NUM_PRODUCTS)
        quantity = random.randint(1, 5)

        unit_price = price_lookup[product_id]
        discount = round(random.uniform(0, 0.3), 2)

        total = round(quantity * unit_price * (1 - discount), 2)

        orders.append([
            current_sale_id,
            order_id,
            order_date.date(),
            customer_id,
            product_id,
            quantity,
            unit_price,
            discount,
            total
        ])

        current_sale_id += 1


df_orders = pd.DataFrame(orders, columns=[
    "sale_id",
    "order_id",
    "order_date",
    "customer_id",
    "product_id",
    "quantity",
    "unit_price",
    "discount",
    "total_amount"
])

df_orders.to_csv("data/raw/orders.csv", index=False)

print("Orders gerados com múltiplos itens por pedido.")
