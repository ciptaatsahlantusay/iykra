-- customer wants to know the films about “astronauts”. How many recommendations could you give for him
select count(*) jumlah from film_list fl 
where lower(description)  like '%astronauts%';

-- how many films have a rating of “R” and a replacement cost between $5 and $15
select count(*) jumlah from film f
where rating = 'R'
and replacement_cost between 5 and 15;

-- We have two staff members with staff IDs 1 and 2. We want to give a bonus to the staff member that handled the most payments.
-- How many payments did each staff member handle? And how much was the total amount processed by each staff member
select 
concat(s.first_name,' ',s.last_name) nama, b.staff_id, b.jumlah, b.nominal
from staff s 
left join
 ( select p.staff_id, count(*) jumlah, sum(amount) nominal 
   from payment p 
   group by p.staff_id
) b
on s.staff_id = b.staff_id
order by nominal desc;

--Corporate headquarters is auditing the store! They want to know the average replacement cost of movies by rating!
select rating, avg(replacement_cost) avg_repl_cost from film f
group by rating;

--	We want to send coupons to the 5 customers who have spent the most amount of money. 
--  Get the customer name, email and their spent amount
select  concat(c.first_name,c.last_name) nama,c.email, sum(amount) jumlah 
from payment p 
left join 
    customer c
on p.customer_id = c.customer_id
group by c.customer_id,c.first_name,c.last_name
order by jumlah desc
limit 5;

-- We want to audit our stock of films in all of our stores. How many copies of each movie in each store, do we have
select 
a.store_id,f.title,a.jumlah
from (
	select store_id, film_id, count(*) jumlah
	from inventory i 
	group by store_id, film_id
	order by store_id
) a
left join 
    film f 
on f.film_id = a.film_id;

-- We want to know what customers are eligible for our platinum credit card. 
-- The requirements are that the customer has at least a total of 40 transaction payments. 
-- Get the customer name, email who are eligible for the credit card
select  concat(c.first_name,c.last_name) nama,c.email, count(*) transaksi 
from payment p 
left join 
    customer c
on p.customer_id = c.customer_id
group by c.customer_id,c.first_name,c.last_name
having count(*) >= 40
order by transaksi desc;