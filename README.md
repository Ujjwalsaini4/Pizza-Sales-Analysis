# Pizza Sales Analysis using PostgreSQL 🍕

## Project Overview

This project analyzes a Pizza Sales dataset using PostgreSQL to uncover valuable business insights related to sales performance, customer ordering behavior, product popularity, and revenue generation.

The project demonstrates SQL concepts ranging from basic queries to advanced analytical techniques, including joins, aggregations, Common Table Expressions (CTEs), and window functions.

---

## Database Schema

The following Entity Relationship Diagram (ERD) illustrates the database structure and relationships between tables.

![Pizza Sales ER Diagram](pizza.gif)

### Table Relationships

- **orders** → **order_details** (One-to-Many)
- **pizza** → **order_details** (One-to-Many)
- **pizza_types** → **pizza** (One-to-Many)

---

## Database Tables

### orders
Stores information about customer orders.

| Column | Description |
|----------|-------------|
| order_id | Unique order identifier |
| date | Order date |
| time | Order time |

### order_details
Stores details of pizzas included in each order.

| Column | Description |
|----------|-------------|
| order_details_id | Unique record identifier |
| order_id | References orders table |
| pizza_id | References pizza table |
| quantity | Number of pizzas ordered |

### pizza
Contains pizza size and pricing information.

| Column | Description |
|----------|-------------|
| pizza_id | Unique pizza identifier |
| pizza_type_id | References pizza_types table |
| size | Pizza size |
| price | Pizza price |

### pizza_types
Contains pizza names, categories, and ingredients.

| Column | Description |
|----------|-------------|
| pizza_type_id | Unique pizza type identifier |
| name | Pizza name |
| category | Pizza category |
| ingredients | Ingredients used |

---

## SQL Concepts Used

- Database Design
- Primary Keys & Foreign Keys
- Data Import using CSV Files
- INNER JOIN
- Aggregate Functions
  - COUNT()
  - SUM()
  - AVG()
  - MIN()
  - MAX()
- GROUP BY
- ORDER BY
- Common Table Expressions (CTEs)
- Window Functions
- Ranking Functions
- Revenue Analysis
- Trend Analysis

---

## Business Questions Solved

### Basic Analysis

- Retrieve the total number of orders placed.
- Calculate total revenue generated.
- Identify the highest-priced pizza.
- Determine the most common pizza size ordered.
- Find the top 5 most ordered pizzas.

### Intermediate Analysis

- Calculate total quantity sold by pizza category.
- Analyze order distribution by hour.
- Determine category-wise pizza distribution.
- Calculate average pizzas ordered per day.
- Identify the top 3 revenue-generating pizzas.

### Advanced Analysis

- Calculate the percentage contribution of each pizza to total revenue.
- Analyze cumulative revenue over time.
- Rank pizzas by revenue within each category.
- Identify top-performing products using window functions.

---


## Tools & Technologies

- PostgreSQL
- SQL
- CSV Dataset
- pgAdmin
- GitHub

---

## Project Structure

```text
Pizza-Sales-Analysis/
│
├── pizza.sql
├── pizza.gif
├── README.md
│
└── dataset/
    ├── orders.csv
    ├── order_details.csv
    ├── pizzas.csv
    └── pizza_types.csv
```

---

## How to Run the Project

1. Create a PostgreSQL database.
2. Execute the SQL script (`pizza.sql`).
3. Import the CSV files into the corresponding tables.
4. Run the SQL queries.
5. Analyze the generated insights and results.

---

## Learning Outcomes

Through this project, I gained practical experience in:

- Relational Database Design
- SQL Query Optimization
- Data Analysis with SQL
- Business Intelligence Reporting
- CTEs and Window Functions
- Revenue and Sales Analytics

---

## Author

**Ujjwal Saini**

This project was developed to strengthen SQL and PostgreSQL skills through real-world sales data analysis.
