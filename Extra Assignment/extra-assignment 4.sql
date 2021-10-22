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
    (3, 'Dan',10),
    (4, 'Meo',4),
    (5, 'Thin',9),
    (6, 'Ti',10),
    (7, 'Ngo',7),
    (8, 'Mui',10),
    (9, 'Than',9),
    (10, 'Dau',10);
drop table IF EXISTS employee_skill;
create table employee_skill(
employee_number int not null ,
skill_code		VARCHAR(50) not null,
date_registered date,
FOREIGN KEY (employee_number) REFERENCES employee(employee_number)
);
insert INTO employee_skill(employee_number,skill_code,date_registered)
VALUES 
	(1,'HTML','2021/10/01'),
    (2,'JAVA','2021/10/02'),
    (3,'CSS','2021/10/03'),
    (4,'JS','2021/10/04'),
    (5,'RAP','2021/10/05'),
    (6,'C','2021/10/06'),
    (7,'C#','2021/10/07'),
    (8,'JAZZ','2021/10/08'),
    (9,'ROCK','2021/10/09'),
    (10,'JAVA','2021/10/10'),
    (1,'JAZZ','2021/10/10'),
    (5,'HTML','2021/10/05');
-- Question 3: Viết lệnh để lấy ra danh sách nhân viên (name) có skill Java
-- Hướng dẫn: sử dụng UNION
select * from employee_skill;
select * from employee;
select employee.employee_name, employee_skill.skill_code
	from employee 
	join employee_skill
    on employee.employee_number= employee_skill.employee_number
    where employee_skill.skill_code="JAVA";
-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
SELECT department.department_name,count(employee.department_number)
from department 
join employee
on department.department_number=employee.department_number
group by (employee.department_number) 
ORDER BY count(employee.department_number) desc limit 1;
-- Question 5: Viết lệnh để lấy ra danh sách nhân viên của mỗi văn phòng ban.
-- Hướng dẫn: sử dụng GROUP BY
select department.department_name, GROUP_CONCAT(employee.employee_name)
from department 
join employee
on department.department_number=employee.department_number
group by (department.department_name);
-- Question 6: Viết lệnh để lấy ra danh sách nhân viên có > 1 skills.
select employee.employee_name,count(employee_skill.employee_number)
from employee
join employee_skill
on employee.employee_number=employee_skill.employee_number
group by employee.employee_number
HAVING count(employee.employee_number)>=2;
-- Hướng dẫn: sử dụng DISTINCT