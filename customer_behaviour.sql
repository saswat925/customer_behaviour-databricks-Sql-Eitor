---first check raw data
select * from `saswat`.`pintu`.`customer_behaviour` limit 100;

use catalog saswat;
use schema pintu;

--rows count of raw table customer_behaviour
select count(*) from customer_behaviour;
---3900 rows

         --DATA CLEANING PART---

-- Columns already renamed in previous run, skipping ALTER TABLE statements
-- Customer ID -> Customer_ID (already done)
-- Purchase_Amount (USD) -> Purchase_Amount_usd (already done)

--check c name
select Purchase_Amount_usd from customer_behaviour;

--check column name
select * from customer_behaviour;

--null and blank check for total columns
SELECT
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS customer_id_nulls,
    SUM(CASE WHEN age IS NULL THEN 1 ELSE 0 END) AS age_nulls,

    SUM(CASE WHEN gender IS NULL OR TRIM(gender) = '' THEN 1 ELSE 0 END) AS gender_null_blank,

    SUM(CASE WHEN item_purchased IS NULL OR TRIM(item_purchased) = '' THEN 1 ELSE 0 END) AS item_purchased_null_blank,

    SUM(CASE WHEN category IS NULL OR TRIM(category) = '' THEN 1 ELSE 0 END) AS category_null_blank,

    SUM(CASE WHEN Purchase_Amount_USD IS NULL THEN 1 ELSE 0 END) AS purchase_amount_usd_nulls,

    SUM(CASE WHEN location IS NULL OR TRIM(location) = '' THEN 1 ELSE 0 END) AS location_null_blank,

    SUM(CASE WHEN size IS NULL OR TRIM(size) = '' THEN 1 ELSE 0 END) AS size_null_blank,

    SUM(CASE WHEN color IS NULL OR TRIM(color) = '' THEN 1 ELSE 0 END) AS color_null_blank,

    SUM(CASE WHEN season IS NULL OR TRIM(season) = '' THEN 1 ELSE 0 END) AS season_null_blank,

    SUM(CASE WHEN review_rating IS NULL THEN 1 ELSE 0 END) AS review_rating_nulls,

    SUM(CASE WHEN subscription_status IS NULL OR TRIM(subscription_status) = '' THEN 1 ELSE 0 END) AS subscription_status_null_blank,

    SUM(CASE WHEN shipping_type IS NULL OR TRIM(shipping_type) = '' THEN 1 ELSE 0 END) AS shipping_type_null_blank,

    SUM(CASE WHEN discount_applied IS NULL OR TRIM(discount_applied) = '' THEN 1 ELSE 0 END) AS discount_applied_null_blank,

    SUM(CASE WHEN promo_code_used IS NULL OR TRIM(promo_code_used) = '' THEN 1 ELSE 0 END) AS promo_code_used_null_blank,

    SUM(CASE WHEN previous_purchases IS NULL THEN 1 ELSE 0 END) AS previous_purchases_nulls,

    SUM(CASE WHEN payment_method IS NULL OR TRIM(payment_method) = '' THEN 1 ELSE 0 END) AS payment_method_null_blank,

    SUM(CASE WHEN frequency_of_purchases IS NULL OR TRIM(frequency_of_purchases) = '' THEN 1 ELSE 0 END) AS frequency_of_purchases_null_blank

FROM customer_behaviour;
  ---no null and no blank values found 

--Duplicate check
SELECT COUNT(*) FROM (SELECT Customer_ID, COUNT(*) FROM customer_behaviour GROUP BY Customer_ID HAVING COUNT(*) > 1);
    --no duplicate found

--  data type check
DESCRIBE customer_behaviour;

--unique value check
SELECT DISTINCT gender from customer_behaviour;

---range check
SELECT MIN(age), MAX(age) FROM customer_behaviour;

--outlier check
select max(purchase_amount_usd) from customer_behaviour;

---create a clean table customer_behaviour_cleaned
create or replace table customer_behaviour_cleaned as select * from customer_behaviour;

--check cleaned table
select * from customer_behaviour_cleaned;

select count(*) from customer_behaviour_cleaned;
 --- 3900 rows 

---age_category column add in customer_behaviour_cleaned table
alter table customer_behaviour_cleaned add columns (age_category string);

