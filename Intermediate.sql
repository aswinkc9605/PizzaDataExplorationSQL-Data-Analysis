-- Join the necessary tables to find the total quantity of each pizza category ordered.
select pizza_types.category,count(order_details.quantity) as total_quantity from order_details 
join pizzas on order_details.pizza_id=pizzas.pizza_id 
join pizza_types on pizza_types.pizza_type_id=pizzas.pizza_type_id group by pizza_types.category
order by total_quantity desc

-- Determine the distribution of orders by hour of the day.
select hour(order_time) as order_hour,count(order_id) from orders 
group by order_hour order by order_hour 

-- Join relevant tables to find the category-wise distribution of pizzas.
select category,count(name) from pizza_types group  by category

-- Group the orders by date and calculate the average number of pizzas ordered per day.
select round(avg(total_quantity),0) as avg_pizza_per_day from (select orders.order_date,sum(order_details.quantity) as total_quantity from orders 
join order_details on orders.order_id=order_details.order_id group by order_date) as order_quantity

-- Determine the top 3 most ordered pizza types based on revenue.
select pizza_types.name ,sum(order_details.quantity*pizzas.price) as revenue from pizza_types 
join pizzas on pizza_types.pizza_type_id=pizzas.pizza_type_id 
join order_details on order_details.pizza_id=pizzas.pizza_id 
group by pizza_types.name order by revenue desc limit 3
