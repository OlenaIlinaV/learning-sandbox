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

-- 1075. Project Employees I
-- Write an SQL query that reports the average experience years of all the employees for each project, rounded to 2 digits.
SELECT
    p.project_id
    , ROUND(AVG(e.experience_years),2) AS average_years
FROM Project p
LEFT JOIN Employee e ON p.employee_id = e.employee_id
GROUP BY p.project_id
;

-- 1211. Queries Quality and Percentage
-- We define query quality as:
--The average of the ratio between query rating and its position.
--We also define poor query percentage as:
--The percentage of all queries with rating less than 3.
-- Write a solution to find each query_name, the quality and poor_query_percentage.
--Both quality and poor_query_percentage should be rounded to 2 decimal places.
SELECT
    query_name
    , ROUND(AVG(rating/position), 2) AS quality
    , ROUND(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) * 100 / COUNT(*),2) AS poor_query_percentage
FROM Queries
WHERE query_name IS NOT NULL
GROUP BY query_name
;

-- 1193. Monthly Transactions I
-- Write an SQL query to find for each month and country, the number of transactions and their total amount, the number of approved transactions and their total amount.
SELECT
    DATE_FORMAT(trans_date, '%Y-%m') AS month
    , country
    , COUNT(*) AS trans_count
    , COUNT(CASE WHEN state = 'approved' THEN 1 ELSE NULL END) AS approved_count
    , SUM(amount) AS trans_total_amount
    , SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount
FROM Transactions
GROUP BY DATE_FORMAT(trans_date, '%Y-%m'), country
;

-- 1174. Immediate Food Delivery II
-- If the customer's preferred delivery date is the same as the order date, then the order is called immediate; otherwise, it is called scheduled.
-- The first order of a customer is the order with the earliest order date that the customer made. It is guaranteed that a customer has precisely one first order.
--Write a solution to find the percentage of immediate orders in the first orders of all customers, rounded to 2 decimal places.
WITH CTE AS (
    SELECT 
        customer_id
        , order_date
        , customer_pref_delivery_date
        , ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date) AS rn
    FROM Delivery
)

SELECT
    ROUND(AVG(CASE WHEN order_date = customer_pref_delivery_date THEN 1 ELSE 0 END) * 100,2) AS immediate_percentage
FROM CTE
WHERE rn = 1
;

-- 550. Game Play Analysis IV
-- Write a solution to report the fraction of players that logged in again on the day after the day they first logged in, rounded to 2 decimal places. 
-- In other words, you need to count the number of players that logged in for at least two consecutive days starting from their first login date, then divide that number by the total number of players.
WITH FirstLogin AS (
    SELECT
        player_id
        , MIN(event_date) AS min_event_date
    FROM Activity
    GROUP BY player_id
),

NewTable AS (
    SELECT
        a.player_id
        , a.event_date
        -- , f.player_id
        , f.min_event_date
        , ROW_NUMBER() OVER (PARTITION BY a.player_id ORDER BY a.event_date) AS rn
        , DATEDIFF(event_date, min_event_date) as dif_date
    FROM Activity a
    LEFT JOIN FirstLogin f ON f.player_id = a.player_id
)

SELECT
    ROUND(COUNT(DISTINCT CASE WHEN dif_date = 1 THEN player_id END) * 1.0 / COUNT(DISTINCT player_id), 2) AS fraction
FROM NewTable;
;