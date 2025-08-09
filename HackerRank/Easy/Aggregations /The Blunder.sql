SELECT CEIL(
    AVG(salary) - AVG(REPLACE(salary, '0', ''))
) AS error
FROM employees;
