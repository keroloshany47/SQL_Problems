-- Show the total amount of male patients and the total amount of female patients in the patients table.
--Display the two results in the same row.
SELECT 
    COUNT(CASE WHEN gender = 'M' THEN 1 END) AS male_count,
    COUNT(CASE WHEN gender = 'F' THEN 1 END) AS female_count
FROM patients;
