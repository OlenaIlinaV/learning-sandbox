-- 1378. Replace Employee ID With The Unique Identifier
SELECT
    eu.unique_id
    , e.name
FROM Employees e
LEFT JOIN EmployeeUNI eu ON e.id = eu.id
;

-- 1068. Product Sales Analysis I
SELECT
    p.product_name
    , s.year
    , s.price
FROM Sales s
LEFT JOIN Product p ON s.product_id = p.product_id
;

-- 1581. Customer Who Visited but Did Not Make Any Transactions
-- Write a solution to find the IDs of the users who visited without making any transactions and the number of times they made these types of visits.
SELECT 
    v.customer_id
    , COUNT(*) AS count_no_trans
FROM Visits v
LEFT JOIN Transactions t ON v.visit_id = t.visit_id
WHERE t.visit_id IS NULL
GROUP BY v.customer_id
;

-- 197. Rising Temperature
-- Write a solution to find all dates' Id with higher temperatures compared to its previous dates (yesterday).
-- First variant
WITH CTE AS (
    SELECT
        id
        , recordDate
        , temperature
        , LAG(temperature, 1) OVER (ORDER BY recordDate) AS PreviousTemperature
        , LAG(recordDate, 1) OVER (ORDER BY recordDate) AS PreviousRecordDate
    FROM Weather
)

SELECT id
FROM CTE
WHERE 1=1
    AND temperature > PreviousTemperature
    AND recordDate = DATE_ADD(PreviousRecordDate, INTERVAL 1 DAY)
;

-- Second variant
SELECT W1.id
FROM Weather W1
JOIN Weather W2
ON W1.recordDate = DATE_ADD(W2.recordDate, INTERVAL 1 DAY)
WHERE W1.temperature > W2.temperature;

-- 1661. Average Time of Process per Machine
-- There is a factory website that has several machines each running the same number of processes. 
-- Write a solution to find the average time each machine takes to complete a process.
-- The time to complete a process is the 'end' timestamp minus the 'start' timestamp. The average time is calculated by the total time to complete every process on the machine divided by the number of processes that were run.
-- The resulting table should have the machine_id along with the average time as processing_time, which should be rounded to 3 decimal places.
SELECT
    a1.machine_id
    , ROUND(AVG(a2.timestamp - a1.timestamp),3) AS processing_time
FROM Activity a1, Activity a2
WHERE 1=1
    AND a1.machine_id = a2.machine_id
    AND a1.process_id = a2.process_id
    AND a1.activity_type = 'start'
    AND a2.activity_type = 'end'
GROUP BY machine_id
;

-- 577. Employee Bonus
-- Write a solution to report the name and bonus amount of each employee with a bonus less than 1000.
SELECT 
    e.name
    , b.bonus
FROM Employee e
LEFT JOIN Bonus b ON e.empID = b.empID
WHERE 1=1   
    AND bonus < 1000
    OR bonus IS NULL
;

-- 1280. Students and Examinations
-- Write a solution to find the number of times each student attended each exam.
SELECT 
    s.student_id
    , s.student_name
    , sub.subject_name
    , COUNT(e.subject_name) AS attended_exams
FROM Students s 
CROSS JOIN Subjects sub 
LEFT JOIN Examinations e ON e.student_id = s.student_id
AND sub.subject_name = e.subject_name
GROUP BY s.student_id, s.student_name, sub.subject_name
ORDER BY s.student_id, sub.subject_name
;

-- 570. Managers with at Least 5 Direct Reports
-- Write a solution to find managers with at least five direct reports.
SELECT 
    manegers.name
FROM Employee manegers
INNER JOIN Employee employees ON employees.managerId = manegers.id
GROUP BY manegers.id, manegers.name
HAVING COUNT(manegers.id) >= 5;

-- 1934. Confirmation Rate
-- The confirmation rate of a user is the number of 'confirmed' messages divided by the total number of requested confirmation messages. The confirmation rate of a user that did not request any confirmation messages is 0. 
-- Round the confirmation rate to two decimal places.

-- My solution
WITH CTE AS (
        SELECT 
            s.user_id AS user_id
            , s.time_stamp AS time_stamp_S
            , c.user_id AS UserID
            , c.time_stamp AS time_stamp_C
            , c.action AS Action
            , CASE 
                WHEN c.action = 'confirmed' THEN 1
                WHEN c.action = 'timeout' THEN 0
                ELSE 0
                END AS confirmation_rate_1
        FROM Signups s
        LEFT JOIN Confirmations c ON s.user_id = c.user_id
)

SELECT user_id
    , ROUND(AVG(confirmation_rate_1),2) AS confirmation_rate
FROM CTE
GROUP BY user_id
;

-- Other
SELECT 
    Signups.user_id,
    Round(Avg(If(Confirmations.action='confirmed',1,0)),2) as confirmation_rate -- we can use IF
FROM Signups 
LEFT JOIN Confirmations ON Signups.user_id = Confirmations.user_id
GROUP BY user_id;

-- 620. Not Boring Movies
-- Write a solution to report the movies with an odd-numbered ID and a description that is not "boring".
-- Return the result table ordered by rating in descending order.
SELECT *
FROM Cinema
WHERE 1=1
    AND description != 'boring'
    AND id % 2 != 0
ORDER BY rating DESC
;

-- 1251. Average Selling Price
-- Write a solution to find the average selling price for each product. average_price should be rounded to 2 decimal places.
SELECT
    p.product_id
    , IFNULL(ROUND(SUM(p.price * u.units)/SUM(u.units),2),0) AS average_price
FROM Prices p
LEFT JOIN UnitsSold u ON p.product_id = u.product_id
AND u.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY p.product_id
;
