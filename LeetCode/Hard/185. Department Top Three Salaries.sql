SELECT 
    d.name AS Department,
    e.name AS Employee,
    e.salary AS Salary
FROM Employee AS  E
JOIN Department AS D 
ON E.departmentId = D.id
WHERE (
    SELECT COUNT(DISTINCT E2.salary)
    FROM Employee AS E2
    WHERE E2.departmentId = E.departmentId 
    AND E2.salary > E.salary
) < 3
ORDER BY D.name, E.salary DESC;
