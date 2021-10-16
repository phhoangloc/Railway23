create database testing_system;
use testing_system;
create table Department(
Department_ID		int,
Department_Name		varchar(50)
);
create table Positon(
Position_ID 		int,
Position_NAME		varchar(15)
);
create table `Account`(
`Account_ID`		int,
`Email`				varchar(50),
Username			varchar(50),
Fullname			varchar(50),
Derpartment_ID 		int,
Position_ID			int,
Creat_Date			date
);
create table `Group`(
`Group_ID`			int,
Group_NAME			varchar(50),
Creator_ID			int,
CreateDate			date
);
create table `GroupAccount`(
`Group_ID`			int,
Accont_ID			int,
Join_Date			date
);
create table TypeQuetion(
Type_ID				int,
`Type_NAME`			varchar(50)
);
create table CategoryQuestion(
Category_ID			int,
Category_NAME		varchar(50)
);
create table Quention(
Question_ID 		int,
Content				text,
Category_ID			int,
Type_ID				int,
Creator_ID			int,
CreateDay			date
);
create table Answer(
Answer_ID 			int,
Content				varchar(200),
Question_ID			int,
isCorrect			int
);
create table Exam(
Exam_ID				int,
`Code`				int,
Title				varchar(50),
Categoty_ID			varchar(50),
Duration			time,
Creator_ID			int,
CreateDate			date
);
create table ExamQuetion(
Exam_ID				int,
Question_ID			int
);
