select *
from salaries
;

SELECT 
	year
	, exp_level as level
	, emp_type as type
FROM salaries
WHERE 
		year != 2022
		AND exp_level = 'SE'
ORDER BY year ASC
LIMIT 20
;

-- top 5 Data Science salaries in 2023

SELECT 
	year
	, job_title
	, salary_in_usd
FROM salaries
WHERE
	year = 2023
	AND job_title = 'Data Scientist'
Order BY salary_in_usd DESC
LIMIT 5
;


SELECT 1 as nmb_1
;

SELECT 
	COUNT(*) AS cnt_all
	, COUNT(exp_level) AS cnt_level
	, COUNT(DISTINCT exp_level) as cnt_dist
FROM salaries
LIMIT 10
;


SELECT 
		year
		, exp_level
		,salary_in_usd
		,salary_in_usd * 38 AS salary_in_uah
		,CASE 
			WHEN exp_level = 'SE'
			THEN 'Senior'
			WHEN exp_level = 'MI'
			THEN 'Middle'
			ELSE 'Other'
			END
FROM salaries
LIMIT 10
;


SELECT 
	salary_in_usd AS salary
	,year
	,job_title
FROM salaries
WHERE 
	year = 2023
	AND job_title = 'ML Engineer'
ORDER BY 1 ASC
LIMIT 10
;

SELECT
	company_location
	,salary_in_usd
	,job_title
	,year
FROM salaries
WHERE 1=1
	AND year = 2023
	AND job_title = 'Data Scientist'
ORDER BY 2 ASC
LIMIT 1
;

SELECT
	company_location
	,salary_in_usd
	,job_title
	,year
	,remote_ratio
FROM salaries
WHERE remote_ratio = 100	
ORDER BY 2 DESC
LIMIT 5
;


SELECT COUNT(DISTINCT job_title)
FROM salaries
;


SELECT
	MIN(salary_in_usd) AS min_sal
	,MAX(salary_in_usd) AS max_sal
	,ROUND(AVG(salary_in_usd),2) AS avg_sal
FROM salaries
;

SELECT 
	job_title
	,(salary_in_usd * 38) AS salary_in_uah
FROM salaries
WHERE 
	year = 2023 
	AND job_title = 'ML Engineer'
ORDER BY 2 DESC
LIMIT 5
;

SELECT DISTINCT ROUND((remote_ratio/100.0),2) AS rem
FROM salaries
;

SELECT *
		,CASE
		WHEN exp_level = 'SE' THEN 'Senior'
		WHEN exp_level = 'MI' THEN 'Middle'
		WHEN exp_level = 'EN' THEN 'Entry-level'
		ELSE 'Executive-level'
		END AS exp_level_full
FROM salaries
;

SELECT count(*)
FROM salaries
;

SELECT COUNT(*) - COUNT(job_title)
FROM salaries
;


SELECT *
FROM salaries
WHERE 1=1
	AND exp_level = 'MI'
	AND exp_level = 'SE'
	AND YEAR BETWEEN 2021 AND 2023
LIMIT 20
;


SELECT YEAR
FROM salaries
WHERE 1=1
	AND YEAR IN(2021,2023)
LIMIT 20
;


SELECT DISTINCT job_title
FROM salaries
WHERE 1=1
	AND job_title LIKE ('Data Sc%')
;


SELECT DISTINCT job_title
FROM salaries
WHERE 1=1
	AND job_title IS NOT NULL
	AND job_title LIKE ('Data Sc%')
;

SELECT 
		job_title
		,exp_level
		,COUNT(*) AS job_nmb
		,ROUND(AVG(salary_in_usd*38),2) AS salary_avg_in_uah
FROM salaries
WHERE year = 2023
GROUP BY job_title, exp_level
ORDER BY 1,2
;


SELECT 
		job_title
		-- ,COUNT(*) AS job_nmb
		,ROUND(AVG(salary_in_usd*38),2) AS salary_avg_in_uah
FROM salaries
WHERE year = 2023
GROUP BY job_title
HAVING COUNT(*) = 1
-- ORDER BY job_nmb ASC
;


SELECT AVG(salary_in_usd) AS salary_avg_in_usd
FROM salaries
;

SELECT 
	job_title
	,salary_in_usd
FROM salaries
WHERE salary_in_usd >
(
	SELECT AVG(salary_in_usd) AS salary_avg_in_usd
	FROM salaries
	WHERE YEAR = 2023
)
;


SELECT *
	, CASE 
	WHEN AVG(salary_in_usd)>
(
	SELECT AVG(salary_in_usd) AS salary_avg_in_usd
	FROM salaries
) THEN 'OK'
	ELSE 'NOT'
	END AS avg_category
FROM salaries
;

