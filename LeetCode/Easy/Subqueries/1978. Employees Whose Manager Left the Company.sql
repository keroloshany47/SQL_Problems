-- First Solution
SELECT employee_id
FROM Employees AS e1
WHERE salary < 30000 
  AND manager_id IS NOT NULL
  AND manager_id NOT IN (
    SELECT employee_id 
    FROM Employees AS e2
  )
ORDER BY employee_id;

-- Second Solution
SELECT e1.employee_id
FROM Employees AS e1
LEFT JOIN Employees AS e2 
ON e1.manager_id = e2.employee_id
WHERE e1.salary < 30000 
  AND e1.manager_id IS NOT NULL
  AND e2.employee_id IS NULL
ORDER BY e1.employee_id;
