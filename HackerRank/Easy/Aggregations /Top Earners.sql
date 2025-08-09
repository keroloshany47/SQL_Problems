SELECT 
    (SELECT MAX(salary * months) FROM employee),
    COUNT(*)
FROM employee
WHERE salary * months = (SELECT MAX(salary * months) FROM employee);