UPDATE customer_behaviour_cleaned SET age_category =
CASE
    WHEN age BETWEEN 18 AND 25 THEN 'Young Adult'
    WHEN age BETWEEN 26 AND 40 THEN 'Adult'
    WHEN age BETWEEN 41 AND 55 THEN 'Middle Age'
    WHEN age BETWEEN 56 AND 70 THEN 'Senior'
    ELSE 'Other'
END;

--check age_category column
SELECT DISTINCT age_category FROM customer_behaviour_cleaned;


    --ANALYSIS PART--

--🔑 Key dimensions:
--Customer info → Customer_ID, Age, Gender, Location, age_category
--Purchase info → Item_Purchased, Category, Purchase_Amount_usd, Previous_Purchases
--Behavioral info → Frequency_of_Purchases, Review_Rating
--Marketing → Discount_Applied, Promo_Code_Used, Subscription_Status
--Product attributes → Size, Color, Season
--Logistics → Shipping_Type
--Payment → Payment_Method

--total_customers= 3900
select count(distinct Customer_ID) as total_customers from customer_behaviour_cleaned;

--total_items_purchased= 25
select count(distinct Item_Purchased) as total_items_purchased from customer_behaviour_cleaned;

--total_unique_category= 4
select count(distinct Category) as total_unique_category from customer_behaviour_cleaned;

select * from customer_behaviour_cleaned;
          
             --BUSINESS KPI---
select count(customer_id) as total_customers, 
        sum(purchase_amount_usd) as total_revenue, 
        round(avg(review_rating),2) as avg_review_rating, 
        avg(previous_purchases) as avg_previous_purchases, 
        sum(case when subscription_status = 'Yes' then 1 else 0 end) as total_subscription_status 
        from customer_behaviour_cleaned;

--insights  --3,900 customers generated $233,081 total revenue (~$59.77 avg per customer)
--Average rating: 3.75/5.0 - moderate satisfaction, room for improvement
--27% subscription rate (1,053 of 3,900) - opportunity to increase conversions
--High loyalty: 25.4 avg previous purchases - strong repeat customer base

--Revenue by category
SELECT Category, SUM(Purchase_Amount_usd) AS revenue
FROM customer_behaviour_cleaned
GROUP BY Category
ORDER BY revenue DESC;  ---Best selling product 'clothing' revenue is ($104264), lowest selling product 'Outwear' is ($18524)

--Average order value
SELECT round(AVG(Purchase_Amount_usd),2) AS avg_order_value
FROM customer_behaviour_cleaned;  --value= 59.76

--Most purchased items
SELECT Item_Purchased, COUNT(*) AS times_bought
FROM customer_behaviour_cleaned
GROUP BY Item_Purchased
ORDER BY times_bought DESC; 
--Equal demand for Blouses, Pants, and Jewelry (171 purchases each) suggests diversified customer interest rather than dominance of a single category.

--Seasonal demand
SELECT Season, SUM(Purchase_Amount_usd) AS revenue
FROM customer_behaviour_cleaned
GROUP BY Season
ORDER BY revenue desc; 
--Fall has the highest revenue (60,018) and Summer has the lowest (55,777), showing clear seasonal variation in customer demand.

--Frequency of purchase
SELECT Frequency_of_Purchases, COUNT(*) AS customers
FROM customer_behaviour_cleaned
GROUP BY Frequency_of_Purchases
ORDER BY customers DESC; 
--Weekly (539) ,monthly (553), quarterly (584) purchase frequencies are almost equal, showing balanced customer buying behavior.

--Repeat customers
SELECT 
  CASE 
    WHEN Previous_Purchases > 0 THEN 'Returning'
    ELSE 'New' END AS customer_type,
  COUNT(*) FROM customer_behaviour_cleaned
GROUP BY customer_type; 
--no repeat customers observed; all transactions appear to be one-time purchases across 3900 records.

  --Marketing Effectiveness--

-- Discount impact
SELECT Discount_Applied,
      round(AVG(Purchase_Amount_usd),2) AS avg_spend
FROM customer_behaviour_cleaned
GROUP BY Discount_Applied;
---Non-discounted sales (60.13) generate slightly higher revenue than discounted sales (59.28), showing limited impact of discounts on revenue.

--Promo code usage
SELECT Promo_Code_Used, COUNT(*) AS usage_count
FROM customer_behaviour_cleaned
GROUP BY Promo_Code_Used;
--Majority of customers (2,223 out of 3,900) did not use promo codes, while 1,677 customers used promo codes, indicating lower adoption of promotional offers.

