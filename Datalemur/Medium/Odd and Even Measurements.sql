WITH ranked AS (
SELECT DATE(measurement_time) AS measurement_day,
measurement_value,
ROW_NUMBER() OVER (PARTITION BY DATE(measurement_time) ORDER BY measurement_time ) AS rnk
FROM measurements 
)

SELECT measurement_day ,
SUM(CASE WHEN rnk % 2 = 1 THEN measurement_value ELSE 0 END) AS odd_sum,
SUM(CASE WHEN rnk % 2 = 0 THEN measurement_value ELSE 0 END) AS even_sum
FROM ranked
GROUP BY measurement_day
ORDER BY measurement_day ;