-- 1 
	SELECT AVG(salary_in_usd) AS salary_avg_in_usd
	FROM salaries

--2 
SELECT
	company_location
	,AVG(salary_in_usd)
FROM salaries
GROUP BY company_location
;

--3 
SELECT
	company_location
FROM salaries
WHERE year = 2023
GROUP BY company_location
HAVING AVG(salary_in_usd) >
(
	SELECT AVG(salary_in_usd)
	FROM salaries
	WHERE year =2023
)
;

--4
SELECT *
FROM salaries
WHERE emp_resid IN
(
SELECT
	company_location
FROM salaries
WHERE year = 2023
GROUP BY company_location
HAVING AVG(salary_in_usd) >
(
	SELECT AVG(salary_in_usd)
	FROM salaries
	WHERE year =2023
)	
)
;


-- 1
SELECT
	company_location
	,MAX(salary_in_usd)
FROM salaries
WHERE 1=1
	AND year = 2023	
GROUP BY 1
;

--2
SELECT
	company_location
	,MAX(salary_in_usd) AS "Max salary in 2023"
FROM salaries
WHERE 1=1
	AND year = 2023	
GROUP BY 1
ORDER BY 2 ASC
LIMIT 1
;


SELECT 
	MIN(sub.max_salary)
FROM(
	SELECT
		company_location
		,MAX(salary_in_usd) AS max_salary
	FROM salaries
	WHERE 1=1
		AND year = 2023	
	GROUP BY 1
) AS sub
;

--1
SELECT 
	job_title
	,ROUND(AVG(salary_in_usd),2)
FROM salaries
GROUP BY job_title
ORDER BY 1 ASC
;

--2
SELECT 
	ROUND(MAX(salary_in_usd),2)
FROM salaries
;

--3
SELECT 
	job_title
	,ROUND(AVG(salary_in_usd),2) -
(
	SELECT 
	ROUND(MAX(salary_in_usd),2)
	FROM salaries
) AS diff
FROM salaries
GROUP BY job_title
ORDER BY 1 ASC
;

SELECT *
FROM
(
SELECT *
FROM salaries
ORDER BY salary_in_usd DESC
LIMIT 2
) AS sub
ORDER BY salary_in_usd ASC
LIMIT 1
;


SELECT *
FROM salaries
ORDER BY salary_in_usd DESC
LIMIT 1 OFFSET 1
;


SELECT 
	job_title
	,exp_level
	,MIN(salary_in_usd)
FROM salaries
GROUP BY 1, 2
ORDER BY 1 ASC
LIMIT(10)
;


SELECT
	corr(company_size,salary_in_usd)
FROM salaries
;

-- Віконні функції
select  
	job_title
	, ROUND(AVG(salary_in_usd),0) as avg_salary
from salaries s 
group by 1
;

	
select
	job_title
	, salary_in_usd 
	, AVG(salary_in_usd) OVER(partition by job_title) as avg_salary
	, MIN(salary_in_usd) OVER(partition by job_title) as min_salary
	, MAX(salary_in_usd) OVER(partition by job_title) as max_salary
	, COUNT(salary_in_usd ) OVER(partition by job_title) as job_cnt
from salaries s 
;


with cte as (
	select
		job_title
		, salary_in_usd 
		, SUM(salary_in_usd) OVER(partition by job_title order by salary_in_usd) as sum_salary
		--, AVG(salary_in_usd) OVER(partition by job_title) as avg_salary
		--, MIN(salary_in_usd) OVER(partition by job_title) as min_salary
		--, MAX(salary_in_usd) OVER(partition by job_title) as max_salary
		--, COUNT(salary_in_usd ) OVER(partition by job_title) as job_cnt
	from salaries s 
	where year = 2023
)

select *
	, salary_in_usd::float/max_salary as ratio_max
	, salary_in_usd/avg_salary as ratio_avg
from cte
;


with cte as (
	select
		job_title
		, salary_in_usd 
		, AVG(salary_in_usd) OVER(partition by job_title) as avg_salary	
	from salaries s 
	where year = 2023
)

select *
from cte
where salary_in_usd > avg_salary
;


--select *
--from information_schema.colums
--;

-- Створюємо нову таблицю
create table test(
		col_1 text
		,col_2 int
)
;

-- ALTER + ADD - додаємо нову колонку
alter table test
add column col_3 text
;

-- ALTER + RENAME - перемейновуємо колонку
alter table test
rename column col_3 to col_4
;

-- ALTER + DROP COLUMN - видаляємо колонку
alter table test
drop column col_4
;

--INSERT INTO + VALUES - додаемо рядки (значення)
insert into test (col_1, col_2)
values ('text', 1)
;

select *
from test t
;

--Створюємо дублікат таблиці
create table test_copy as
select * from test t 
;

--Видалення таблиці
drop table test_copy
