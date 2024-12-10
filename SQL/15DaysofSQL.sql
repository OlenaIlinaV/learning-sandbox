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

SELECT 
	customer_id AS Customer
	,SUM(amount) Sum
	,ROUND(AVG(amount),2) Avg
	,MIN(amount) Min
FROM public.payment
GROUP BY customer_id
ORDER BY customer_id
;

SELECT
	MIN(replacement_cost) min
	,MAX(replacement_cost) max
	,ROUND(AVG(replacement_cost),2) avg 
	,SUM(replacement_cost) sum
FROM public.film
;

SELECT
	staff_id
	,COUNT(*)
	,SUM(amount)
FROM public.payment
GROUP BY staff_id
ORDER BY SUM(amount) DESC
--LIMIT 1
;

SELECT
	staff_id
	,COUNT(*)
	,SUM(amount)
FROM public.payment
WHERE amount != 0
GROUP BY staff_id
ORDER BY SUM(amount) DESC
--LIMIT 1
;

SELECT
	staff_id
	,customer_id
	,COUNT(*)
	,SUM(amount)
FROM public.payment
GROUP BY staff_id, customer_id
ORDER BY COUNT(*) DESC
;

SELECT
	DATE(payment_date)
	,staff_id
	,SUM(amount)
	,COUNT(*)
FROM public.payment
GROUP BY staff_id, DATE(payment_date)
ORDER BY SUM(amount) DESC
;

SELECT
	DATE(payment_date)
	,staff_id
	,SUM(amount)
	,COUNT(*)
FROM public.payment
WHERE amount != 0
GROUP BY staff_id, DATE(payment_date)
HAVING COUNT(*) > 300
ORDER BY SUM(amount) DESC
;

select
    City
    ,AVG(Amount) AS AverageAmount
from Sales
group by City
having AVG(Amount) > 150.00 and COUNT(TransactionID) > 2
order by AverageAmount DESC
;

SELECT
	customer_id
	,DATE(payment_date)
	,ROUND(AVG(amount),2) AS AVG_amount
FROM public.payment
WHERE DATE(payment_date) BETWEEN '2020-04-28' AND '2020-04-30 23:59'
GROUP BY customer_id, DATE(payment_date)
HAVING COUNT(payment_id) > 1
ORDER BY AVG_amount DESC
;

--4-------------------------------------------------------
--FUNCTIONS
--UPPER, LOWER, LENGHT

SELECT
	email
	,UPPER(email) AS email_upper
	,LOWER(email) AS email_lower
	,LENGTH(email)
FROM public.customer
WHERE LENGTH(email) < 30
;

select
    review_id
    ,review_text
    ,LENGTH(review_text) AS review_length
from customer_reviews
where product_id = 101 AND review_text LIKE '%great%'
order by review_length ASC
;

SELECT
	customer_id
	,LOWER(first_name) AS lower_first_name
	,LOWER(last_name) AS lower_last_name
	,LOWER(email) AS llower_email
	,LENGTH(first_name) AS length_first_name
	,LENGTH(last_name) AS length_last_name
FROM public.customer
WHERE LENGTH(first_name) > 10 OR LENGTH(last_name) > 10
;

--LEFT, RIGHT

SELECT
	LEFT(first_name,2)
	,RIGHT(first_name,2)
	,first_name
	,RIGHT(LEFT(first_name,2),1)
FROM customer
;

SELECT
	email
	,RIGHT(email,5) AS last_5
	,LEFT(RIGHT(email,4),1) AS dot
FROM public.customer
;

-- CONCATENATE ||

SELECT 
	first_name
	,last_name
	,LEFT(first_name,1) || '.' ||LEFT(last_name,1) || '.' AS initials
FROM public.customer
;

select
    name || ' - ' || category || ': $' || price AS product_summary
from products
order by name ASC
;

SELECT
	email
	,LEFT(email,1) || '***@sakilacustomer.org' AS anonymized_email
FROM public.customer
;

-- POSITION

SELECT
	POSITION('@' IN email)
	,LEFT(email, POSITION('@' IN email)-1)
	,POSITION(first_name IN email)
	,POSITION(last_name IN email)
	,email
FROM public.customer
;

SELECT
	email
	,last_name
	,last_name || ', ' || LEFT(email,POSITION('.' IN email)-1) AS name_sername
FROM public.customer
;

-- SUBSTRING

SELECT
	email
	,SUBSTRING(email from 2)
	,SUBSTRING(email from 2 for 6)
	,SUBSTRING(email from POSITION('.' IN email)+1 for LENGTH(last_name))
	,SUBSTRING(email from POSITION('.' IN email)+1 for (POSITION('@' IN email)-POSITION('.' IN email)-1))
	,POSITION('@' IN email)
