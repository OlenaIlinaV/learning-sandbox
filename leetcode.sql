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