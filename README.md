# Mini Data Warehouse de Vendas com PostgreSQL

Este projeto implementa um Mini Data Warehouse em PostgreSQL, seguindo uma arquitetura em camadas (Raw → Staging → Data Warehouse) e aplicando Modelagem Dimensional (Star Schema) para suportar análises OLAP.

O sistema simula um ambiente transacional de e-commerce (OLTP), gera dados sintéticos e transforma esses dados em um modelo analítico otimizado para consultas agregadas e Business Intelligence.

## Objetivos
- Modelar um cenário de vendas (e-commerce) em **modelo estrela**
- Criar tabelas dimensionais e tabela fato
- Desenvolver queries analíticas (OLAP)
- Documentar o projeto como em ambiente corporativo

## Stack
- PostgreSQL
- SQL
- Python (para geração de dados sintéticos)

## Estrutura do repositório
- `data/raw/`: dados brutos (CSV)
- `data/staging/`: camada staging (intermediária)
- `sql/`: scripts SQL (DDL, cargas, transformações, análises)
- `docs/`: documentação técnica
- `scripts/`: scripts auxiliares (ex: geração de dados)
- `images/`: diagramas e screenshots

## Diagrama
![Star Schema](images/star_schema.png)

## Perguntas
1) Qual é a granularidade da tabela fato?  
R: A granularidade da fact_sales foi definida como:  
    > 1 linha = 1 item vendido por pedido. 

    Ou seja, cada registro representa um produto específico vendido em um determinado pedido, em uma determinada data, para um determinado cliente.

2) Por que utilizar Star Schema?  
R: Primeiramente, Star Schema é um modelo dimensional usado em Data Warehouse onde uma tabela fato central armazena métricas e se conecta a múltiplas tabelas dimensão que fornecem contexto. É um modelo otimizado para consultas OLAP e por ser simples e intuitivo é considerado padrão em Data Warehouses corporativos.
3) Qual a diferença entre tabela fato e dimensão?  
R: A tabela fato possui alta cardinalidade, isto é, alta distinção entre os valores dentro do conjunto de dados. Ela representa eventos mensuráveis de negócio, contendo métricas (measures) e foreign keys para as dimensões. Já a tabela dimensão contém atributos descritivos, em menor volume, e contém surrogate keys, como PK. Em resumo, a tabela fato responde "o que aconteceu" e a dimensão responde "em que contexto aconteceu". 
4) Se fossem adicionados 1 milhão de registros, o que pode impactar performance?  
R: O tempo de execução de consultas agregadas, tempo de JOIN, tempo de varredura, uso de memório e I/O. Em Data Warehouses, a leitura é muito mais frequente que escrita, então otimização de leitura é essencial.
5) Por que usar índices?  
R: Justamente para otimizar a leitura, acelerar consultas, melhorar a perfomance de JOIN, reduzir varreduras completas, diminuir o tempo de resposta.