FROM public.customer
;

--Challenge
SELECT
	email
	,LEFT(email, 1) || '***' || LEFT(SUBSTRING(email from POSITION('.' IN email)),2) || '***' || SUBSTRING(email from POSITION('@' IN email)+1) AS anonymized_1
	,'***' || RIGHT(SUBSTRING(email from 1 for POSITION('.' IN email)-1),1) || LEFT(SUBSTRING(email from POSITION('.' IN email)),2) || '***' || SUBSTRING(email from POSITION('@' IN email)+1) AS anonymized_2
	,'***' || SUBSTRING(email from POSITION('.' IN email) -1 for 3 ) || '***' || SUBSTRING(email from POSITION('@' IN email)) AS anonymized_LECTOR
FROM public.customer
;

-- EXTRACT used to EXTRACT parts of timestamp/date

SELECT
	EXTRACT(day from rental_date)
	,COUNT(*)
FROM public.rental
GROUP BY EXTRACT(day from rental_date)
ORDER BY COUNT(*) DESC
;

--Challenge
SELECT
	EXTRACT(month from payment_date) AS Month
	,SUM(amount)
FROM public.payment
GROUP BY EXTRACT(month from payment_date)
ORDER BY SUM(amount) DESC
;

SELECT
	EXTRACT(DOW from payment_date) AS Day_of_week
	,SUM(amount) AS total_amount
FROM public.payment
GROUP BY Day_of_week
ORDER BY total_amount DESC
;

SELECT
	EXTRACT(week from payment_date) AS Week
	,customer_id
	,SUM(amount) AS total_amount
FROM public.payment
GROUP BY Week, customer_id
--HAVING EXTRACT(week from payment_date) = 18
ORDER BY total_amount DESC
;

-- TO CHAR - get custom formats timestamp/date/numbers
-- output is text

SELECT
	*
	,EXTRACT(month from payment_date) AS Week
	,customer_id
	,TO_CHAR(payment_date, 'Day')
	,TO_CHAR(payment_date, 'DY, Month')
FROM public.payment
;


--Challenge
SELECT
	SUM(amount) AS total_amount
	,TO_CHAR(payment_date, ' DY, DD/MM/YYYY') -- DY скорочена назва днів тижнів
FROM public.payment
GROUP BY 2
ORDER BY total_amount
;

SELECT
	SUM(amount) AS total_amount
	,TO_CHAR(payment_date, 'Mon, YYYY') AS month_year -- MON скорочена назва місяця
FROM public.payment
GROUP BY 2
ORDER BY total_amount
;

SELECT
	SUM(amount) AS total_amount
	--,TO_CHAR(payment_date, 'DY, time') AS month_year 
	,TO_CHAR(payment_date, 'DY, HH:MI') AS time_24_hour -- HH:MM:SS години, хвилини, секунди
FROM public.payment
GROUP BY 2
ORDER BY total_amount DESC
;

SELECT 
	CURRENT_TIMESTAMP
	,rental_date
	,CURRENT_TIMESTAMP - rental_date
	,EXTRACT(day from return_date - rental_date)
FROM rental
;

--Challenge
SELECT
	customer_id
	,EXTRACT( day from return_date - rental_date ) AS rental_day
FROM public.rental
WHERE customer_id = 35
ORDER BY customer_id
;

SELECT
	customer_id
	,AVG(EXTRACT(day from return_date - rental_date)) AS avg_rent_duration
FROM public.rental
GROUP BY customer_id
ORDER BY avg_rent_duration DESC
;

--5-------------------------------------------------------
--mathematical functional and operators

--ceiling
--floor

SELECT
	film_id
	,rental_rate
	,ROUND(rental_rate*1.4,2) as new_rental_rate
	,CEILING(rental_rate*1.4) as new_rental_rate_2
FROM film
;

SELECT
    product_name
    ,SUM(quantity_sold*price_per_unit) AS total_revenue
FROM sales
GROUP BY product_name
ORDER BY total_revenue DESC
LIMIT 1
;

--Challenge
SELECT
	film_id
	,ROUND(rental_rate/replacement_cost*100,2) AS rate_replcost
FROM public.film
WHERE rental_rate < (0.04*replacement_cost)
ORDER BY 2 
;
-- CASE
-- CASE WHEN ... THEN....
-- ELSE reesult
-- END

SELECT *
FROM bookings.flights
;

