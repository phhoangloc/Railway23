create database Trainee;
use Trainee;
create table Trainee_table (
Trainee_ID 		int,
Full_name		varchar(50),
Birth_Date		date,
Gender			varchar(10) check(Gender='Male'or Gender='Female'or Gender='Unknow'),
ET_IQ			int check(0<=ET_IQ and ET_IQ<=20),
ET_Gmath		int check(0<=ET_Gmath and ET_Gmath<=20),
ET_English		int check(0<=ET_English and ET_English<=50),
Training_Class	int,
Evaluation_Notes	text
);
ALTER TABLE Trainee_table ADD `VTI_Account` varchar(50) not null ;