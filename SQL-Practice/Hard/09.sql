--For each day display the total amount of admissions on that day. 
--Display the amount changed from the previous date.

SELECT 
    admission_date,
    COUNT(*) AS total_admissions,
    COUNT(*) - LAG(COUNT(*)) OVER (ORDER BY admission_date) AS change_from_previous
FROM admissions
GROUP BY admission_date
ORDER BY admission_date;
