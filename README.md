# 📊 Databricks End-to-End Data Engineering & Analytics Platform (Lakehouse)

## 🚀 Project Overview
This project demonstrates an **end-to-end Data Engineering pipeline** built using **AWS and Databricks**, following the **Lakehouse & Medallion Architecture (Raw → Bronze → Silver → Gold)**.

The solution simulates **real-world e-commerce data**, performs **incremental ingestion**, **data modeling**, **analytics transformations**, and finally serves **business KPIs via Databricks dashboards**, fully **orchestrated and automated**.

The goal of this project is to showcase **production-grade data engineering practices**, not just data processing.

---

## 🧠 Key Objectives
- Simulate realistic **source systems** using AWS Lambda  
- Build a **Lakehouse architecture on S3 + Delta Lake**  
- Implement **incremental ingestion & transformations**  
- Design **fact & dimension models**  
- Create **business-ready KPIs**  
- Orchestrate the full pipeline using **Databricks Jobs**  
- Enable **BI consumption & alerting**

---

## 🏗️ Architecture Overview

### High-Level Flow
AWS Lambda (Data Generation)
↓
Amazon S3 (Raw CSV Data)
↓
Databricks Bronze Layer (Delta)
↓
Databricks Silver Layer (Facts & Dimensions)
↓
Databricks Gold Layer (KPIs & Aggregates)
↓
Databricks Dashboards + Email Alerts


> The project follows **Medallion Architecture best practices** and uses **Delta Lake for reliability, schema enforcement, and incremental processing**.

---

## 🛠️ Tech Stack

| Layer | Technology |
|------|-----------|
| Data Generation | AWS Lambda (Python) |
| Storage | Amazon S3 |
| Processing | Databricks SQL |
| Storage Format | Delta Lake |
| Orchestration | Databricks Jobs |
| Catalog | Unity Catalog |
| Visualization | Databricks Dashboards |
| Alerts | Databricks Email Notifications |

---

## 📦 Data Domains Covered
- Brands  
- Categories  
- Products  
- Customers  
- Orders  

Data is generated with realistic attributes such as:
- Payment methods  
- Order status (Placed / Cancelled)  
- Geography  
- Quantity & pricing behavior  

---

## 🧱 Medallion Architecture

### 🔹 Raw Layer
- Source-of-truth data stored as **CSV**
- No transformations applied
- Stored directly in **Amazon S3**

### 🔹 Bronze Layer
- Raw data converted to **Delta format**
- Schema enforcement
- Incremental ingestion
- Minimal transformations

### 🔹 Silver Layer
- Business-ready datasets
- Fact and Dimension modeling
- Examples:
  - `fact_orders`
  - `dim_customers`
  - `dim_products`
- Cleaned, deduplicated, and structured data

### 🔹 Gold Layer
- Aggregated **business KPIs**
- Optimized for BI & reporting
- Stored as **Delta tables**
- Exposed via **views and dashboards**

---

## 📈 Business Metrics Implemented

### Revenue Metrics
- Revenue per product
- Revenue per category
- Revenue per brand
- Revenue per customer
- Revenue per country
- Revenue per gender

### Cancellation Analytics
- Cancellation rate by payment method
- Cancellation by product
- Cancellation by brand & category
- Cancellation by customer & country
- Lost revenue due to cancellations

---

## 🔄 Orchestration & Automation
The entire pipeline is orchestrated using **Databricks Jobs** with well-defined dependencies:

1. Raw ingestion (Bronze)
2. Fact & Dimension refresh (Silver)
3. Aggregations & KPIs (Gold)
4. Dashboard refresh
5. Email notification on successful completion

This mirrors **real-world batch data pipeline orchestration**.

---

## 📊 Dashboards & Alerts
- Interactive Databricks dashboards built on Gold tables
- Dashboards refresh automatically after pipeline completion
- Email alerts notify on successful refresh

---

## 🧪 Key Data Engineering Concepts Demonstrated
- Lakehouse Architecture
- Delta Lake (ACID, schema enforcement)
- Incremental data processing
- Fact & Dimension modeling
- KPI design
- Orchestration with dependencies
- Separation of concerns (Raw / Bronze / Silver / Gold)

---

## 📸 Screenshots & PDF Included
- Unity Catalog showing Medallion layers
- Databricks Job orchestration DAG
- Gold layer Delta tables stored in S3
- Dashboards and KPIs
- Dasbhboared Refresh Alert to Email along with PDF version
