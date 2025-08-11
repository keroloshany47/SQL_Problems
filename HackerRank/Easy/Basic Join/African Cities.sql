SELECT c.Name 
FROM CITY AS C
JOIN COUNTRY AS Co
ON c.countrycode = co.code 
WHERE CONTINENT ='Africa';