--Subscription impact
SELECT Subscription_Status,
      round(AVG(Purchase_Amount_usd),2) AS avg_spend
FROM customer_behaviour_cleaned
GROUP BY Subscription_Status;
--Subscription status shows negligible impact on average spending, with non-subscribed users (59.87) slightly higher than subscribed users (59.49).

--Payment & Shipping Analysis
--Payment method preference
SELECT Payment_Method, COUNT(*) AS usage
FROM customer_behaviour_cleaned
GROUP BY Payment_Method;
---Payment methods evenly split: PayPal (677), Credit Card (671), Cash (670), Venmo (634), Debit (636), Bank Transfer (612)
--No payment method dominance - all within 10% of each other

--Shipping type preference
SELECT Shipping_Type, COUNT(*) AS usage
FROM customer_behaviour_cleaned
GROUP BY Shipping_Type;
--The most shipping type is 'Free shipping' usage(675) and less is '2-Day Shipping' usage(627) 

---High value customers
SELECT Customer_ID,age_category, SUM(Purchase_Amount_usd) AS total_spent
FROM customer_behaviour_cleaned
GROUP BY Customer_ID,age_category
ORDER BY total_spent DESC;


---Customer lifetime value proxy
SELECT Customer_ID,
       SUM(Purchase_Amount_usd) AS CLV,
       COUNT(*) AS total_orders
FROM customer_behaviour_cleaned
GROUP BY Customer_ID;
--Each customer made exactly one purchase (no repeat buyers), so "total spent" equals their single transaction amount, ranging from $100 (top) to $20 (lowest).

--Age vs spending
SELECT age_category,
       round(AVG(Purchase_Amount_usd),2) AS avg_spend
FROM customer_behaviour_cleaned
GROUP BY age_category;
--Insights
--age_category	avg_spend
--Middle Age	$60.08
--Young Adult	$60.65
--Senior	    $59.06
--Adult	        %59.69

--Geographic analysis (Location)
SELECT Location,
       COUNT(*) AS total_orders,
       SUM(Purchase_Amount_usd) AS total_revenue,
       round(AVG(Purchase_Amount_usd),2) AS avg_order_value
FROM customer_behaviour_cleaned
GROUP BY Location
ORDER BY total_revenue DESC;   
--INSIGHTS--
--Montana leads with $5,784 revenue (96 orders), followed by Illinois ($5,617) and California ($5,605) - top 5 states generate 11.8% of total revenue, showing concentration opportunity.

-- Alaska ($67.60 AOV), Pennsylvania ($66.57), and Arizona ($66.55) are premium markets with 15%+ higher average order values - target for high-margin product expansion.

-- Kansas ($3,437), Florida ($3,798), and Hawaii ($3,752) severely underperform despite population size - urgent need for localized marketing campaigns in these states.

-- Order volume varies 52% (96 vs 63 orders) while AOV varies only 24% ($67.60 vs $54.56) - acquisition is the bigger problem than pricing power across markets.

---TOTAL LOCATION = 50
select count(distinct location) as total_location from customer_behaviour_cleaned;

--Size analysis product (preference)
SELECT Size,
       COUNT(*) AS total_orders,
       SUM(Purchase_Amount_usd) AS revenue
FROM customer_behaviour_cleaned
GROUP BY Size
ORDER BY total_orders DESC;
--INSIGHTS
--Medium (M) dominates with 1,755 orders (45% share) generating $105,167 revenue (45% of total) - outperforming Large by 67% and Extra-Large by 309% in order volume.
--Clear size preference decline from M→L→S→XL shows inventory should heavily favor Medium (1,755 units) over Extra-Large (429 units) - a 4:1 ratio to match demand and minimize stockouts/overstock.

---color analysis customer prefernec
SELECT Color, Season,
       COUNT(*) AS orders
FROM customer_behaviour_cleaned
GROUP BY Color, Season
ORDER BY orders DESC;
---INSIGHTS
--Silver-Summer leads with 59 orders, but 100 color-season combinations show extremely fragmented preferences with no clear winner. Orders range narrowly from 59 to 24, meaning customers buy colors evenly across all seasons rather than favoring specific pairings

-----------All queries were executed in Databricks SQL Editor for data extraction, cleaning, and analysis---------- 





