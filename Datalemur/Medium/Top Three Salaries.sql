WITH ranked AS (
    SELECT 
        employee_id,
        name,
        salary,
        DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS salary_rank,
        department_id
    FROM employee
)


SELECT d.department_name ,r.name,r.salary
FROM department AS d
LEFT JOIN ranked AS r
ON d.department_id =r.department_id
WHERE salary_rank < 4
ORDER BY d.department_name ASC ,r.salary DESC , r.name ;
