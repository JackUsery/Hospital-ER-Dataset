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


-- data exploration

-- paient age calculations

-- avg age
SELECT FORMAT(AVG(patient_age),2) AS avg_age
FROM hospital_er.er_raw;

-- max age
SELECT MAX(patient_age) AS max_age
FROM hospital_er.er_raw;

-- min age
SELECT MIN(patient_age) AS min_age
FROM hospital_er.er_raw;


-- satisfaction score cal.

-- avg
SELECT FORMAT(AVG(patient_sat_score),2) AS avg_score
FROM hospital_er.er_raw;

-- max
SELECT MAX(patient_sat_score) AS max_score
FROM hospital_er.er_raw;

-- min
SELECT MIN(patient_sat_score) AS min_score
FROM hospital_er.er_raw;


-- wait time cal.

-- avg
SELECT FORMAT(AVG(patient_waittime),2) AS avg_waittime
FROM hospital_er.er_raw;

-- max
SELECT Max(patient_waittime) AS min_waittime
FROM hospital_er.er_raw;

-- min
SELECT MIN(patient_waittime) AS min_waittime
FROM hospital_er.er_raw;



-- disterbution count

-- gender
SELECT patient_gender, COUNT(*) AS gender_count
FROM hospital_er.er_raw
GROUP BY patient_gender;


-- race
SELECT patient_race, COUNT(*) AS race_count
FROM hospital_er.er_raw
GROUP BY patient_race;

-- flag
SELECT patient_admin_flag, COUNT(*) AS admin_flag_count
FROM hospital_er.er_raw
GROUP BY patient_admin_flag;

-- trend over time

-- daily 
SELECT
    DATE(date) AS visit_date,
    COUNT(*) AS daily_er_visits,
    AVG(patient_sat_score) AS avg_sat_score,
    AVG(patient_waittime) AS avg_wait_time
FROM hospital_er.er_raw
GROUP BY DATE(date)
ORDER BY visit_date;


-- weekly
SELECT 
    YEAR(date) AS visit_year, 
    WEEK(date) AS visit_week, 
    COUNT(*) AS weekly_er_visits,
    AVG(patient_sat_score) AS avg_sat_score,
    AVG(patient_waittime) AS avg_wait_time
FROM hospital_er.er_raw
GROUP BY YEAR(date), WEEK(date)
ORDER BY visit_year, visit_week;

-- monthly
SELECT 
    YEAR(date) AS visit_year, 
    MONTH(date) AS visit_month, 
    COUNT(*) AS monthly_er_visits,
    AVG(patient_sat_score) AS avg_sat_score,
    AVG(patient_waittime) AS avg_wait_time
FROM hospital_er.er_raw
GROUP BY YEAR(date), MONTH(date)
ORDER BY visit_year, visit_month



SELECT patient_age, avg(patient_sat_score) AS avg_sat_score
FROM hospital_er.er_raw
GROUP BY patient_age;

SELECT patient_age, avg(patient_sat_score) AS avg_sat_score, Avg(patient_waittime) AS avg_wait_time
FROM hospital_er.er_raw
GROUP BY patient_age;

SELECT patient_age, avg(patient_sat_score) AS avg_sat_score
FROM hospital_er.er_raw
WHERE patient_age = 63;

SELECT patient_age, avg(patient_sat_score) AS avg_sat_score, Avg(patient_waittime) AS avg_wait_time
FROM hospital_er.er_raw
WHERE patient_age = 63;

SELECT patient_age, avg(patient_sat_score) AS avg_sat_score, Avg(patient_waittime) AS avg_wait_time
FROM hospital_er.er_raw
WHERE patient_age >= 60
GROUP BY patient_age;


SELECT patient_waittime, patient_sat_score
FROM hospital_er.er_raw;

SELECT department_referral, AVG(patient_waittime) AS avg_wait_time, AVG(patient_sat_score) AS avg_sat_score
from hospital_er.er_raw
GROUP BY department_referral
ORDER BY avg_wait_time;

