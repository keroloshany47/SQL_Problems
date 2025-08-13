SELECT 
    sell_date ,
    COUNT(DISTINCT PRODUCT) AS num_sold , 
    GROUP_CONCAT(DISTINCT product ORDER BY product ASC) AS productS     
FROM Activities 
GROUP BY sell_date 
ORDER BY sell_date  ;
