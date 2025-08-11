SELECT co.Continent, 
       FLOOR(AVG(c.Population)) AS avg_city_population
FROM country AS co
JOIN city AS c
    ON co.Code = c.CountryCode
GROUP BY co.Continent;