SELECT 
	COUNT(*) AS flights
	,CASE
		WHEN actual_departure IS NULL THEN 'no departure time'
		WHEN actual_departure-scheduled_departure < '00:05' THEN 'On time'
		WHEN actual_departure-scheduled_departure < '01:00' THEN 'A little bit late'
		ELSE 'Very Late'
	END is_late
FROM bookings.flights
GROUP BY is_late
;

-- Coding exercise
SELECT
    order_id
    ,product_id
    ,quantity
    ,unit_price
    ,CASE 
        WHEN quantity > 1 THEN 0.9 * (quantity * unit_price) + shipping_fee
        ELSE (quantity * unit_price) + shipping_fee
    END total_price
FROM sales_orders
;

-- Challenge
SELECT * FROM bookings.ticket_flights LIMIT 10;
SELECT * FROM bookings.flights LIMIT 10;

--1
SELECT
	COUNT(*)
	,CASE
		WHEN amount < 20000 THEN 'Low price ticket'
		WHEN amount < 150000 THEN 'Mid price ticket'
		ELSE 'High price ticket'
	END category
FROM bookings.ticket_flights
GROUP BY category
;

--2
--"2017-09-12 08:50:00+02"
SELECT
	COUNT(*) AS flight
	,CASE
		WHEN TO_CHAR(scheduled_departure, 'Mon') IN ('Dec', 'Jan', 'Feb') THEN 'Winter'
		WHEN TO_CHAR(scheduled_departure, 'Mon') IN ('Mar', 'Apr', 'May') THEN 'Spring'
		WHEN TO_CHAR(scheduled_departure, 'Mon') IN ('Jun', 'Jul', 'Aug') THEN 'Summer'
		WHEN TO_CHAR(scheduled_departure, 'Mon') IN ('Sep', 'Oct', 'Nov') THEN 'Fall'
	END season
FROM bookings.flights
GROUP BY season
;

SELECT 
	scheduled_departure
	,TO_CHAR(scheduled_departure, 'Month')
	,CASE
		WHEN TRIM(TO_CHAR(scheduled_departure, 'Month')) IN ('December', 'January', 'February') THEN 'Winter'
		WHEN TRIM(TO_CHAR(scheduled_departure, 'Month')) IN ('March', 'April', 'May') THEN 'Spring'
		WHEN TRIM(TO_CHAR(scheduled_departure, 'Month')) IN ('June', 'July', 'August') THEN 'Summer'
		WHEN TRIM(TO_CHAR(scheduled_departure, 'Month')) IN ('September', 'October', 'November') THEN 'Fall'
	END season
FROM bookings.flights
;

-- Challenge
--3
SELECT * FROM public.film LIMIT 10;

SELECT *
FROM (
	SELECT
		film_id
		,title
		,CASE
			WHEN rating IN ('PG', 'PG-13') OR length > 210 THEN 'Great rating or long'
			WHEN description ILIKE '%drama%' AND length > 90 THEN 'Long drama'
			WHEN description ILIKE '%drama%' AND length <= 90 THEN 'Short drama'
			WHEN rental_rate < 1 THEN 'Very cheap'
		ELSE 'Other'
		END category
	FROM public.film
) AS subquery
WHERE category != 'Other'
;

SELECT 
	SUM(CASE
		WHEN rating IN ('PG', 'G') THEN 1
	ELSE 0
	END)
FROM public.film
;

SELECT 
	SUM(CASE WHEN rating = 'G' THEN 1 ELSE 0 END) AS "G"
	,SUM(CASE WHEN rating = 'R' THEN 1 ELSE 0 END) AS "R"
	,SUM(CASE WHEN rating = 'NC-17' THEN 1 ELSE 0 END) AS "NC-17"
	,SUM(CASE WHEN rating = 'PG-13' THEN 1 ELSE 0 END) AS "PG-13"
	,SUM(CASE WHEN rating = 'PG' THEN 1 ELSE 0 END) AS "PG"
FROM public.film
;

-- Coding exercise
SELECT
    SUM(CASE WHEN category = 'Income' THEN amount ELSE 0 END) AS TotalIncome
    ,SUM(CASE WHEN category = 'Expense' THEN amount ELSE 0 END) AS TotalExpenses
    ,SUM(CASE WHEN category = 'Income' THEN amount ELSE 0 END) - SUM(CASE WHEN category = 'Expense' THEN amount ELSE 0 END) AS NetIncome
	-- SUM(CASE WHEN category = 'Income' THEN amount ELSE -amount END) AS NetIncome
FROM transactions
;

-- COALESCE
-- Замініти значення NULL на щось інше
SELECT
	COALESCE(actual_arrival-scheduled_arrival, '0:00')
FROM bookings.flights
;

