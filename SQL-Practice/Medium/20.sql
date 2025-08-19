--For each doctor, display their id, full name, and the first and last admission date they attended.
SELECT
  doctors.doctor_id,
  concat(doctors.first_name,' ',doctors.last_name) as full_name,
  min(admissions.admission_date) as first_admission,
  max(admissions.admission_date) as last_admission
from doctors
  join admissions 
  on doctors.doctor_id = admissions.attending_doctor_id
group by
full_name;
