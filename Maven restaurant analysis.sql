use restaurant_db;

#-----------Objective 1----------------

-- 1. View the menu_items table.--

select * from menu_items;

-- 2. find the number of items on the menu.--

select count(*) as no_itmes from menu_items;

-- 3.-- what are the least and most expensive items on the menu?
select * from menu_items
order by price ;

select * from menu_items
order by price desc;

-- 4. -- How many italian dishes are on the menu?

select * from menu_items
where category='italian';

select count(*) as no_of_italiandishes from menu_items
where category='italian';

-- 5.--what are the least and most expensive italian dishes on the menu?

select * from menu_items
where category = 'Italian'
order by price;

select * from menu_items
where category = 'Italian'
order by price desc;

-- 6.-- how many dishes are in each category?

select  category, count(menu_item_id) as num_dishes
from menu_items
group by category;

-- 7. --What are the average dish price within each category?

select  category, avg(price)as avg_price, count(menu_item_id) as num_dishes
from menu_items
group by category;

-- ---------------- OBJECTIVE 2 --------------------
-- -----------EXPLORE THE ORDERS TABLE---

-- 1. --  veiw the order detail table--
    select * from order_details;

-- 2. --  What is the date range of the table--
select * from order_details
order by order_date;

select min(order_date), max(order_date) from order_details;

-- 3. --  How many orders were made within this date range?--

select count(distinct order_id)

from order_details

;

-- 4. --  How many items  were ordered within this date range?--
select count(*) from order_details;


-- 5. --  Which order has the most number of items? --
select order_id, count(item_id) as num_item
from order_details
group by order_id
order by num_item desc
;

-- 6. --how many orders had  more than 12 items ?
select order_id, count(item_id) as num_item
from order_details
group by order_id
having num_item > 12
limit 10;
-- -------------------
select count(*)  from
(select order_id, count(item_id) as num_item
from order_details
group by order_id
having num_item > 12) as num_of_orders
;

-- --------------OBJECTIVE 3 --------------
# ----------analyze CUSTOMERS BEHAVIOR -

-- 1. -- combine the menu_itmes and order_details table into a single table.
select * from menu_items;
select * from order_details;

select * 
from order_details od left join menu_items mi
    on od.item_id = mi.menu_item_id;


-- 2. -- What are the least and most ordered items? what categories were they in?
select item_name, category, count(order_details_id) as num_of_purchases
from order_details od left join menu_items mi
    on od.item_id = mi.menu_item_id
group by item_name, category
order by num_of_purchases desc
limit 15;

-- 3. -- what are the top 5 orders that spent the most money by category?

select order_id, sum(price) as total_spend
from order_details od left join menu_items mi
    on od.item_id = mi.menu_item_id
group by order_id
order by total_spend desc
limit 5;



-- 4. -- view the details of the highest spent order. what insights can you gather from this?

select category, count(item_id) as num_items
from order_details od left join menu_items mi
    on od.item_id = mi.menu_item_id
where order_id = 440
group by category
order by num_items desc;

-- 5. -- view the details of the top 5 highest spent order. what insights can you gather from this?

select order_id, category, count(item_id) as num_items
from order_details od left join menu_items mi
    on od.item_id = mi.menu_item_id
where order_id in ( 440,2075,1957,330,2675)
group by order_id,category
order by num_items desc
limit 5;
    
