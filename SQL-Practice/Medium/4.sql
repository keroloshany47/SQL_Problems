-- Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.
--Primary diagnosis is stored in the admissions table.
SELECT
 patients.patient_id,
 patients.first_name,
 patients.last_name
FROM patients
JOIn admissions
on patients.patient_id =admissions.patient_id
WHERE admissions.diagnosis ='Dementia';
