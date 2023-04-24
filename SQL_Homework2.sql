--Week 5 - Wednesday Questions


--1. List all customers who live in Texas (use JOINs)
SELECT first_name, Last_name, district
FROM customer
INNER JOIN address
ON address.address_id = customer.address_id
WHERE district = 'Texas';
--ANSWER: Jennifer, Kim, Richard, Bryan, Ian

--2. Get all payments above $6.99 with the Customer's Full Name
SELECT payment.amount, first_name, last_name
FROM customer 
INNER JOIN payment
ON payment.customer_id = customer.customer_id
WHERE payment.amount > 6.99
ORDER by amount desc;
--ANSWER: Total 27 payments

--3. Show all customers names who have made payments over $175(use subqueries)
SELECT first_name, last_name
FROM customer 
WHERE customer_id in (
	SELECT customer_id 
	FROM payment
	WHERE amount> 175
);
--ANSWER: Mary SMith and Douglas Graf

--4. List all customers that live in Nepal (use the city table)
SELECT first_name, last_name
FROM customer 
WHERE address_id in (
	SELECT city_id
	FROM address 
	WHERE city_id in (
		SELECT city_id
		FROM city 
		WHERE country_id = 66)
);
--ANSWER: Jane Bennett

--5. Which staff member had the most transactions?
SELECT staff_id, count(payment_id)
FROM payment
GROUP by staff_id 
ORDER by count(payment_id) desc;
--ANSWER: Staff member 2

--find name of best seller
SELECT first_name, last_name, staff_id
FROM staff
WHERE staff_id = 2;
--ANSWER: Jon Stephens

--6. How many movies of each rating are there?
SELECT rating, count(film_id) 
FROM film
GROUP by rating 
ORDER by count(film_id) desc;
--ANSWER: PG-13 223, NC-17 209, R 196, PG 194, G 178

--7.Show all customers who have made a single payment above $6.99 (Use Subqueries)
SELECT customer_id, first_name, last_name
FROM customer 
WHERE customer_id in (
	SELECT customer_id
	FROM payment 
	WHERE amount > 6.99
	GROUP by customer_id 
	having count(payment_id) = 1
);
--ANSWER: Douglas Graf, Alvin Deloach and Alfredo Mcadams
 	
--8. How many free rentals did our stores give away?
SELECT count(rental_id)
FROM rental
WHERE rental_id in(
	SELECT rental.rental_id
	FROM rental 
	LEFT JOIN payment 
	ON payment.rental_id = rental.rental_id 
	WHERE payment.rental_id is NULL
);
--ANSWER: 1,452 free rentals