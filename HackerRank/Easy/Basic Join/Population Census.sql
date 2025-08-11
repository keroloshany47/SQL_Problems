SELECT SUM(c.population) AS total_population
FROM CITY AS c 
JOIN COUNTRY AS co
ON c.countrycode = co.code
WHERE  co.CONTINENT = 'Asia';
