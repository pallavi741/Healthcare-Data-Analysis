create database healthcare;
use healthcare;

SELECT DATE_FORMAT(appointment_date,'%Y-%m')AS month, COUNT(*) AS number_of_appointments
FROM appointments
GROUP BY month
ORDER BY month;

SELECT YEAR(appointment_date)AS year, COUNT(*) AS number_of_appointments
FROM appointments
GROUP BY year
ORDER BY year;


SELECT medication,COUNT(*) AS frequency, SUM(CAST(SUBSTRING_INDEX(dosage,'',1)AS UNSIGNED)) AS total_dosage
from Prescriptions
GROUP BY medication
ORDER BY frequency DESC;

SELECT p.patient_id,COUNT(a.appointment_id) AS appointment_count,AVG(b.amount) AS avg_billing_amount
FROM Patients p
LEFT JOIN Appointments a ON p.patient_id=a.patient_id
LEFT JOIN Billing b ON a.appointment_id=b.appointment_id
GROUP BY p.patient_id;

SELECT p.patient_id,p.first_name,p.last_name,SUM(b.amount) AS total_billed
FROM Patients p
JOIN Appointments a ON p.patient_id=a.patient_id
JOIN Billing b ON a.appointment_id=b.appointment_id
GROUP BY p.patient_id,p.first_name,p.last_name
ORDER BY total_billed DESC
LIMIT 10;

SELECT DATE_FORMAT(payment_date,'%Y-%m')AS month,status,COUNT(*) As count
FROM Billing
GROUP BY month, status
ORDER BY month, status;

SELECT p.patient_id,p.first_name,p.last_name,SUM(b.amount) AS total_unpaid
FROM Patients p
JOIN Appointments a ON p.patient_id=a.patient_id
JOIN Billing b ON a.appointment_id=b.appointment_id
WHERE b.status='Pending'
GROUP BY p.patient_id,p.first_name,p.last_name
ORDER BY total_unpaid DESC;

SELECT d.doctor_id,d.first_name,d.last_name,COUNT(a.appointment_id) AS
number_of_appointment
FROM Doctors d
LEFT JOIN Appointments a ON d.doctor_id=a.doctor_id
GROUP BY d.doctor_id,d.first_name,d.last_name;

SELECT appointment_date,COUNT(*) AS appointmnet_count
FROM Appointments
GROUP BY appointment_date;

SELECT p.patient_id,p.first_name,p.last_name
FROM Patients p
LEFT JOIN Appointments a ON p.patient_id=a.patient_id
WHERE a.appointment_id IS NULL;

SELECT a.appointment_id,p.first_name As patient_first_name, p.last_name AS patient_last_name, a.appointment_date,a.reason
FROM Appointments a
JOIN Patients p ON a.patient_id=p.patient_id
WHERE a.doctor_id=1;

SELECT p.medication,p.dosage,p.instructions,b.amount,b.payment_date,b.status
FROM Prescriptions p 
JOIN Appointments a ON p.appointment_id=a.appointment_id
JOIN Billing b ON a.appointment_id=b.appointment_id
WHERE b.status='Pending';

SELECT a.appointment_id,p.first_name , p.last_name ,p.dob,p.gender, a.appointment_date
FROM Patients p
JOIN appointments a ON a.patient_id=a.patient_id
WHERE DATE_FORMAT(a.appointment_date,'%Y-%m')='2024-08';