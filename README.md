# Meal Demand Forecasting - SQL Analysis

## Overview
This project analyzes meal demand using SQL Server to explore sales trends, meal performance, and fulfillment center efficiency. The dataset consists of three tables: `train`, `meal_info`, and `fulfilment_center_info`.

## Dataset Description
### **1. Train Table** (Order Data)
Contains historical meal order details.
- `id` - Unique order ID
- `week` - Week of the order
- `center_id` - Fulfillment center identifier
- `meal_id` - Meal identifier
- `checkout_price` - Final meal price paid by customers
- `base_price` - Original meal price before discounts/promotions
- `emailer_for_promotion` - Whether an email promotion was sent (1 = Yes, 0 = No)
- `homepage_featured` - Whether the meal was featured on the homepage (1 = Yes, 0 = No)
- `num_orders` - Number of orders placed for the meal

### **2. Meal Info Table** (Meal Details)
Contains information about the meal category and cuisine.
- `meal_id` - Meal identifier
- `category` - Type of meal (e.g., Beverages, Snacks, Main Course)
- `cuisine` - Cuisine type (e.g., Indian, Italian, Thai)

### **3. Fulfilment Center Info Table** (Center Details)
Contains details about fulfillment centers.
- `center_id` - Unique identifier for fulfillment centers
- `city_code` - City code where the center is located
- `region_code` - Region code
- `center_type` - Type of fulfillment center
- `op_area` - Operational area of the fulfillment center

## SQL Analysis Queries
### 1. Total Orders per Week
```sql
SELECT week, SUM(num_orders) AS total_orders
FROM train
GROUP BY week
ORDER BY week;
```

### 2. Average Checkout Price by Meal Category
```sql
SELECT m.category, AVG(t.checkout_price) AS avg_checkout_price
FROM train t
JOIN meal_info m ON t.meal_id = m.meal_id
GROUP BY m.category;
```

### 3. Top 5 Most Expensive Meals
```sql
SELECT TOP 5 t.meal_id, t.checkout_price
FROM train t
ORDER BY t.checkout_price DESC;
```

### 4. Orders by Fulfillment Center
```sql
SELECT t.center_id, SUM(t.num_orders) AS total_orders
FROM train t
GROUP BY t.center_id;
```

### 5. Meal Orders by City
```sql
SELECT f.city_code, t.meal_id, SUM(t.num_orders) AS total_orders
FROM train t
JOIN fulfilment_center_info f ON t.center_id = f.center_id
GROUP BY f.city_code, t.meal_id
ORDER BY f.city_code, total_orders DESC;
```

### 6. Total Revenue by Week
```sql
SELECT week, SUM(t.num_orders * t.checkout_price) AS total_revenue
FROM train t
GROUP BY week;
```

## How to Run the Analysis
1. **Setup Database:** Import the dataset into SQL Server.
2. **Execute Queries:** Run the provided SQL queries to analyze trends.
3. **Interpret Results:** Use the query outputs to draw insights into meal demand patterns.

## Future Enhancements
- Integrate Power BI for interactive visualizations.
- Perform machine learning-based demand forecasting.
- Automate SQL queries using stored procedures.

## Contributing
Feel free to contribute by improving queries or adding new analyses. Fork the repository and submit a pull request!


