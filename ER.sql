-- data Prep.

-- rename table name
ALTER TABLE `hospital er` RENAME TO `ER_raw`;

SELECT * FROM hospital_er.er_raw; 

-- modift date var to date type
ALTER TABLE ER_raw
Modify column date DATETIME;

-- modify patient id
ALTER TABLE hospital_er.er_raw
Modify column patient_id VARCHAR(50);

-- modify patient gender
ALTER TABLE hospital_er.er_raw
Modify column patient_gender CHAR(2);

-- modify sat score

-- IF SAT SCORE IS A EMPTY STRING UPDATE IT TO A NULL
UPDATE hospital_er.er_raw
SET patient_sat_score = NULL
WHERE patient_sat_score = '';


ALTER TABLE hospital_er.er_raw
Modify column patient_sat_score INT;

-- Modify first inital
ALTER TABLE hospital_er.er_raw
Modify column patient_first_inital CHAR(1);

-- Modify last name
ALTER TABLE hospital_er.er_raw
Modify column patient_last_name VARCHAR(50);

-- Modify race
ALTER TABLE hospital_er.er_raw
Modify column patient_race VARCHAR(50);

-- Modify admin flag

UPDATE hospital_er.er_raw
SET patient_admin_flag = 1
WHERE patient_admin_flag = 'TRUE';

UPDATE hospital_er.er_raw
SET patient_admin_flag = 0
WHERE patient_admin_flag = 'FALSE';

ALTER TABLE hospital_er.er_raw
Modify column patient_admin_flag BIT;

-- Modify department
ALTER TABLE hospital_er.er_raw
Modify column department_referral VARCHAR(50);



