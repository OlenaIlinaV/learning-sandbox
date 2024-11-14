--1--------------------------------------------
	
SELECT
	address_id
	,district
FROM address
;

SELECT
	first_name
	,last_name
	,email
FROM customer
ORDER BY first_name,last_name ASC
;

SELECT *
FROM payment
ORDER BY customer_id ASC, amount DESC
;

SELECT
	first_name
	,last_name
	,email
FROM customer
ORDER BY 2 DESC, 1 DESC
;

SELECT DISTINCT 
	rating
	--,rental_duration
FROM film
;

SELECT DISTINCT
	amount
FROM payment
ORDER BY 1 DESC
LIMIT 10
;

SELECT *
FROM rental
ORDER BY rental_date DESC
LIMIT 10
;

SELECT COUNT(*)
FROM rental
;

SELECT COUNT(DISTINCT first_name)
FROM actor
;

SELECT COUNT(DISTINCT first_name)
FROM customer
;

SELECT DISTINCT
	district
FROM address
;

SELECT DISTINCT
	rental_date
FROM rental
ORDER BY 1 DESC
LIMIT 1
;

SELECT COUNT(film_id)
FROM film
;

SELECT COUNT(DISTINCT last_name)
FROM customer
;

-----------------------------------------------