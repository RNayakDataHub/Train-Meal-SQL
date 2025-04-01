select top 50 * from train
select * from meal_info
select * from fulfilment_center_info

SELECT name 
FROM sys.columns 
WHERE object_id = OBJECT_ID('fulfilment_center_info');

--What is the total number of orders (num_orders) for each week?
select sum(num_orders) as Total_Orders, week from train
group by week
order by week asc

--What is the average checkout price (checkout_price) for each meal category?
select category, avg(checkout_price) as Average_Chkout_price from train t
join meal_info m
on m.meal_id=t.meal_id
group by category

--Which are the top 5 most expensive meals based on the checkout_price?
SELECT TOP 5 meal_id, checkout_price
FROM train 
ORDER BY checkout_price DESC;

-- What is the total number of orders (num_orders) by each fulfillment center (center_id)?
select sum(num_orders) as Total_Orders, center_id from train
group by center_id
order by center_id asc


--What is the total number of orders for each meal (meal_id) by city (city_code)?
select t.meal_id, f.city_code, sum(t.num_orders) as Total_Orders from train t
join fulfilment_center_info f
on t.center_id=f.center_id
group by f.city_code, t.meal_id
order by f.city_code, Total_Orders asc

--What is the total revenue for each week, calculated as num_orders * checkout_price?
select week, sum(num_orders * checkout_price) as Total_Revenue from train
group by week
order by week asc

--Which 3 regions (region_code) have the highest number of orders across all centers?
select top 3 f.region_code, sum(t.num_orders) as Total_Orders from train t
join fulfilment_center_info f
on f.center_id=t.center_id
group by f.region_code
order by Total_Orders desc

-- Which meals (meal_id) had the highest number of promotions, based on emailer_for_promotion (assuming it's a binary field: 1 for promoted)?
select meal_id, sum(cast(emailer_for_promotion as int)) as Total_Promotions from train
group by meal_id
order by Total_Promotions desc --Meal ID- 1962

SELECT meal_id, COUNT(emailer_for_promotion) AS Total_Promotions
FROM train t
WHERE emailer_for_promotion = 1
GROUP BY meal_id
ORDER BY Total_Promotions DESC;

--What is the average base_price for each cuisine type (cuisine)?
select m.cuisine, avg(t.base_price) Average_Price from train t
join meal_info m
on m.meal_id=t.meal_id
group by cuisine
order by Average_Price desc

--What is the total number of orders for featured meals (homepage_featured = 1) by fulfillment center (center_id)?
select center_id, sum(num_orders) as Total_orders from train
where homepage_featured=1
group by center_id
order by Total_orders desc
