CREATE TABLE Patients(patient_id VARCHAR (10) PRIMARY KEY,	
first_name VARCHAR (100) NOT NULL,
last_name VARCHAR (100),	
gender VARCHAR (20) NOT NULL,	
date_of_birth DATE NOT NULL,
contact_number VARCHAR (20),	
address VARCHAR (255),	
registration_date DATE NOT NULL,	
insurance_provider VARCHAR (100) NOT NULL,	
insurance_number VARCHAR (30),	
email VARCHAR (100)
);

CREATE TABLE Doctors(doctor_id VARCHAR (10) PRIMARY KEY,	
first_name VARCHAR (100) NOT NULL,	
last_name VARCHAR (100),	
specialization VARCHAR (50) NOT NULL,	
phone_number VARCHAR (20),	
years_experience INT NOT NULL,	
hospital_branch VARCHAR (100) NOT NULL,	
email VARCHAR (100)
);

CREATE TABLE Appointments(appointment_id VARCHAR (10) PRIMARY KEY,	
patient_id VARCHAR (10) NOT NULL,	
doctor_id VARCHAR (10) NOT NULL,	
appointment_date DATE NOT NULL,	
appointment_time TIME NOT NULL,	
reason_for_visit VARCHAR(100) NOT NULL,	
status VARCHAR (50),
FOREIGN KEY (patient_id) REFERENCES Patients (patient_id),
FOREIGN KEY (doctor_id) REFERENCES Doctors (doctor_id)
);

CREATE TABLE Treatment(treatment_id VARCHAR (10) PRIMARY KEY,	
appointment_id VARCHAR (10) NOT NULL,	
treatment_type VARCHAR (100) NOT NULL,	
description VARCHAR (100) NOT NULL,	
cost DECIMAL (10,2),	
treatment_date DATE NOT NULL,
FOREIGN KEY (appointment_id) REFERENCES Appointments (appointment_id)
);


CREATE TABLE Treatment(treatment_id VARCHAR (10) PRIMARY KEY,	
appointment_id VARCHAR (10),	
treatment_type VARCHAR (100) NOT NULL,	
description VARCHAR (100) NOT NULL,	
cost DECIMAL (10,2),	
treatment_date DATE NOT NULL,
FOREIGN KEY (appointment_id) REFERENCES Appointments (appointment_id)
);

CREATE TABLE Billing(bill_id VARCHAR (10) PRIMARY KEY,	
patient_id VARCHAR (10) NOT NULL,	
treatment_id VARCHAR (10) NOT NULL,	
bill_date DATE NOT NULL,	
amount DECIMAL (10,2) NOT NULL,	
payment_method VARCHAR (50) NOT NULL,	
payment_status VARCHAR (50) NOT NULL,
FOREIGN KEY (patient_id) REFERENCES Patients (patient_id),
FOREIGN KEY (treatment_id) REFERENCES Treatment (treatment_id)
);

SELECT * FROM Patients;
SELECT * FROM Doctors;
SELECT * FROM Appointment;
SELECT * FROM Treatment;
SELECT * FROM Billing;

SELECT treatment_type,
AVG(cost) AS avg_cost
FROM Treatment
GROUP BY treatment_type;

SELECT *
FROM Doctors
ORDER BY years_experience DESC
LIMIT 5;

SELECT P.first_name,P.last_name,
B.payment_status      
FROM Patients AS P
RIGHT JOIN Billing AS B 
ON P.patient_id = B.patient_id;

SELECT P.first_name,P.last_name,
B.payment_method,B.payment_status          
FROM Patients AS P
RIGHT JOIN Billing AS B
ON P.patient_id = B.patient_id
WHERE B.payment_status = 'Paid';

SELECT P.first_name,P.last_name,P.gender,
A.reason_for_visit,A.status 
FROM Patients AS P
INNER JOIN Appointments AS A
ON P.patient_id = A.patient_id;

SELECT B.payment_method,SUM(B.amount) AS Total_Amount
FROM Billing AS B
JOIN Treatment as T
ON B.treatment_id=T.treatment_id
GROUP BY B.payment_method;

SELECT treatment_type,AVG(cost) AS AVG_Cost
FROM Treatment
GROUP BY treatment_type
ORDER BY treatment_type ASC;

SELECT * FROM Treatment
WHERE cost =(SELECT MAX(cost) 
FROM Treatment);


SELECT *
FROM Doctors
WHERE years_experience > (SELECT AVG(years_experience)
FROM Doctors);

select * from doctors
order by years_experience desc;

SELECT first_name,specialization,
years_experience,
CASE
WHEN years_experience = 5 THEN 'Junior'
WHEN years_experience BETWEEN 17 AND 19 THEN 'Mid-Level'
ELSE 'Senior'
END AS Doctors_status
FROM Doctors;

SELECT P.first_name,P.last_name,
SUM(B.amount) AS total_bill	
FROM Patients AS P
JOIN Billing AS B
ON P.patient_id = B.patient_id
GROUP BY P.patient_id, P.first_name, P.last_name
HAVING SUM(B.amount) = (SELECT MAX(total_amount) FROM (SELECT SUM(amount) AS total_amount
FROM Billing
GROUP BY patient_id)
AS temp);

SELECT DISTINCT P.patient_id,P.first_name,P.last_name,
B.payment_status             
FROM Patients AS P
JOIN Billing AS B
ON P.patient_id = B.patient_id
WHERE B.payment_status = 'Pending';


    







       
       
  