SELECT
    transaction_id
    ,account_id
    ,transaction_type
    ,amount
    ,COALESCE(description, 'Not Provided') AS description
FROM transactions
ORDER BY transaction_id ASC
;

-- Challenge after COALESCE and CAST
SELECT
	rental_date
	,COALESCE(CAST(return_date AS VARCHAR), 'not return')
FROM public.rental
ORDER BY rental_date DESC
;

-- CAST
-- change data type: VARCHAR(text), DATE, INT, BIGINT
SELECT
	COALESCE(CAST(actual_arrival-scheduled_arrival AS VARCHAR), 'Not arrived')
FROM bookings.flights
;

-- REPLACE
SELECT
	CAST(REPLACE(passenger_id, ' ', '') AS BIGINT)
FROM bookings.tickets
;

SELECT
	CAST(REPLACE(flight_no, 'PG', '') AS BIGINT)
FROM bookings.flights
;

--6-------------------------------------------------------
-- JOINS
-- INNER JOIN - only rows appear in both tables
-- OUTER JOIN 
-- FULL OUTER JOIN - get all of the  raws from both tables
-- LEFT - get all of the raws from Table A, and also both in table A and B are included. 
-- But if there some rows that appear in Table B but not in A, these raws we don1t consider.
-- RIGHT JOIN

-- WE should have one common column

SELECT 
	p.customer_id
	,p.amount
	,c.first_name
	,c.last_name
	,c.email
FROM public.payment AS p
INNER JOIN public.customer AS c
ON p.customer_id = c.customer_id
;

SELECT 
	p.*
	,first_name
	,last_name
	,email
FROM public.payment p
INNER JOIN public.staff s
ON p.staff_id = s.staff_id
WHERE p.staff_id = 1
;

SELECT 
	s.fare_conditions
	,COUNT(*) AS "Count"
FROM flights f
INNER JOIN 
	boarding_passes b ON f.flight_id = b.flight_id
INNER JOIN 
	seats s ON b.seat_no = s.seat_no AND f.aircraft_code = s.aircraft_code
GROUP BY s.fare_conditions
ORDER BY 2 DESC
;

SELECT *
FROM bookings.boarding_passes b
FULL OUTER JOIN bookings.tickets t
	ON b.ticket_no = t.ticket_no
--WHERE boarding_no IS NULL
WHERE b.ticket_no  IS NULL
;

SELECT *
FROM bookings.aircrafts_data a
LEFT JOIN bookings.flights f ON a.aircraft_code = f.aircraft_code
WHERE f.flight_id IS NULL
;

-- Challenge LEFT OUTER JOIN

SELECT *
FROM bookings.seats
WHERE seat_no = '13D'
;

SELECT *
FROM bookings.boarding_passes
;

--Знайти найпопулярніше сидіння
SELECT 
	COUNT(bp.flight_id) as count_of_flights
	,f.aircraft_code
	,bp.seat_no
FROM bookings.boarding_passes bp
LEFT JOIN bookings.flights f ON bp.flight_id = f.flight_id
GROUP BY f.aircraft_code, bp.seat_no
ORDER BY count_of_flights DESC -- тут я намагалась виділити сидіння для ккожної авіалінії окремо
;

-- Не треба було враховувати що це різні літаки, просто беремо сидіння
SELECT 
	s.seat_no
	,COUNT(b.ticket_no) as count_of_flights
FROM bookings.seats s
LEFT JOIN bookings.boarding_passes b ON s.seat_no = b.seat_no
GROUP BY s.seat_no
ORDER BY count_of_flights DESC
;

SELECT 
	s.seat_no
	,COUNT(b.ticket_no) as count_of_flights
FROM bookings.seats s
LEFT JOIN bookings.boarding_passes b ON s.seat_no = b.seat_no
WHERE b.ticket_no IS NULL
GROUP BY s.seat_no
ORDER BY count_of_flights DESC
;

--Знайти найпопулярнішу лінію
SELECT 
	RIGHT(s.seat_no, 1)
	,COUNT(b.ticket_no) as count_of_flights
FROM bookings.seats s
LEFT JOIN bookings.boarding_passes b ON s.seat_no = b.seat_no
GROUP BY RIGHT(s.seat_no, 1)
ORDER BY count_of_flights DESC
;

select RIGHT(seat_no, 1)
from bookings.seats
;

-- Challenge JOINS

SELECT 
	c.first_name
	,c.last_name
	,a.phone
	,a.district
FROM public.customer c
LEFT JOIN public.address a ON  c.address_id=a.address_id
WHERE district = 'Texas' -- information about customers from Texas
;

SELECT 
	a.address_id
	,a.address
	,c.first_name
	,c.last_name
