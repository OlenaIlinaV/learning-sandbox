-- INNER JOIN

SELECT 
	t.TrackId 
	, t.Name 
	, a.Title 
	, a.ArtistId 
	, a2.Name 
FROM Track t 
JOIN Album a ON t.AlbumId = a.AlbumId
JOIN Artist a2 ON a.ArtistId = a2.ArtistId 
WHERE a2.Name LIKE "A%"
LIMIT 100
;

SELECT 
	a2.Name 
	, COUNT(t.TrackId) 
FROM Track t 
JOIN Album a ON t.AlbumId = a.AlbumId
JOIN Artist a2 ON a.ArtistId = a2.ArtistId 
WHERE a2.Name LIKE "A%"
Group BY 1
ORDER BY 2 DESC
LIMIT 100
;

-- UNION

SELECT Email 
FROM Customer c 
;

SELECT Email 
FROM Employee e 
;


SELECT 
	'Customer' AS type
	,Email 
FROM Customer c 

UNION

SELECT 
	'Employee' AS type
	, Email 
FROM Employee e 
;

-- INTERSECT (виводить всі значення які відображаються в першому запиті, при умові що вони є в другому запиті)

SELECT 
	'Customer' AS type
	,Email 
FROM Customer c 

INTERSECT

SELECT 
	'Employee' AS type
	, Email 
FROM Employee e 
;

-- EXCEPT (виводить всі значення які відображаються в першому запиті, не включаючи значення які є спільними з другим запитом)

SELECT 
	'Customer' AS type
	,Email 
FROM Customer c 

EXCEPT

SELECT 
	'Employee' AS type
	, Email 
FROM Employee e 
;

-- UNION + min/max

SELECT  
	'min_salary' as parametr
	,MIN(salary_in_usd) as value
FROM salaries s 

UNION

SELECT  
	'max_salary' as parametr
	,MAX(salary_in_usd) as value
FROM salaries s 
;
-- Задача - знайти покупців які покупали треки в трьох музикальних стилях

SELECT 
	--il.InvoiceId 
	--,il.TrackId
	--,t.GenreId
	--,g.Name 
	  c.CustomerId 
	, c.FirstName 
	, c.LastName 
	, COUNT(DISTINCT g.GenreId) AS q_genre
FROM InvoiceLine il
LEFT JOIN Track t ON  il.TrackId = t.TrackId
LEFT JOIN Genre g  ON t.GenreId = g.GenreId 
LEFT JOIN Invoice i ON il.InvoiceLineId = i.InvoiceId
LEFT JOIN Customer c ON i.CustomerId = c.CustomerId
GROUP BY 1,2,3
HAVING COUNT(DISTINCT g.GenreId) >=3
;


-- Створення тимчасових таблиць CTE (Common Table Expression)
WITH melomaniacs AS (

	SELECT 
		  c.CustomerId 
		, c.FirstName 
		, c.LastName 
		, COUNT(DISTINCT g.GenreId) AS q_genre
	FROM InvoiceLine il
	LEFT JOIN Track t ON  il.TrackId = t.TrackId
	LEFT JOIN Genre g  ON t.GenreId = g.GenreId 
	LEFT JOIN Invoice i ON il.InvoiceId = i.InvoiceId
	LEFT JOIN Customer c ON i.CustomerId = c.CustomerId
	GROUP BY 1,2,3
	HAVING COUNT(DISTINCT g.GenreId) >=3
)

, invoices AS (

	SELECT *
	FROM Invoice i 
	WHERE InvoiceDate BETWEEN '2008-01-01' AND '2009-01-01'
)

SELECT *
FROM melomaniacs m
LEFT JOIN invoices i ON m.CustomerID = i.CustomerID
WHERE i.CustomerID IS NULL
;

-- Віконні функції (LAG, LEAD)
SELECT 
	InvoiceID
	, CustomerID
	, InvoiceDate
	, Total
	, LAG(Total, 1) OVER(Partition by CustomerID Order by InvoiceDate) AS lag_total
	, LAG(InvoiceDate, 1) OVER(Partition by CustomerID Order by InvoiceDate) AS lag_total
	, JULIANDAY(InvoiceDate) - JULIANDAY(LAG(InvoiceDate, 1) OVER(Partition by CustomerID Order by InvoiceDate)) AS diff_in_days
	, LEAD(Total, 1) OVER(Partition by CustomerID Order by InvoiceDate) AS lead_total
FROM Invoice i
ORDER BY CustomerID
;


SELECT 
	InvoiceID
	, CustomerId
	, InvoiceDate
	, Total
	, First_VALUE(Total) OVER (Partition by CustomerID ORDER BY InvoiceDate ASC) AS first_amount
	, Last_VALUE(Total) OVER (Partition by CustomerID ORDER BY InvoiceDate ASC) AS last_amount
	
FROM Invoice i
;