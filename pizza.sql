-- PIZZA_TYPES TABLE

  	drop table if exists pizza_types;
	
	create table if not exists pizza_types(
		pizza_type_id	varchar(30) primary key,
		name	varchar(42),
		category	varchar(20),
		ingredients	varchar(100)
	);

	copy pizza_types
	from 'D:\Data analysis\PostgreSql\Practice data\pizza_sales\pizza_types.csv'
	with(
		format csv,
		header,
		null ''
	);

	select * from pizza_types;

-- PIZZA TABLE

	drop table if exists pizza;
	
	create table if not exists pizza(
		pizza_id	varchar(30) primary key,
		pizza_type_id	varchar(30),
		size	varchar(3),
		price	numeric(4,2),
		foreign key(pizza_type_id) references pizza_types(pizza_type_id)
	);

	copy pizza
	from 'D:\Data analysis\PostgreSql\Practice data\pizza_sales\pizzas.csv'
	with(
		format csv,
		delimiter ',',
		header,
		null ''
	);

	select * from pizza;

-- ORDERS TABLE

  	drop table if exists orders;
	
	create table if not exists orders(
		order_id	serial primary key,
		date	date,
		time	time
	);
	
	copy orders
	from 'D:\Data analysis\PostgreSql\Practice data\pizza_sales\orders.csv'
	with(
		format csv,
		delimiter ',',
		header,
		null ''
	);
	
	select * from orders;

	
-- ORDER_DETAILS TABLE 

	drop table if exists order_details;
	
	create table if not exists order_details(
		order_details_id	serial primary key,
	    order_id	int ,
		pizza_id	varchar(40),
		quantity	smallint,
		foreign key (order_id) references orders(order_id),
		foreign key (pizza_id) references pizza(pizza_id)
	);
	
	copy order_details
	from 'D:\Data analysis\PostgreSql\Practice data\pizza_sales\order_details.csv'
	with(
		format csv,
		delimiter ',',
		header ,
		null ''
	);
	
	select * from order_details;

-- Basic:
-- Retrieve the total number of orders placed.

	select count(*) from order_details;
	
-- Calculate the total revenue generated from pizza sales.

	select sum(price * quantity) as total_revenue 
	from pizza p
	join order_details od
	on p.pizza_id = od.pizza_id;
	
-- Identify the highest-priced pizza.

	select *
	from pizza
	order by price desc
	limit 1;
	
-- Identify the most common pizza size ordered.

	select p.size , sum(od.quantity) as total_quantity
	from pizza p
	join order_details od
	on p.pizza_id = od.pizza_id
	group by p.size
	order by total_quantity desc
	limit 1;

-- List the top 5 most ordered pizza types along with their quantities.

	select pt.name ,sum(od.quantity) as quantity
	from order_details od
	join pizza p
	on od.pizza_id = p.pizza_id
	join pizza_types pt 
	on p.pizza_type_id = pt.pizza_type_id
	group by name
	order by quantity desc
	limit 5;
	
-- Intermediate:
-- Join the necessary tables to find the total quantity of each pizza category ordered.

	select pt.category , sum(od.quantity) as quantity
	from order_details od
	join pizza p
	on od.pizza_id = p.pizza_id
	join pizza_types pt
	on p.pizza_type_id = pt.pizza_type_id
	group by pt.category
	order by quantity desc;
	
-- Determine the distribution of orders by hour of the day.

	select extract(hour from time ) as hour,
			count(order_id) as total_orders 
	from orders
	group by hour
	order by hour;

-- Join relevant tables to find the category-wise distribution of pizzas.
  
	select pt.category , count(*) as total_pizzas
	from pizza_types pt
	group by pt.category
	order by total_pizzas desc;
	
	
-- Group the orders by date and calculate the average number of pizzas ordered per day.

	with daily_order as (
		select date  as day , sum(od.quantity) 
		from orders o
		join order_details od
		on o.order_id = od.order_id
		group by day
		order by day
	)
	select  round(avg(sum),2) as per_day_average 
	from daily_order

-- Determine the top 3 most ordered pizza types based on revenue.
  
	select pt.name , sum(p.price * od.quantity) as revenue
	from order_details od
	join pizza p
	on od.pizza_id = p.pizza_id
	join pizza_types pt
	on p.pizza_type_id = pt.pizza_type_id
	group by pt.name
	order by revenue desc
	limit 3 ; 

-- Advanced:
-- Calculate the percentage contribution of each pizza type to total revenue.

	with tol_revenue as (
		select pt.name , sum(p.price * od.quantity) as revenue
		from order_details od
		join pizza p
		on od.pizza_id = p.pizza_id
		join pizza_types pt
		on p.pizza_type_id = pt.pizza_type_id
		group by pt.name
		order by revenue desc
	)
	select name , round((revenue * 100.0) / sum(revenue) over() ,2) || '%' as total_rev_in_percentage
	from tol_revenue
	order by total_rev_in_percentage;
	
-- Analyze the cumulative revenue generated over time.

 	with revenue as ( 
	   select o.date , sum(p.price * od.quantity) as revenue
	   from orders o
	   join order_details od
	   on o.order_id = od.order_id
	   join pizza p
	   on od.pizza_id = p.pizza_id 
	   group by date
	   order by date
	)
	select * , sum(revenue) over(order by date) as cumulative_rev
	from revenue;
 
-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.

	with pizza_cate as (
		select pt.name , pt.category ,
		   sum(p.price * od.quantity) as revenue,
		   rank() over (partition by  pt.category order by  sum(p.price * od.quantity))
		from order_details od
		join pizza p
		on od.pizza_id = p.pizza_id
		join pizza_types pt
		on p.pizza_type_id = pt.pizza_type_id
		group by pt.name ,pt.category
		order by revenue desc
	)
	select name , category , revenue
	from pizza_cate
	where rank >= 3
	order by revenue desc;

	