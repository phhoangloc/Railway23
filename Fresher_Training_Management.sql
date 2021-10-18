DROP DATABASE IF EXISTS Fresher_Training_Management;
CREATE DATABASE Fresher_Training_Management;
use Fresher_Training_Management;
DROP TABLE IF EXISTS trainee;
CREATE TABLE trainee (
	trainee_id 		TINYINT AUTO_INCREMENT PRIMARY KEY,
	full_name		VARCHAR(50),
	birth_date		DATE,
	gender			ENUM('Male','Female','Unknow'),
	et_eq			INT CHECK(0<=et_eq AND et_eq<=20),
	et_gmath		INT check(0<=et_gmath AND et_gmath<=20),
	et_english		INT check(0<=et_english AND et_english<=50),
	training_class	VARCHAR(8),
	evaluation_notes VARCHAR(255)
);
ALTER TABLE trainee ADD `VTI_Account` varchar(50) not null ;