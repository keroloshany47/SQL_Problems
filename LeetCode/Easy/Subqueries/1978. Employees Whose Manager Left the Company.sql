SELECT employee_id
FROM Employees AS e1
WHERE salary < 30000 
  AND manager_id IS NOT NULL
  AND manager_id NOT IN (
    SELECT employee_id 
    FROM Employees AS e2
  )
ORDER BY employee_id;

