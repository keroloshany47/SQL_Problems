SELECT 
  managers.manager_name,
  COUNT(DISTINCT managers.emp_id) AS direct_reportees
FROM employees
JOIN employees AS managers
  ON employees.manager_id = managers.emp_id
JOIN employees AS senior_managers
  ON managers.manager_id = senior_managers.emp_id
GROUP BY managers.manager_name
ORDER BY direct_reportees DESC;