FROM public.address a
LEFT JOIN public.customer c ON c.address_id=a.address_id
WHERE c.customer_id IS NULL -- old addresses that are not related to any customer
ORDER BY a.address_id
;

-- Joins on Multiple conditions
-- коли в нашій таблиці 2 PK (праймарі кі)
SELECT 
	bp.seat_no
	, ROUND(AVG(tf.amount),2) AS AvgPrice
FROM bookings.boarding_passes bp
LEFT JOIN bookings.ticket_flights tf 
	ON bp.ticket_no = tf.ticket_no
	AND bp.flight_id = tf.flight_id
GROUP BY bp.seat_no
;

-- Joining multiple tables
SELECT 
	passenger_name
	,scheduled_departure
	,scheduled_arrival
FROM bookings.tickets t
LEFT JOIN bookings.ticket_flights tf ON t.ticket_no=tf.ticket_no
LEFT JOIN bookings.flights f ON f.flight_id=tf.flight_id
;

-- Challenge Joining multiple tables
SELECT 
	customer_id
	,first_name
	,last_name
	,email
	,country
FROM  public.customer c
LEFT JOIN public.address a ON  c.address_id=a.address_id
LEFT JOIN public.city ci ON ci.city_id=a.city_id
LEFT JOIN public.country cou ON cou.country_id=ci.country_id
WHERE country = 'Brazil'
;

-- Which passenger (passenger_name) has spent most amount in their bookings (total_amount)?
SELECT
	passenger_name
	,SUM(total_amount) AS total_sum
FROM bookings.tickets t
LEFT JOIN bookings.bookings b ON t.book_ref=b.book_ref
GROUP BY passenger_name
ORDER BY total_sum DESC
;

-- Which fare_condition has ALEKSANDR IVANOV used the most?
SELECT
	passenger_name
	,fare_conditions
	,COUNT(fare_conditions) AS count_conditions
FROM bookings.tickets t
LEFT JOIN bookings.bookings b ON t.book_ref=b.book_ref
LEFT JOIN bookings.ticket_flights tf ON tf.ticket_no=t.ticket_no
WHERE passenger_name = 'ALEKSANDR IVANOV'
GROUP BY passenger_name, fare_conditions
ORDER BY count_conditions DESC -- "Economy"
;

-- Which title has GEORGE LINTON rented the most often?
SELECT 
	--c.customer_id
	--,first_name ||' '||last_name AS full_name
	title
	,COUNT(title) AS count_rent
FROM public.customer c
LEFT JOIN public.rental r ON r.customer_id=c.customer_id
LEFT JOIN public.inventory i ON i.inventory_id=r.inventory_id
LEFT JOIN public.film f ON f.film_id=i.film_id
WHERE first_name ||' '||last_name ='GEORGE LINTON'
--WHERE first_name='GEORGE' and last_name='LINTON'
GROUP BY title
ORDER BY count_rent DESC
LIMIT 1 -- CADDYSHACK JEDI - 3 times
;

--7-------------------------------------------------------
-- UNION - combine rows
-- Matched by the order, NOT by the name of the column
-- The data type must match
-- The number of columns should match
-- If we have some value multiple times after the union in the final table we will have only one-time rows 
-- якщо хочему зберегти дублікати строк то використовуємо UNION ALL

SELECT first_name, 'actor' AS origin FROM public.actor
UNION 
SELECT first_name, 'customer' FROM public.customer
UNION
SELECT UPPER(first_name), 'staff' FROM public.staff
ORDER BY 2  DESC
;

-- SUBQUERIES
SELECT *
FROM public.payment
WHERE amount > (SELECT ROUND(AVG(amount),2) FROM public.payment)
;

SELECT *
FROM public.payment
WHERE customer_id = (SELECT customer_id FROM public.customer WHERE first_name = 'ADAM')
;

-- Challenge SUBQUERIES
SELECT 
	film_id
	,title
	,length
FROM public.film
WHERE length > (SELECT ROUND(AVG(length),2) FROM public.film) -- 115,27
ORDER BY film_id
;

SELECT *
FROM (
	SELECT 
		i.film_id
		,title
		,count(*) AS count_film
	FROM public.inventory i
	LEFT JOIN public.film f ON i.film_id=f.film_id
	WHERE store_id = 2
	GROUP BY i.film_id, title
)
WHERE count_film  > 3
ORDER BY film_id
;

--1
SELECT 
	first_name
	,last_name
FROM public.customer
WHERE customer_id IN 
	(SELECT customer_id
	FROM public.payment
	WHERE payment_date::DATE = '2020-01-25')
;

