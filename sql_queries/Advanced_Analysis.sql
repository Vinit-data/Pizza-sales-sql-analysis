-- Calculate the percentage contribution of each pizza type to total revenue.
select pizzatypess.category as cat,
(sum(order_details.quantity* pizzas.price)/  (select sum(order_details.quantity * pizzas.price) as total_sales
from order_details join pizzas
on pizzas.pizza_id=order_details.pizza_id))*100 as revenue
from pizzatypess
JOIN pizzas  ON pizzas.pizza_type_id = pizzatypess.﻿pizza_type_id
JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
group by cat order by revenue 
;

-- Analyze the cumulative revenue generated over time.

select dt, 
sum(revenue) over(order by dt ) as Cum_sales
from 
(SELECT 
    orders.order_date as dt,
    SUM(order_details.quantity * pizzas.price) AS revenue
FROM order_details
JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id
JOIN orders ON orders.order_id = order_details.order_id
GROUP BY dt
) as sales;


-- Determine the top 3 most ordered pizza types  based on revenue for each pizza category. 
select name, category, revenue from
(select category, name, revenue, 
rank() over (partition by category order by revenue desc) as RR
from 
(select pizzatypess.category, pizzatypess.name, 
sum(order_details.quantity*pizzas.price) as revenue
from pizzatypess 
join pizzas on pizzatypess.﻿pizza_type_id=pizzas.pizza_type_id
join order_details on order_details.pizza_id=pizzas.pizza_id
group by pizzatypess.category, pizzatypess.name
) as sales) as ab
 where RR<=3;
