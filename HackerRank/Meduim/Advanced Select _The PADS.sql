SELECT CONCAT(Name, '(', SUBSTRING(Occupation, 1, 1), ')') AS formatted_name
FROM OCCUPATIONS
ORDER BY Name;

SELECT CONCAT('There are a total of ', COUNT(*), ' ', LOWER(Occupation), 's.') AS occupation_summary
FROM OCCUPATIONS
GROUP BY Occupation
ORDER BY COUNT(*), Occupation;