--2
SELECT 
	first_name
	,email
FROM public.customer
WHERE customer_id IN 
	(SELECT 
		customer_id
		--,SUM(amount)
	FROM public.payment
	GROUP BY customer_id
	HAVING SUM(amount) > 30)
;

--3
SELECT 
	first_name
	,last_name
	,email
FROM public.customer cus
LEFT JOIN public.address add ON cus.address_id=add.address_id
WHERE customer_id IN 
	(SELECT 
		p.customer_id
	FROM public.payment p
	GROUP BY customer_id
	HAVING SUM(amount) > 100) AND  district = 'California'
;

-- Subqueries in FROM
SELECT ROUND(AVG(total_amount),2) AS avg_liftime_spent
FROM
(SELECT 
	customer_id
	,SUM(amount) AS total_amount
FROM public.payment
GROUP BY customer_id) sub
;

-- Challenge
SELECT
	ROUND(AVG(total_amount),2) AS daiky_rev_avg
FROM (
	SELECT 
		DATE(payment_date)
		,SUM(amount) AS total_amount
	FROM public.payment
	GROUP BY DATE(payment_date)) sub
;

-- Subqueries in SELECT
SELECT
	*
	--,'hello'
	,(SELECT ROUND(AVG(amount),2) FROM payment) AS avg_amount
FROM public.payment
;

-- Challenge
SELECT
	*
	, (SELECT MAX(amount) FROM public.payment) - amount AS difference
FROM public.payment
;

-- Correlated Subqueries in WHERE

--Show only thosee payments that have the highest amoount per customer
SELECT
	customer_id
	,amount AS max_amount
FROM public.payment p1
WHERE amount  = (
	SELECT MAX(amount)
	FROM public.payment p2
	WHERE p1.customer_id=p2.customer_id
)
ORDER BY customer_id
;

-- Challenge

--1
SELECT
	film_id
	,title
	,replacement_cost
	,rating
FROM public.film f1
WHERE replacement_cost = (
	SELECT MIN(replacement_cost)
	FROM public.film f2
	WHERE f1.rating=f2.rating -- show only titles with lowest cost for each rating category
)
;

--2
SELECT
	film_id
	,title
	,length
	,rating
FROM public.film f1
WHERE length = (
	SELECT MAX(length)
	FROM public.film f2
	WHERE f1.rating=f2.rating) -- show only titles with highestt lenght in each rating category
;

-- Correlated Subquery in SELECT

-- SHOW the MAX amount for every customer
SELECT
	customer_id
	,amount
	,(SELECT MAX(amount) 
	FROM public.payment a2
	WHERE a1.customer_id=a2.customer_id
	)sub
FROM public.payment a1
;

-- Challenge

-- 1
-- Show all payments plus total amount for every customer + number of payments of each customers
SELECT
	payment_id
	,customer_id
	,amount
	,(SELECT SUM(amount) 
	FROM public.payment p4
	WHERE p1.customer_id=p4.customer_id
	)sum_amount_per_customer
	,(SELECT MAX(amount) 
	FROM public.payment p2
	WHERE p1.customer_id=p2.customer_id
	)max_amount_per_customer
	,(SELECT COUNT(payment_id)
	FROM public.payment p3
	WHERE p1.customer_id=p3.customer_id
	)number_payments_peer_customer
FROM public.payment p1
ORDER BY customer_id ASC, amount DESC
;

-- 2
-- Show only films with the highest replacement costs in their rating category + avg costs in their category
SELECT
	film_id
	,title
	,replacement_cost
	,rating
	,(SELECT ROUND(AVG(replacement_cost),2)
	FROM public.film f2
	WHERE f1.rating=f2.rating) AS avg_repl_costs
FROM public.film f1
WHERE replacement_cost = (SELECT MAX(replacement_cost)
							FROM public.film f3
							WHERE f1.rating=f3.rating) -- in where without name
ORDER BY title
;

