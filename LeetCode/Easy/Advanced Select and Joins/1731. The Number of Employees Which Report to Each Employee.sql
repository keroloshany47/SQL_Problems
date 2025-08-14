SELECT
  E1.employee_id,
  E1.name,
  COUNT(E2.employee_id) AS reports_count,
  ROUND(AVG(E2.age)) AS average_age
FROM Employees AS E1
LEFT JOIN Employees AS E2
  ON E2.reports_to = E1.employee_id
GROUP BY E1.employee_id, E1.name
HAVING COUNT(E2.employee_id) > 0
ORDER BY E1.employee_id;

