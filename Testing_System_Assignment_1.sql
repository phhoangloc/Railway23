CREATE DATABASE testing_system;
USE testing_system;
CREATE TABLE Department(
	Department_ID		INT,
	Department_Name		VARCHAR(50)
);
create table Positon(
	Position_ID 		INT,
	Position_NAME		VARCHAR(15)
);
create table `Account`(
	`Account_ID`		INT,
	`Email`				VARCHAR(50),
	Username			VARCHAR(50),
	Fullname			VARCHAR(50),
	Derpartment_ID 		INT,
	Position_ID			INT,
	Creat_Date			DATE
);
create table `Group`(
	`Group_ID`			INT,
	Group_NAME			VARCHAR(50),
	Creator_ID			INT,
	CreateDate			DATE
);
create table `GroupAccount`(
	`Group_ID`			INT,
	Accont_ID			INT,
	Join_Date			DATE
);
create table TypeQuetion(
	Type_ID				INT,
	`Type_NAME`			VARCHAR(50)
);
create table CategoryQuestion(
	Category_ID			INT,
	Category_NAME		VARCHAR(50)
);
create table Quention(
	Question_ID 		INT,
	Content				TEXT,
	Category_ID			INT,
	Type_ID				INT,
	Creator_ID			INT,
	CreateDay			DATE
);
create table Answer(
	Answer_ID 			INT,
	Content				VARCHAR(200),
	Question_ID			INT,
	isCorrect			INT
);
create table Exam(
	Exam_ID				INT,
	`Code`				INT,
	Title				VARCHAR(50),
	Categoty_ID			VARCHAR(50),
	Duration			TIME,
	Creator_ID			INT,
	CreateDate			DATE
);
create table ExamQuetion(
	Exam_ID				INT,
	Question_ID			INT
);
