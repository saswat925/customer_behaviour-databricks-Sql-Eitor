# customer_behaviour-databricks-Sql-Eitor
Performed end-to-end customer_behaviour data analysis using Databricks SQL Editor to identify sales trends, seasonal revenue, and customer purchasing behavior.

# 📊 Customer Behavior Analysis Project

---

## 📌 Project Overview
This project analyzes customer purchasing behavior using a dataset of **3,900 records and 18 features**.  
The goal is to extract insights related to revenue, customer segmentation, marketing effectiveness, product trends, and geography.

---

## 📁 Dataset Description
- Total Records: **3,900**
- Features: **18 columns**
- Key Fields:
  - Customer_ID
  - Age, Gender
  - Item_Purchased, Category
  - Purchase_Amount_usd
  - Location, Size, Color, Season
  - Subscription_Status
  - Discount_Applied, Promo_Code_Used
  - Payment_Method, Frequency_of_Purchases

---

## 🔍 Analysis Methodology
- Data Cleaning (NULL handling, duplicates, formatting)
- Feature Engineering (Age category, grouping)
- SQL-based analysis (Databricks SQL Editor)
- Aggregations & segmentation
- Business KPI calculations

---

## 💡 Key Insights

### 💰 Business Insights
- Total Revenue: **$233,081**
- Average Order Value (AOV): **$59.76**

### 🎯 Customer Insights
- Subscription users show inconsistent value contribution
- Repeat customers generate higher lifetime value

### 📉 Marketing Insights
- Discount usage not improving revenue significantly
- Promo codes underperforming

### 🌍 Geographic Insights
- 50 states analyzed
- Strong regional variation in sales performance

### 📦 Product Insights
- Size and color preferences vary by region
- Seasonal demand patterns identified

---

## ⚠️ Critical Findings
- Subscription model is not effectively driving revenue
- Discounts are not converting into higher sales
- Some regions underperform significantly

---

## 🛠️ Technical Stack
- Databricks
- SQL (Advanced Queries)
- Delta Lake
- Data Cleaning Pipelines

---

## 📈 Analysis Statistics
- Total Queries Written: 41
- Cleaned Dataset: Yes
- Final Table: `customer_behaviour_cleaned`

---

## 🔄 Reproduction Guide
1. Import dataset into Databricks
2. Run cleaning SQL scripts
3. Create `customer_behaviour_cleaned` table
4. Execute analysis queries
5. Generate insights

---

## 📁 Repository Structure