-- 3
-- Show payments with highest payment for each customer`s first_name, incl payment id
SELECT
	payment_id
	,first_name
	,amount
FROM public.payment p1
LEFT JOIN public.customer c ON p1.customer_id=c.customer_id
WHERE amount =
	(SELECT MAX(amount)
	FROM public.payment p2
	WHERE p2.customer_id=p1.customer_id
	)
;

--8-------------------------------------------------------
--COURSE PROJECT

-- 1
-- What's the lowest replacement cost?
SELECT DISTINCT(replacement_cost)
FROM public.film
ORDER BY replacement_cost
--LIMIT 1 -- 9,99 the lowest cost
;

-- 2
-- How many films have a replacement cost in the "low" group?
SELECT
	CASE 
		WHEN replacement_cost <= 19.99 AND replacement_cost >= 9.99 THEN 'low' -- 514
		WHEN replacement_cost > 24.99 THEN 'high'
		ELSE  'medium'
		END AS category
	,COUNT(replacement_cost)
FROM public.film
GROUP BY category
;

-- 3
-- In which category is the longest film and how long is it?
SELECT
	title
	,length
	,name
FROM public.film f
LEFT JOIN public.film_category fc ON f.film_id=fc.film_id
LEFT JOIN public.category c ON c.category_id=fc.category_id
WHERE name IN ('Drama', 'Sports')
ORDER BY length DESC
--LIMIT 1 -- Sports 184
;

-- 4 
-- Which category (name) is the most common among the films?
SELECT
	name
	,COUNT(*) AS namber_films
FROM public.film f
LEFT JOIN public.film_category fc ON f.film_id=fc.film_id
LEFT JOIN public.category c ON c.category_id=fc.category_id
GROUP BY name
ORDER BY namber_films DESC -- Sports with 74 titles
;

-- 5
-- Which actor is part of most movies?
SELECT
	first_name
	,last_name
	,COUNT(film_id) AS number_movies
FROM public.actor a 
LEFT JOIN public.film_actor fa ON a.actor_id=fa.actor_id
GROUP BY first_name,last_name
ORDER BY number_movies DESC -- Susan Davis with 54 movies
;

-- 6
-- How many addresses are that?
SELECT
	add.address_id
	,cus.customer_id
FROM public.address add
LEFT JOIN public.customer cus ON cus.address_id=add.address_id
WHERE customer_id IS NULL -- 4 addresses
;

-- 7
-- What city is that and how much is the amount?
SELECT
	--pay.customer_id
	city
	,SUM(amount) AS sum_paym
FROM public.customer cus
LEFT JOIN public.address add ON add.address_id=cus.address_id
LEFT JOIN public.city cit ON cit.city_id=add.city_id
LEFT JOIN public.payment pay ON pay.customer_id=cus.customer_id
GROUP BY city
ORDER BY sum_paym DESC -- Cape Coral with a total amount of 221.55
;

-- 8
-- Which country, city has the least sales?
SELECT
	country ||', '||city AS country_city_store
	,SUM(amount) AS total_amount
FROM public.payment pay
LEFT JOIN public.rental rent ON pay.rental_id=rent.rental_id
LEFT JOIN public.inventory inv ON inv.inventory_id=rent.inventory_id
LEFT JOIN public.store str ON str.store_id=inv.store_id
LEFT JOIN public.address add ON add.address_id=str.address_id
LEFT JOIN public.city cit ON cit.city_id=add.city_id
LEFT JOIN public.country cnt ON cnt.country_id=cit.country_id
GROUP BY country_city_store
ORDER BY total_amount -- це для магазинів
;

SELECT
	--pay.customer_id
	country ||', '||city AS country_city_store
	,SUM(amount) AS sum_paym
FROM public.customer cus
LEFT JOIN public.address add ON add.address_id=cus.address_id
LEFT JOIN public.city cit ON cit.city_id=add.city_id
LEFT JOIN public.payment pay ON pay.customer_id=cus.customer_id
LEFT JOIN public.country cnt ON cnt.country_id=cit.country_id
GROUP BY country_city_store
ORDER BY sum_paym -- United States, Tallahassee with a total amount of 50.85.
;

-- 9
-- Which staff_id makes on average more revenue per customer?
SELECT
	staff_id
	,ROUND(AVG(sum_amount),2) AS c
FROM(
	SELECT
		staff_id
		,customer_id
		,ROUND(SUM(amount),2) sum_amount
	FROM public.payment
	GROUP BY customer_id, staff_id
	ORDER BY 1,2
	) sub
GROUP BY staff_id -- staff_id 2 with an average revenue of 56.64 per customer.
;

select * from public.payment;

-- 10
-- What is the daily average revenue of all Sundays?
SELECT ROUND(AVG(total_revenue),2) AS avg_revenue
FROM (
	SELECT
		DATE(payment_date) AS Date
		--,EXTRACT(DOW from payment_date) AS Day_of_week -- DOW
		,ROUND(SUM(amount),2) AS total_revenue
	FROM public.payment
	WHERE EXTRACT(DOW from payment_date) = 0 -- Sunday(start from 0)
	GROUP BY Date
	) -- 1410.65
;

-- 11
-- Which two movies are the shortest on that list and how long are they?
SELECT
	film_id
	,title
	,length
	,replacement_cost
FROM public.film f1
WHERE length > (SELECT AVG(length) 
				FROM public.film f2
				WHERE f1.replacement_cost=f2.replacement_cost
				)
ORDER BY length -- CELEBRITY HORN and SEATTLE EXPECTATIONS with 110 minutes.
;

-- 12
-- Which district has the highest average customer lifetime value?
SELECT
	district
	,ROUND(AVG(total_amount),2) AS avg_per_district
FROM(
		SELECT
			p.customer_id
			,SUM(amount) AS total_amount
			,district
		FROM public.payment p
		LEFT JOIN public.customer c ON c.customer_id=p.customer_id
		LEFT JOIN public.address a ON a.address_id=c.address_id
		GROUP BY p.customer_id, district
		ORDER BY district
	)
GROUP BY district
ORDER BY avg_per_district DESC -- Saint-Denis with an average customer lifetime value of 216.54.
;

-- 13
-- What is the total revenue of the category 'Action' and what is the lowest payment_id in that category 'Action'?
SELECT 
	*
	,SUM(amount) OVER (PARTITION BY name) AS total_amount_in_category -- WINDOW function
FROM (
		SELECT
			p.payment_id
			,amount
			,name
		FROM public.payment p
		LEFT JOIN public.rental r ON r.rental_id=p.rental_id
		LEFT JOIN public.inventory i ON i.inventory_id=r.inventory_id
		LEFT JOIN public.film_category fc ON fc.film_id=i.film_id
		LEFT JOIN public.category c ON c.category_id=fc.category_id
	) AS sub
WHERE name = 'Action'
ORDER BY total_amount_in_category --  Total revenue in the category 'Action' is 4375.85 and the lowest payment_id in that category is 16055.
;

-- If we use Correlated query
SELECT 
	p.payment_id
	,amount
	,name
	,(SELECT ROUND(SUM(amount),2) 
	FROM public.payment p
	LEFT JOIN public.rental r ON r.rental_id=p.rental_id
	LEFT JOIN public.inventory i ON i.inventory_id=r.inventory_id
	LEFT JOIN public.film_category fc ON fc.film_id=i.film_id
	LEFT JOIN public.category c1 ON c1.category_id=fc.category_id
	WHERE c1.name=c.name -- Correlated query (we have 'c' in mane query and 'c1' here)
	) AS total_amount_in_category
	
FROM public.payment p
LEFT JOIN public.rental r ON r.rental_id=p.rental_id
LEFT JOIN public.inventory i ON i.inventory_id=r.inventory_id
LEFT JOIN public.film_category fc ON fc.film_id=i.film_id
LEFT JOIN public.category c ON c.category_id=fc.category_id

WHERE name = 'Action'
ORDER BY total_amount_in_category --  Total revenue in the category 'Action' is 4375.85 and the lowest payment_id in that category is 16055.
;

-- 14 Extremely difficult
-- Task: Create a list with the top overall revenue of a film title (sum of amount per title) for each category (name).
-- Which is the top-performing film in the animation category?

SELECT 
	name
	,title
	,SUM(amount) AS total_sum
FROM public.payment p
LEFT JOIN public.rental r ON r.rental_id=p.rental_id
LEFT JOIN public.inventory i ON i.inventory_id=r.inventory_id
LEFT JOIN public.film_category fc ON fc.film_id=i.film_id
LEFT JOIN public.category c ON c.category_id=fc.category_id
LEFT JOIN public.film f ON f.film_id=fc.film_id
WHERE name = 'Animation'
GROUP BY name, title
ORDER BY total_sum DESC -- DOGMA FAMILY with 178.70.
;

SELECT
	title
	,name
	,SUM(amount) as total
FROM payment p
LEFT JOIN rental r ON r.rental_id=p.rental_id
LEFT JOIN inventory i ON i.inventory_id=r.inventory_id
LEFT JOIN film f ON f.film_id=i.film_id
LEFT JOIN film_category fc ON fc.film_id=f.film_id
LEFT JOIN category c ON c.category_id=fc.category_id
GROUP BY name,title
HAVING SUM(amount) =     (SELECT MAX(total)
			              FROM 
                                (SELECT
			                         title,
                                     name,
			                         SUM(amount) as total
			              FROM payment p
			              LEFT JOIN rental r ON r.rental_id=p.rental_id
			              LEFT JOIN inventory i ON i.inventory_id=r.inventory_id
	                      LEFT JOIN film f ON f.film_id=i.film_id
				          LEFT JOIN film_category fc ON fc.film_id=f.film_id
                          LEFT JOIN category c1 ON c1.category_id=fc.category_id
				          GROUP BY name,title) sub
			              WHERE c.name=sub.name)
;