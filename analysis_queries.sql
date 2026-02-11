-- Retrieve the total number if orders placed  
SELECT 
    COUNT(order_id) AS total_orders
FROM
    orders;-- Calculate the total revenue generated from pizza sale
SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS total_sale
FROM
    order_details
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id
-- Identify the highest- priced pizza
SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;
-- Identify the most common pizza size ordered 
SELECT 
    pizzas.size,
    COUNT(order_details.order_details_id) AS order_Count
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY order_Count DESC
LIMIT 1;-- List the top 5 most ordered pizza
--  types along with their quantities  
SELECT 
    pizza_types.name, SUM(order_details.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.name
ORDER BY quantity DESC
LIMIT 5;-- Intermediate  question
-- join the necessary tables to find the total quantity of each pizza category ordered
SELECT 
    pizza_types.category,
    SUM(order_details.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY quantity DESC
LIMIT 1;
-- Determine the distribution of the orders by hour of the day

SELECT 
    HOUR(order_time) AS hour, COUNT(order_id) AS order_count
FROM
    orders
GROUP BY hour;

-- join the relevant tables to find the total quantity of the each pizza cateogry ordered
SELECT 
    category, COUNT(name)
FROM
    pizza_types
GROUP BY category;

-- Group the orderes by the date and calculate the average number of pizzas ordered per day
SELECT 
    ROUND(AVG(quantity), 0) as avg_pizza_Ordered_per_day
FROM
    (SELECT 
        orders.order_date, SUM(order_details.quantity) AS quantity
    FROM
        orders
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY orders.order_date) AS order_quantity; 

-- determine the top 3 most ordered pizza types based on the revenue 
select pizza_types.name,
sum(order_details.quantity * pizzas.price) as revenue 
from pizza_types join pizzas
on pizzas.pizza_type_id = pizza_types.pizza_type_id 
join order_details on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.name order by revenue  desc limit 3;

