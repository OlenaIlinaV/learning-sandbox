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

--2----------------------------------------------

SELECT COUNT(*)
FROM payment
WHERE amount = 0
;

SELECT 
	first_name
	,last_name
FROM customer
WHERE first_name = 'ADAM'
;

SELECT COUNT(*)
FROM payment
WHERE customer_id = '100'
;

SELECT
	last_name
FROM public.customer
WHERE first_name = 'ERICA'
;

SELECT *
FROM payment
WHERE 1=1
	AND amount > 10.99
	AND amount is not null
;

SELECT count(*)
FROM public.rental
WHERE return_date is null
;

SELECT
	payment_id
	,amount
FROM public.payment
WHERE amount <= 2
--ORDER BY 2
;


SELECT *
FROM payment
WHERE 1=1
	AND (amount = 10.99 OR amount = 9.99)
	AND customer_id = 426
;


SELECT *
FROM payment
WHERE 1=1
	--AND (amount = 10.99 OR amount = 9.99)
	AND amount = 9.99
	AND (customer_id = 30 OR customer_id = 31)
;

SELECT *
FROM payment
WHERE 1=1
	--AND customer_id IN (322, 346, 354)
	AND (customer_id = 322 OR customer_id = 346 OR customer_id = 354)
	AND (amount < 2 OR amount > 10)
	--AND amount > 10
ORDER BY customer_id ASC, amount DESC
;

ALTER DATABASE greencycles SET timezone TO 'Europe/Berlin';

SELECT *
FROM rental
--WHERE amount BETWEEN 1.99 AND 2.99
WHERE rental_date BETWEEN '2005-05-24 0:00' AND '2005-05-26 23:00'
;

SELECT COUNT(*)
FROM public.payment
WHERE 1=1
	AND payment_date BETWEEN '2020-01-26 0:00' AND '2020-01-27 23:59'
	AND amount BETWEEN 1.99 AND 3.99
;

SELECT *
FROM public.customer
WHERE customer_id IN (123,212,323,243,353,432)
;

SELECT *
FROM payment
WHERE 1=1
	AND customer_id IN (12,25,67,93,124,234)
	AND amount IN (4.99, 7.99, 9.99)
	AND payment_date BETWEEN '2020-01-01' AND '2020-01-31 23:59'
ORDER BY payment_date ASC
;

SELECT *
FROM public.film
WHERE description LIKE '%Drama%'
	AND title LIKE '_T%'
;

SELECT COUNT(*)
FROM public.film
WHERE description ILIKE '%Documentary%'
;

SELECT *
	--COUNT(*)
FROM public.customer
WHERE 1=1
	AND first_name LIKE '___'
	AND (last_name LIKE '%X' OR last_name LIKE '%Y')
;

/*kdhfklashvkdf
s,djfbhkjshdfk*/


SELECT last_name name
FROM public.customer
;

--FINAL challenges

SELECT *
	--COUNT(*) AS no_of_movies --14
FROM public.film
WHERE description LIKE '%Saga%'
	AND (title LIKE 'A%' OR title LIKE '%R')
;

SELECT *
FROM public.customer
WHERE first_name ILIKE '%ER%' AND first_name ILIKE '_A%'
ORDER BY last_name DESC
; 

SELECT *
	--COUNT(*) --27
FROM public.payment
WHERE 1=1
	AND (amount = 0 OR amount BETWEEN 3.99 AND 7.99)
	AND payment_date BETWEEN '2020-05-01' AND '2020-05-02'
;

--3-------------------------------------------------------