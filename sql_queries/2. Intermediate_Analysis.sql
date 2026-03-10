-- Join the necessary tables to find the total quantity of each pizza Category ordered

select sum(order_details.quantity) as quan,
pizzatypess.category as cat
from pizzatypess
join pizzas on pizzas.pizza_type_id= pizzatypess.﻿pizza_type_id
join order_details on order_details.pizza_id= pizzas.pizza_id
group by cat order by quan desc limit 5
;

-- Determine the distribution of orders by hour of the day

SELECT hour(orders.order_time) as hr, 
count(orders.order_id) FROM orders
group by hr
;


-- Join relevant tables to find the category-wise distribution of pizzas.。
select category as cc, 
count(name) as cn
from pizzatypess
group by cc
;

-- Group the orders by date and calculate the average number of pizzas ordered per day

select round(avg(oq),0) from
(select	orders.order_date as od, sum(order_details.quantity) as oq
from orders join order_details
on orders.order_id=order_details.order_id
group by od) as order_quantity

-- Determine the top3 most ordered pizza types based on revenue.
select pizzatypess.name as nam,
sum(order_details.quantity* pizzas.price) as revenue
from pizzatypess
JOIN pizzas  ON pizzas.pizza_type_id = pizzatypess.﻿pizza_type_id
JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
group by nam order by revenue desc limit 3 ;
