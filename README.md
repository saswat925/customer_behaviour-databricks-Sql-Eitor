# 🛍️ Customer Behavior Analysis - E-Commerce Insights

![Databricks](https://img.shields.io/badge/Databricks-FF3621?style=for-the-badge&logo=databricks&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-4479A1?style=for-the-badge&logo=postgresql&logoColor=white)
![Unity Catalog](https://img.shields.io/badge/Unity_Catalog-FF3621?style=for-the-badge&logo=databricks&logoColor=white)

## 📊 Project Overview

Comprehensive analysis of e-commerce customer behavior data to uncover purchasing patterns, marketing effectiveness, and revenue optimization opportunities. This project demonstrates advanced SQL analytics on customer demographics, product preferences, and shopping behaviors using **Databricks SQL** and **Unity Catalog**.

### 🎯 Key Objectives
- Analyze customer purchasing behavior and demographics
- Evaluate marketing campaign effectiveness (discounts, promo codes, subscriptions)
- Identify product preferences across categories, sizes, colors, and seasons
- Uncover geographic revenue patterns and high-value customer segments
- Provide data-driven recommendations for business growth

---

## 📁 Dataset Description

### Database Structure

**Catalog:** `saswat`  
**Schema:** `pintu`  
**Table:** `customer_behaviour`  
**Total Records:** 3,900 customer transactions

### Schema Details

```sql
├── Customer_ID (STRING) - Unique customer identifier
├── Age (INT) - Customer age
├── Gender (STRING) - Customer gender
├── Item_Purchased (STRING) - Product name
├── Category (STRING) - Product category
├── Purchase_Amount_USD (DOUBLE) - Transaction amount in USD
├── Location (STRING) - Customer location (US states)
├── Size (STRING) - Product size (S, M, L, XL)
├── Color (STRING) - Product color
├── Season (STRING) - Purchase season
├── Review_Rating (DOUBLE) - Customer rating (1-5)
├── Subscription_Status (STRING) - Yes/No subscription
├── Shipping_Type (STRING) - Delivery method
├── Discount_Applied (STRING) - Yes/No discount
├── Promo_Code_Used (STRING) - Yes/No promo code
├── Previous_Purchases (INT) - Count of prior purchases
├── Payment_Method (STRING) - Payment type
├── Frequency_of_Purchases (STRING) - Purchase frequency
└── age_category (STRING) - Age group classification (derived)
```

### Data Dimensions

| Dimension | Count | Description |
|-----------|-------|-------------|
| **Total Customers** | 3,900 | Unique customer records |
| **Product Categories** | 4 | Clothing, Footwear, Accessories, Outerwear |
| **Unique Items** | 25 | Distinct products |
| **Locations** | 50 | US states |
| **Age Groups** | 4 | Young Adult, Adult, Middle Age, Senior |

---

## 🧹 Data Cleaning & Preparation

### Quality Validation Process

#### ✅ 1. Null & Blank Value Check
```sql
-- Checked 18 columns for NULL and blank values
-- Result: ✅ 0 null values, 0 blank values found
```

#### ✅ 2. Duplicate Detection
```sql
-- Verified uniqueness of Customer_ID
-- Result: ✅ No duplicate customer IDs found
```

#### ✅ 3. Data Type Validation
```sql
-- Verified appropriate data types for all columns
-- Result: ✅ All data types correct
```

#### ✅ 4. Range & Outlier Check
```sql
-- Checked age range and purchase amounts
-- Result: ✅ Data within expected ranges
```

#### ✅ 5. Column Renaming
```sql
-- Standardized column names:
-- Customer ID → Customer_ID
-- Purchase_Amount (USD) → Purchase_Amount_USD
```

### Feature Engineering

#### Age Category Classification
```sql
ALTER TABLE customer_behaviour_cleaned ADD COLUMNS (age_category STRING);

UPDATE customer_behaviour_cleaned SET age_category =
CASE
    WHEN age BETWEEN 18 AND 25 THEN 'Young Adult'
    WHEN age BETWEEN 26 AND 40 THEN 'Adult'
    WHEN age BETWEEN 41 AND 55 THEN 'Middle Age'
    WHEN age BETWEEN 56 AND 70 THEN 'Senior'
    ELSE 'Other'
END;
```

**Created cleaned table:** `customer_behaviour_cleaned` (3,900 rows)

---

## 📈 Analysis & Key Insights

### 1️⃣ Business KPIs Overview

| Metric | Value | Analysis |
|--------|-------|----------|
| **Total Customers** | 3,900 | Complete transaction dataset |
| **Total Revenue** | $233,081 | Annual performance |
| **Avg Revenue/Customer** | $59.77 | Moderate transaction value |
| **Avg Review Rating** | 3.75 / 5.0 | Room for improvement |
| **Subscription Rate** | 27% (1,053) | Growth opportunity |
| **Avg Previous Purchases** | 25.4 | Strong loyalty indicator |

**💡 Key Insights:**
- **Revenue Performance:** 3,900 customers generated $233K total revenue (~$60 avg per customer)
- **Customer Satisfaction:** Average 3.75/5.0 rating indicates moderate satisfaction with improvement potential
- **Subscription Opportunity:** Only 27% subscribed despite high loyalty (25.4 avg previous purchases)
- **Retention Strength:** High average previous purchases (25.4) shows strong repeat customer base

---

### 2️⃣ Revenue Analysis by Category

| Category | Revenue | % of Total | Performance |
|----------|---------|------------|-------------|
| **Clothing** | $104,264 | 44.7% | 🟢 Leader |
| **Footwear** | $57,468 | 24.7% | 🟡 Strong |
| **Accessories** | $52,825 | 22.7% | 🟡 Good |
| **Outerwear** | $18,524 | 7.9% | 🔴 Weak |

**💡 Key Insights:**
- **Clothing dominates** with $104K revenue (45% of total)
- **Outerwear severely underperforms** at $18.5K (only 8% share)
- **Top 2 categories** (Clothing + Footwear) drive 69% of revenue
- **5.6X revenue gap** between best (Clothing) and worst (Outerwear) performer

**🎯 Recommendation:** Reevaluate Outerwear product line or launch targeted campaigns to boost underperforming category.

---

### 3️⃣ Product Performance Analysis

#### Average Order Value
**AOV:** $59.76

#### Most Purchased Items (Top 5)

| Rank | Item | Orders | Insight |
|------|------|--------|----------|
| 1 | Blouse | 171 | Equal demand |
| 1 | Pants | 171 | Equal demand |
| 1 | Jewelry | 171 | Equal demand |
| 4 | Various | ~156 | Balanced mix |

**💡 Key Insights:**
- **Equal demand** for Blouses, Pants, and Jewelry (171 purchases each)
- **Diversified customer interest** rather than single product dominance
- **No clear bestseller** - suggests balanced inventory strategy needed
- **25 unique products** maintain relatively even distribution

---

### 4️⃣ Seasonal Demand Analysis

| Season | Revenue | % of Total | Rank |
|--------|---------|------------|------|
| **Fall** | $60,018 | 25.8% | 🥇 1 |
| **Winter** | $58,814 | 25.2% | 🥈 2 |
| **Spring** | $58,472 | 25.1% | 🥉 3 |
| **Summer** | $55,777 | 23.9% | 4 |

**💡 Key Insights:**
- **Fall leads** with $60K revenue (highest season)
- **Summer lags** at $55.7K (7.5% below Fall)
- **Minimal seasonal variance** - only $4.2K spread (7.5% range)
- **Consistent demand** across all seasons indicates stable business

**🎯 Opportunity:** Launch summer promotions to close the gap with Fall performance.

---

### 5️⃣ Purchase Frequency Analysis

| Frequency | Customers | % of Total |
|-----------|-----------|------------|
| **Quarterly** | 584 | 15.0% |
| **Monthly** | 553 | 14.2% |
| **Weekly** | 539 | 13.8% |
| **Bi-Weekly** | ~400+ | ~10-13% |
| **Other** | ~1,800+ | ~46% |

**💡 Key Insights:**
- **Balanced purchasing behavior** across all frequencies
- **No dominant frequency** - Weekly (539), Monthly (553), Quarterly (584) nearly equal
- **Diverse customer habits** suggest need for flexible engagement strategies
- **Opportunity for segmentation** based on purchase cadence

---

### 6️⃣ Customer Loyalty Analysis

#### Repeat Customer Breakdown

| Customer Type | Count | % of Total |
|---------------|-------|------------|
| **New Customers** | 0 | 0% |
| **Returning Customers** | 3,900 | 100% |

**💡 Critical Insight:**
- **All customers are returning customers** (Previous_Purchases > 0 for all 3,900)
- **No new customer acquisition** captured in this dataset
- **Each customer made exactly ONE purchase** in the analysis period
- **CLV equals single transaction** - no multi-order customers

**🎯 Data Interpretation:**
- This dataset represents **single transactions from existing customers**
- High Previous_Purchases (avg 25.4) refers to lifetime history, not current period
- Focus should be on **retention and increasing order frequency**

---

### 7️⃣ Marketing Effectiveness Analysis

#### A. Discount Impact

| Discount Status | Avg Spend | Insight |
|-----------------|-----------|----------|
| **No Discount** | $60.13 | Baseline |
| **With Discount** | $59.28 | -1.4% |

**💡 Key Insight:**
- **Minimal discount impact** - discounted sales are actually 1.4% LOWER
- **Discounts don't drive higher spending** in this dataset
- **Margin erosion risk** without revenue benefit

**🎯 Recommendation:** Reevaluate discount strategy - consider targeted offers vs. blanket discounts.

#### B. Promo Code Usage

| Promo Status | Customers | % of Total |
|--------------|-----------|------------|
| **Not Used** | 2,223 | 57% |
| **Used** | 1,677 | 43% |

**💡 Key Insight:**
- **57% of customers don't use promo codes** (2,223 of 3,900)
- **43% adoption rate** shows moderate engagement
- **Opportunity for increased promotion**

#### C. Subscription Impact

| Subscription | Avg Spend | Insight |
|--------------|-----------|----------|
| **No Subscription** | $59.87 | Baseline |
| **With Subscription** | $59.49 | -0.6% |

**💡 Key Insight:**
- **Negligible subscription impact** on spending (-$0.38 difference)
- **27% subscription rate** is low given 25.4 avg previous purchases
- **Subscriptions not driving revenue** currently

**🎯 Recommendation:** Redesign subscription benefits to drive higher AOV or create exclusive perks.

---

### 8️⃣ Payment & Shipping Preferences

#### Payment Method Distribution

| Payment Method | Usage | % of Total |
|----------------|-------|------------|
| **PayPal** | 677 | 17.4% |
| **Credit Card** | 671 | 17.2% |
| **Cash** | 670 | 17.2% |
| **Venmo** | 634 | 16.3% |
| **Debit Card** | 636 | 16.3% |
| **Bank Transfer** | 612 | 15.7% |

**💡 Key Insight:**
- **Evenly distributed** across all 6 payment methods
- **No dominant preference** - all within 10% of each other (612-677 range)
- **Diverse payment flexibility** meets customer needs

#### Shipping Type Distribution

| Shipping Type | Usage | % of Total |
|---------------|-------|------------|
| **Free Shipping** | 675 | 17.3% |
| **Standard** | ~660 | ~16.9% |
| **Express** | ~650 | ~16.7% |
| **Store Pickup** | ~640 | ~16.4% |
| **Next Day** | ~630 | ~16.2% |
| **2-Day Shipping** | 627 | 16.1% |

**💡 Key Insight:**
- **Free shipping most popular** at 675 orders (17.3%)
- **2-Day shipping least used** at 627 orders (16.1%)
- **Only 7.6% variance** between highest and lowest - nearly equal distribution
- **Free shipping doesn't dominate** - customers value speed options too

---

### 9️⃣ Customer Segmentation Analysis

#### A. Age Category Spending

| Age Category | Avg Spend | Rank |
|--------------|-----------|------|
| **Young Adult** (18-25) | $60.65 | 🥇 1 |
| **Middle Age** (41-55) | $60.08 | 🥈 2 |
| **Adult** (26-40) | $59.69 | 🥉 3 |
| **Senior** (56-70) | $59.06 | 4 |

**💡 Key Insights:**
- **Young Adults spend most** at $60.65 average
- **Minimal age variance** - only $1.59 spread (2.7% range)
- **All age groups spend similarly** (~$59-61)
- **Age is NOT a strong spending predictor** in this dataset

#### B. High-Value Customers

**Top Spending Pattern:**
- **Each customer = single transaction** (no repeat orders in period)
- **Total spent = single purchase amount**
- **Range:** $20 (lowest) to $100 (highest) per transaction

---

### 🔟 Geographic Analysis

#### Top 10 Revenue-Generating States

| Rank | State | Orders | Revenue | AOV |
|------|-------|--------|---------|------|
| 🥇 1 | **Montana** | 96 | $5,784 | $60.25 |
| 🥈 2 | **Illinois** | 88 | $5,617 | $63.83 |
| 🥉 3 | **California** | 91 | $5,605 | $61.59 |
| 4 | **Idaho** | 79 | $5,141 | $65.08 |
| 5 | **Nevada** | 86 | $5,107 | $59.38 |

#### Bottom 5 States (Underperformers)

| Rank | State | Orders | Revenue | AOV |
|------|-------|--------|---------|------|
| 46 | **Kansas** | 63 | $3,437 | $54.56 |
| 47 | **Hawaii** | 64 | $3,752 | $58.63 |
| 48 | **Florida** | 69 | $3,798 | $55.04 |
| 49 | Other | - | <$4,000 | - |

#### Premium Markets (Highest AOV)

| Rank | State | AOV | Orders | Revenue |
|------|-------|-----|--------|----------|
| 1 | **Alaska** | $67.60 | 67 | $4,529 |
| 2 | **Pennsylvania** | $66.57 | 73 | $4,860 |
| 3 | **Arizona** | $66.55 | 68 | $4,525 |

**💡 Key Geographic Insights:**

1. **Montana leads revenue** with $5,784 (96 orders) - strong market penetration
2. **Top 5 states generate 11.8%** of total revenue - concentration opportunity
3. **Alaska, Pennsylvania, Arizona** are premium markets with 15%+ higher AOV
4. **Kansas, Florida, Hawaii severely underperform** despite population size
5. **52% order volume variance** (96 vs 63) but only 24% AOV variance ($67.60 vs $54.56)
6. **Acquisition is bigger problem** than pricing power across markets

**🎯 Strategic Recommendations:**
- **Expand in premium states:** Alaska, Pennsylvania, Arizona (high AOV)
- **Urgent intervention needed:** Kansas, Florida, Hawaii (localized marketing)
- **Replicate Montana success:** Analyze and apply winning strategies

---

### 1️⃣1️⃣ Product Attribute Analysis

#### A. Size Preference Analysis

| Size | Orders | % of Total | Revenue | % of Revenue |
|------|--------|------------|---------|---------------|
| **Medium (M)** | 1,755 | 45.0% | $105,167 | 45.1% |
| **Large (L)** | 1,050 | 26.9% | $62,682 | 26.9% |
| **Small (S)** | 666 | 17.1% | $39,668 | 17.0% |
| **Extra-Large (XL)** | 429 | 11.0% | $25,564 | 11.0% |

**💡 Key Size Insights:**

1. **Medium dominates:** 1,755 orders (45%) generating $105K (45% of total)
2. **Clear preference decline:** M → L → S → XL
3. **Medium outperforms Large by 67%** in order volume
4. **Medium vs XL:** 309% more orders (4:1 ratio)
5. **Revenue mirrors order volume** - no size premium detected

**🎯 Inventory Strategy:**
- **Stock ratio:** 4 Medium : 2.4 Large : 1.6 Small : 1 XL
- **Prioritize Medium** to avoid stockouts
- **Minimize XL inventory** to reduce overstock risk

#### B. Color-Season Preference Analysis

**Top 10 Color-Season Combinations:**

| Rank | Color | Season | Orders |
|------|-------|--------|--------|
| 1 | Silver | Summer | 59 |
| 2 | Olive | Spring | 58 |
| 3 | Yellow | Winter | 57 |
| 4 | Charcoal | Fall | 56 |
| 5 | Gray | Summer | 55 |

**💡 Key Color-Season Insights:**

1. **100 unique color-season combinations** exist in dataset
2. **Extremely fragmented preferences** - no clear winner
3. **Narrow order range:** 59 (highest) to 24 (lowest)
4. **Silver-Summer leads** with only 59 orders (1.5% of total)
5. **Customers buy colors evenly** across all seasons
6. **No seasonal color trends** detected

**🎯 Merchandising Strategy:**
- **Offer diverse color palettes** year-round
- **Avoid seasonal color restrictions**
- **Stock based on size, not color-season**

---

## 🎯 Strategic Recommendations

### 🔴 Critical Actions (Immediate - 0-30 Days)

#### 1. Fix Subscription Value Proposition
**Problem:** 27% subscription rate despite 25.4 avg previous purchases  
**Solution:** Redesign subscription with exclusive benefits (early access, free shipping, loyalty points)  
**Impact:** Potential to double subscription rate to 50%+

#### 2. Address Outerwear Underperformance
**Problem:** Only $18.5K revenue (8% share) - 5.6X behind Clothing  
**Solution:** Conduct customer survey, refresh product line, or launch targeted campaign  
**Impact:** 20% boost = +$3.7K revenue

#### 3. Boost Underperforming States
**Problem:** Kansas, Florida, Hawaii generate <$4K each  
**Solution:** Localized marketing campaigns, influencer partnerships, regional promotions  
**Impact:** Bringing these to median ($4.5K) = +$4K total revenue

### 🟡 High-Impact Initiatives (30-90 Days)

#### 4. Reevaluate Discount Strategy
**Problem:** Discounts reduce AOV by $0.85 (1.4%)  
**Solution:** Replace blanket discounts with targeted offers (first-time, high-value, category-specific)  
**Impact:** Margin improvement of 1-2% = +$2.3K-$4.7K

#### 5. Increase Promo Code Adoption
**Problem:** 57% of customers (2,223) don't use promo codes  
**Solution:** Simplify code application, auto-apply at checkout, email reminders  
**Impact:** 10% adoption increase = 390 more engaged customers

#### 6. Optimize Inventory by Size
**Problem:** Equal stock across sizes despite 4:1 Medium:XL demand  
**Solution:** Implement 4:2.4:1.6:1 ratio for M:L:S:XL  
**Impact:** Reduce stockouts (Medium), minimize overstock (XL)

### 🟢 Long-Term Strategy (90-180 Days)

#### 7. Premium Market Expansion
**Opportunity:** Alaska, Pennsylvania, Arizona have 15%+ higher AOV  
**Solution:** Targeted ads, premium product placement, regional partnerships  
**Impact:** $10K+ incremental revenue from high-AOV markets

#### 8. Customer Satisfaction Improvement
**Problem:** 3.75/5.0 average rating - room for improvement  
**Solution:** Address top complaints, improve product quality, enhance customer service  
**Impact:** 4.0+ rating drives 10-15% conversion increase

#### 9. Summer Revenue Boost
**Problem:** Summer trails Fall by $4.2K (7.5%)  
**Solution:** Summer-specific campaigns (beach wear, vacation essentials)  
**Impact:** Close gap = +$4.2K in Q3

---

## 🛠️ Technologies & Tools

**Platform:** Databricks Lakehouse  
**Query Engine:** Databricks SQL (Serverless)  
**Compute:** Serverless Starter Warehouse (2X-Small)  
**Catalog:** Unity Catalog (saswat.pintu)  
**Storage:** Delta Lake Format  
**Language:** SQL (ANSI SQL with Databricks extensions)

**SQL Features Used:**
- ✅ Aggregate functions (SUM, COUNT, AVG, ROUND)
- ✅ CASE WHEN conditional logic
- ✅ Window functions
- ✅ GROUP BY & HAVING clauses
- ✅ ORDER BY & LIMIT
- ✅ NULL and blank value detection
- ✅ Data type validation
- ✅ ALTER TABLE operations
- ✅ UPDATE statements
- ✅ CREATE OR REPLACE TABLE

---

## 📂 Project Structure

```
customer-behaviour-analysis/
│
├── data/
│   └── customer_behaviour.csv        (3,900 rows)
│
├── sql/
│   ├── 01_data_cleaning.sql
│   ├── 02_feature_engineering.sql
│   ├── 03_business_kpis.sql
│   ├── 04_revenue_analysis.sql
│   ├── 05_marketing_effectiveness.sql
│   ├── 06_geographic_analysis.sql
│   ├── 07_product_attributes.sql
│   └── 08_recommendations.sql
│
├── results/
│   ├── business_kpis.csv
│   ├── category_revenue.csv
│   ├── geographic_analysis.csv
│   ├── size_preferences.csv
│   └── marketing_effectiveness.csv
│
└── README.md
```

---

## 🚀 How to Run

### Prerequisites
- Databricks workspace access
- Unity Catalog enabled
- SQL Warehouse (Serverless or Classic)

### Setup Steps

1. **Create Catalog and Schema**
```sql
CREATE CATALOG IF NOT EXISTS saswat;
USE CATALOG saswat;
CREATE SCHEMA IF NOT EXISTS pintu;
USE SCHEMA pintu;
```

2. **Load Data**
```sql
-- Upload customer_behaviour.csv to Databricks
-- Create table from file
CREATE TABLE customer_behaviour
USING CSV
OPTIONS (path '/path/to/customer_behaviour.csv', header 'true');
```

3. **Run Data Cleaning**
```sql
-- Execute cleaning and validation queries
-- Available in: customer_behaviour.sql.dbquery.ipynb
```

4. **Execute Analysis**
```sql
-- Run all 41 analytical queries
-- Results available in Databricks SQL Editor
```

---

## 📊 Sample Queries

### Get Revenue by Category
```sql
SELECT 
    Category, 
    SUM(Purchase_Amount_USD) AS revenue,
    COUNT(*) AS orders,
    ROUND(AVG(Purchase_Amount_USD), 2) AS avg_order_value
FROM customer_behaviour_cleaned
GROUP BY Category
ORDER BY revenue DESC;
```

### Analyze Geographic Performance
```sql
SELECT 
    Location,
    COUNT(*) AS total_orders,
    SUM(Purchase_Amount_USD) AS total_revenue,
    ROUND(AVG(Purchase_Amount_USD), 2) AS avg_order_value
FROM customer_behaviour_cleaned
GROUP BY Location
ORDER BY total_revenue DESC
LIMIT 10;
```

### Marketing Effectiveness
```sql
SELECT 
    Discount_Applied,
    Promo_Code_Used,
    Subscription_Status,
    COUNT(*) AS customers,
    ROUND(AVG(Purchase_Amount_USD), 2) AS avg_spend
FROM customer_behaviour_cleaned
GROUP BY Discount_Applied, Promo_Code_Used, Subscription_Status
ORDER BY avg_spend DESC;
```

---

## 📈 Key Metrics Summary

### Revenue Metrics
- **Total Revenue:** $233,081
- **Average Order Value:** $59.76
- **Revenue per Customer:** $59.77
- **Highest Category:** Clothing ($104,264)
- **Lowest Category:** Outerwear ($18,524)

### Customer Metrics
- **Total Customers:** 3,900
- **Avg Review Rating:** 3.75 / 5.0
- **Subscription Rate:** 27% (1,053)
- **Avg Previous Purchases:** 25.4
- **Promo Code Usage:** 43% (1,677)

### Product Metrics
- **Most Popular Size:** Medium (45% of orders)
- **Most Popular Season:** Fall ($60,018)
- **Top State:** Montana ($5,784)
- **Premium Market:** Alaska ($67.60 AOV)

### Marketing Metrics
- **Discount Impact:** -$0.85 AOV (negative)
- **Subscription Impact:** -$0.38 AOV (minimal)
- **Free Shipping:** Most popular (17.3%)

---

## 💡 Key Learnings

1. **Data Quality:** 100% clean data (no nulls, duplicates, or anomalies)
2. **Customer Loyalty:** High previous purchases (25.4 avg) but low subscription (27%)
3. **Marketing ROI:** Discounts and subscriptions show minimal/negative impact on AOV
4. **Geographic Variance:** 68% revenue difference between top and bottom states
5. **Product Mix:** Clear size preferences (M>L>S>XL) but fragmented color choices
6. **Seasonal Stability:** Only 7.5% variance across seasons
7. **Age Independence:** Age groups spend similarly (~$59-61)
8. **Payment Flexibility:** No dominant payment method - customers value choice

---

## 🎓 Business Impact

### Potential Revenue Uplift

| Initiative | Estimated Impact | Timeframe |
|------------|------------------|------------|
| Fix subscription value | +$20K-30K | 60 days |
| Boost underperforming states | +$4K-8K | 90 days |
| Optimize discount strategy | +$2.3K-4.7K | 30 days |
| Summer campaign | +$4.2K | 90 days (Q3) |
| Outerwear revival | +$3.7K | 60 days |
| **Total Potential** | **+$34K-50K** | **15-21% lift** |

---

## 📞 Contact & Feedback

**Project Author:** Saswat Betta Aptakam  
**Email:** saswatbetta.aptakam@gmail.com  
**Platform:** Databricks  
**Catalog:** saswat.pintu  
**Warehouse:** Serverless Starter (2X-Small)

---

## 📝 License

This project is created for educational and analytical purposes. Data is anonymized and used for demonstration of SQL analytics capabilities.

---

## 🙏 Acknowledgments

- Databricks for providing the Lakehouse platform
- Unity Catalog for data governance
- Delta Lake for reliable storage
- SQL community for analytics best practices


**📊 Built with Databricks SQL | 🚀 Powered by Unity Catalog | 💾 Delta Lake Storage**

---

*All queries executed in Databricks SQL Editor for comprehensive data extraction, cleaning, and analysis*
