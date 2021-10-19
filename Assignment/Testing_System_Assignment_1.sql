CREATE DATABASE testing_system;
USE testing_system;
CREATE TABLE department(
	department_id		INT,
	department_name		VARCHAR(50)
);
create table positon(
	position_id			INT,
	position_name		VARCHAR(15)
);
create table `account`(
	`account_id`		INT,
	`email`				VARCHAR(50),
	username			VARCHAR(50),
	fullname			VARCHAR(50),
	derpartment_id 		INT,
	position_id			INT,
	creat_date			DATE
);
create table `group`(
	`group_id`			INT,
	group_name			VARCHAR(50),
	creator_id			INT,
	create_date			DATE
);
create table `group_account`(
	`group_id`			INT,
	account_id			INT,
	join_date			DATE
);
create table type_Quetion(
	type_id				INT,
	`type_name`			VARCHAR(50)
);
create table category_question(
	category_id			INT,
	category_name		VARCHAR(50)
);
create table Question(
	question_id 		INT,
	content				TEXT,
	category_id			INT,
	type_id				INT,
	creator_id			INT,
	create_day			DATE
);
create table answer(
	answer_id 			INT,
	content				VARCHAR(200),
	question_id			INT,
	is_correct			BOOLEAN
);
create table Exam(
	exam_id				INT,
	`code`				INT,
	title				VARCHAR(50),
	categoty_id			VARCHAR(50),
	duration			INT,
	creator_id			INT,
	create_date			DATE
);
create table ExamQuetion(
	exam_id				INT,
	question_id			INT
);
