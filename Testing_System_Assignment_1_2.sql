DROP DATABASE IF EXISTS testing_system;
CREATE DATABASE testing_system;
USE testing_system;
CREATE TABLE department(
	department_id		INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	department_name		VARCHAR(50)
);
CREATE TABLE `position`(
	position_id			INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	position_name		VARCHAR(50)
);
CREATE TABLE `account`(
	`account_id`		INT  UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	`email`				VARCHAR(50) UNIQUE NOT NULL,
	username			VARCHAR(50) UNIQUE NOT NULL,
	fullname			VARCHAR(50) NOT NULL,
	department_id		INT,
	position_id			INT,
	creat_date			DATE,
    FOREIGN KEY (position_id) REFERENCES `position`(position_id),
    FOREIGN KEY (department_id) REFERENCES department(department_id)
);
create table `group`(
	`group_id`			INT AUTO_INCREMENT PRIMARY KEY,
	group_name			VARCHAR(50),
	creator_id			INT,
	create_date			DATE
);
create table `group_account`(
	`group_id`			INT,
	account_id			INT,
	join_date			DATE,
    FOREIGN KEY (`group_id`) REFERENCES `group`(`group_id`),
    FOREIGN KEY (`account_id`) REFERENCES `account`(`account_id`)
);
create table type_Quetion(
	type_id				INT AUTO_INCREMENT PRIMARY KEY,
	`type_name`			ENUM('essay','multiple-choice')
);
create table category_question(
	category_id			INT AUTO_INCREMENT PRIMARY KEY,
	category_name		VARCHAR(10)
);
create table question(
	question_id 		INT AUTO_INCREMENT PRIMARY KEY,
	content				TEXT,
	category_id			INT,
	type_id				INT,
	creator_id			INT,
	create_day			DATE,
    FOREIGN KEY (category_id) REFERENCES category_question(category_id),
	FOREIGN KEY (type_id) REFERENCES type_Quetion(type_id),
    FOREIGN KEY (`creator_id`) REFERENCES `group`(`creator_id`),
    FOREIGN KEY (`create_day`) REFERENCES `account`(`create_day`)
);
CREATE TABLE answer (
    answer_id INT AUTO_INCREMENT PRIMARY KEY,
    content VARCHAR(200),
    question_id INT,
    is_correct BOOLEAN,
    FOREIGN KEY (question_id) REFERENCES question(question_id)
);
create table exam(
	exam_id				INT AUTO_INCREMENT PRIMARY KEY,
	`code`				INT,
	title				VARCHAR(50),
	categoty_id			VARCHAR(50),
	duration			INT,
	creator_id			INT,
	create_date			DATE
);
create table ExamQuetion(
	exam_id				INT,
	question_id			INT,
    FOREIGN KEY (question_id) REFERENCES question(question_id),
	FOREIGN KEY (exam_id) REFERENCES exam(exam_id)
);
