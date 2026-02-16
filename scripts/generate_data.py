import pandas as pd
import numpy as np
from faker import Faker
from datetime import datetime, timedelta
import random
import os

fake = Faker("pt_BR")

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

print("Customers e Products gerados com sucesso.")
