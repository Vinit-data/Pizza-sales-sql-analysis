-- Retrive the total number of orders placed
Select count(order_id) as total_orders from orders;

-- What is the total revenue generated from pizza sales?
select round(sum(order_details.quantity * pizzas.price),2) as total_sales
from order_details join pizzas
on pizzas.pizza_id=order_details.pizza_id	


-- Indentify higest price pizza
select pizzatypess.name, pizzas.price
from pizzatypess join pizzas
on pizzatypess.﻿pizza_type_id=pizzas.pizza_type_id
order by pizzas.price desc limit 1;


-- Identify the most Common pizza size ordered
 select pizzas.size , count(order_details.order_details_id) as order_count
from pizzas join order_details
on pizzas.pizza_id=order_details.pizza_id
group by pizzas.size order by order_count desc
;
 
-- List the top 5 most ordered pizza types along with their quantities.

select pizzatypess.name, 
sum(order_details.quantity) as quan
from order_details 
join pizzas  on pizzas.pizza_id = order_details.pizza_id
join pizzatypess on pizzatypess.﻿pizza_type_id=pizzas.pizza_type_id
group by pizzatypess.name order by quan desc limit 5
;
