create database Fresher_Training_Management;
use Fresher_Training_Management;
create table trainee (
	trainee_id 		int,
	Full_name		varchar(50),
	birth_date		date,
	gender			varchar(10) check(Gender='Male'or Gender='Female'or Gender='Unknow'),
	et_eq			int check(0<=ET_IQ and ET_IQ<=20),
	et_gmath		int check(0<=ET_Gmath and ET_Gmath<=20),
	et_english		int check(0<=ET_English and ET_English<=50),
	training_class	int,
	evaluation_notes varchar(255)
);
ALTER TABLE trainee ADD `VTI_Account` varchar(50) not null ;