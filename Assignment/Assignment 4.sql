drop database IF EXISTS `new database`;
create database `new database`;
use `new database`;
drop table IF EXISTS department;
create table department(
department_number INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
department_name VARCHAR(50) NOT NULL
);
insert INTO department(department_number,department_name)
VALUES 
	(1, 'tai chinh'),
    (2, 'kinh te'),
    (3, 'quang cao'),
    (4, 'nhan su'),
    (5, 'hanh chinh'),
    (6, 'san xuat'),
    (7, 'chinh tri'),
    (8, 'doi noi'),
    (9, 'doi ngoai'),
    (10, 'ton giao');

drop table IF EXISTS employee;
create table employee(
employee_number 	int not null AUTO_INCREMENT PRIMARY KEY,
employee_name		varchar(50) not null,
department_number 	INT NOT NULL,
FOREIGN KEY (department_number) REFERENCES department(department_number)
);
insert INTO employee(employee_number,employee_name,department_number)
VALUES 
	(1, 'Ti', 1),
    (2, 'Suu',2),
    (3, 'Dan',3),
    (4, 'Meo',4),
    (5, 'Thin',9),
    (6, 'Ti',6),
    (7, 'Ngo',7),
    (8, 'Mui',10),
    (9, 'Than',9),
    (10, 'Dau',10);
drop table IF EXISTS employee_skill_table;
create table employee_skill(
employee_number int not null ,
skill_code 		int not null,
date_registered date,
FOREIGN KEY (employee_number) REFERENCES employee(employee_number)
);
insert INTO employee_skill(employee_number,skill_code,date_registered)
VALUES 
	(1,1,'2021/10/01'),
    (2,2,'2021/10/02'),
    (3,3,'2021/10/03'),
    (4,4,'2021/10/04'),
    (5,1,'2021/10/05'),
    (6,2,'2021/10/06'),
    (7,4,'2021/10/07'),
    (8,3,'2021/10/08'),
    (9,2,'2021/10/09'),
    (10,4,'2021/10/10');