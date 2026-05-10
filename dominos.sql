B1. Retrieve the total number of orders placed.

Create View B1 As
Select Count(Distinct Order_Id) as Orders 
From Order_Details;

Select * From B1

B2. Calculate the total revenue generated from pizza sales.

Create View B2 As
Select 
Sum(Order_Details.quantity * pizzas.price) as Total_Sales
From Order_Details Join pizzas
On pizzas.pizza_id = order_details.pizza_id

Select * From B2

B3. Identify the highest-priced pizza.

Create View B3 As
Select pizza_types.name, pizzas.price
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
order by pizzas.price desc limit 1;

Select * From B3

B4. Identify the most common pizza size ordered.
Create View B4 As
SELECT pizzas.size, Count(order_details.order_details_id) AS total_ordered
FROM order_details JOIN pizzas
ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizzas.size
ORDER BY total_ordered DESC
LIMIT 1;

Select * From B4

B5. List the top 5 most ordered pizza types along with their quantities.

Create View B5 As
Select pizza_types.name,
sum(order_details.quantity) as total_quantity
From pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
Group by pizza_types.name
Order by total_quantity desc
Limit 5;

Select * From B5

I1. Join the necessary tables to find the total quantity of each pizza category ordered.

Create View I1 As
Select pizza_types.category,
sum(order_details.quantity) as total_quantity
From pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
Join order_details
on order_details.pizza_id = pizzas.pizza_id
Group By pizza_types.category
Order By total_quantity

Select * From I1

I2. Determine the distribution of orders by hour of the day.

Create View I2 As
Select Extract(hour from order_time) as order_hour, 
count(order_id)
From orders
Group By order_hour
Order By order_hour

Select * From I2

I3. Join relevant tables to find the category-wise distribution of pizzas.

Create View I3 As
Select Category, Count(name)
From pizza_types
Group By Category

Select * From I3

I4. Group the orders by date and calculate the average number of pizzas ordered per day.

Create View II4 As
Select round(Avg(order_quantity),2) from
(Select orders.order_date,
Sum(order_details.quantity) as order_quantity
From orders join order_details
on orders.order_id = order_details.order_id
Group By orders.order_date
Order By orders.order_date)

Select * From II4

I5. Determine the top 3 most ordered pizza types based on revenue.

Create View I5 As
Select pizza_types.name,
sum(order_details.quantity * pizzas.price) as revenue
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
Group by pizza_types.name
Order by revenue desc
Limit 3

Select * from I5

A1. Calculate the percentage contribution of each pizza type to total revenue.

Create View A1 As
SELECT pizza_types.category,
ROUND(
(SUM(order_details.quantity * pizzas.price) * 100.0) /
(SELECT SUM(order_details.quantity * pizzas.price)
FROM order_details
JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id
), 2) AS percentage_contribution
FROM pizza_types
JOIN 
pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN 
order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY percentage_contribution DESC;

Select * From A1


A2. Analyze the cumulative revenue generated over time.

Create View A2 as
Select order_date, revenue,
Sum(revenue) over (order by order_date) as cum_revenue
from
(select orders.order_date,
sum(order_details.quantity * pizzas.price) as revenue
from order_details 
join pizzas
on order_details.pizza_id = pizzas.pizza_id
join orders
on orders.order_id = order_details.order_id
Group by orders.order_date) as sales;

Select * from A2


A3. Determine the top 3 most ordered pizza types based on revenue for each pizza category.

Create View A3 As
Select category, name, revenue from
(Select category, name, revenue,
rank() over (partition by category order by revenue desc) as rn
from
(Select pizza_types.category, pizza_types.name,
Sum(order_details.quantity * pizzas.price) as revenue
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
Group by pizza_types.category, pizza_types.name) as a) as b
Where rn <=3;

Select * From A3




