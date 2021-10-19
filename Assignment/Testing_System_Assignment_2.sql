-- nếu database testing_system đã có-> xoá
DROP DATABASE IF EXISTS testing_system;
-- tạo database testing_system
CREATE DATABASE testing_system;
-- dùng đâtbase testing_system
USE testing_system;
-- nếu bảng department đã có->xoá
DROP TABLE IF EXISTS department;
-- Table 1:Department
--  DepartmentID: định danh của phòng ban (auto increment)
--  DepartmentName: tên đầy đủ của phòng ban (VD: sale, marketing, ...)
CREATE TABLE department(
	department_id		TINYINT NOT NULL AUTO_INCREMENT PRIMARY KEY, -- khoá chính phòng ban
	department_name		VARCHAR(50) NOT NULL
);
-- Table 2: Position
--  PositionID: định danh của chức vụ (auto increment)
--  PositionName: tên chức vụ (Dev, Test, Scrum Master, PM)
CREATE TABLE `position`(
	position_id			TINYINT AUTO_INCREMENT PRIMARY KEY, -- khoá chính chức vụ
	position_name		ENUM('dev','test','scrum master','PM')
);
-- Table 3: Account
--  AccountID: định danh của User (auto increment)
--  Email:
--  Username:
--  FullName:
--  DepartmentID: phòng ban của user trong hệ thống
--  PositionID: chức vụ của User
--  CreateDate: ngày tạo tài khoản
CREATE TABLE `account`(
	`account_id`		TINYINT AUTO_INCREMENT PRIMARY KEY, -- khoá chính account
	`email`				VARCHAR(50) UNIQUE NOT NULL, -- không trùng 
	username			VARCHAR(50) UNIQUE NOT NULL, -- không trùng
	fullname			VARCHAR(50) NOT NULL, 
	department_id		TINYINT NOT NULL, -- khoá ngoại
	position_id			TINYINT NOT NULL, -- khoá ngoại
	creat_date			DATE NOT NULL,
    FOREIGN KEY (position_id) REFERENCES `position`(position_id),
    FOREIGN KEY (department_id) REFERENCES department(department_id)
);
-- Table 4: Group
--  GroupID: định danh của nhóm (auto increment)
--  GroupName: tên nhóm
--  CreatorID: id của người tạo group
--  CreateDate: ngày tạo group
create table `group`(
	`group_id`			TINYINT AUTO_INCREMENT PRIMARY KEY, -- khoá chính gruop
	group_name			VARCHAR(50) UNIQUE NOT NULL, -- tên nhóm không trùng
	creator_id			TINYINT NOT NULL, 
	create_date			DATE
);
-- Table 5: GroupAccount
--  GroupID: định danh của nhóm
--  AccountID: định danh của User
--  JoinDate: Ngày user tham gia vào nhóm
create table `group_account`(
	`group_id`			TINYINT,
	account_id			TINYINT,
	join_date			DATE,
    FOREIGN KEY (`group_id`) REFERENCES `group`(`group_id`),
    FOREIGN KEY (`account_id`) REFERENCES `account`(`account_id`)
);
-- Table 6: TypeQuestion
--  TypeID: định danh của loại câu hỏi (auto increment)
--  TypeName: tên của loại câu hỏi (Essay, Multiple-Choice)
create table type_question(
	type_id				TINYINT AUTO_INCREMENT PRIMARY KEY, --  khoá chính typequestion
	`type_name`			ENUM('essay','multiple-choice') -- chỉ là essay và multiple-choice
);
-- Table 7: CategoryQuestion
--  CategoryID: định danh của chủ đề câu hỏi (auto increment)
--  CategoryName: tên của chủ đề câu hỏi (Java, .NET, SQL, Postman, Ruby,...)
create table category_question(
	category_id			TINYINT AUTO_INCREMENT PRIMARY KEY, --  khoá chính categoryquestion
	category_name		VARCHAR(10)  NOT NULL
);
-- Table 8: Question
--  QuestionID: định danh của câu hỏi (auto increment)
--  Content: nội dung của câu hỏi
--  CategoryID: định danh của chủ đề câu hỏi
--  TypeID: định danh của loại câu hỏi
--  CreatorID: id của người tạo câu hỏi
--  CreateDate: ngày tạo câu hỏi
create table question(
	question_id 		TINYINT AUTO_INCREMENT PRIMARY KEY, -- khoá chính câu hỏi
	content				VARCHAR(255) NOT NULL, -- nội dung câu hỏi
	category_id			TINYINT NOT NULL, -- khoá ngoại
	type_id				TINYINT NOT NULL, -- khoá ngoại
	creator_id			INT NOT NULL, 
	create_day			DATE  NOT NULL, 
    FOREIGN KEY (category_id) REFERENCES category_question(category_id),
	FOREIGN KEY (type_id) REFERENCES type_question(type_id)
);
-- Table 9: Answer
--  AnswerID: định danh của câu trả lời (auto increment)
--  Content: nội dung của câu trả lời
--  QuestionID: định danh của câu hỏi
--  isCorrect: câu trả lời này đúng hay sai
CREATE TABLE answer (
    answer_id 			TINYINT AUTO_INCREMENT PRIMARY KEY, -- khoá chính answer
    content 			VARCHAR(255),
    question_id 		INT NOT NULL,
    is_correct 			BOOLEAN
);
-- Table 10: Exam
--  ExamID: định danh của đề thi (auto increment)
--  Code: mã đề thi
--  Title: tiêu đề của đề thi
--  CategoryID: định danh của chủ đề thi
--  Duration: thời gian thi
--  CreatorID: id của người tạo đề thi
--  CreateDate: ngày tạo đề thi
create table exam(
	exam_id				TINYINT AUTO_INCREMENT PRIMARY KEY, -- khoá chính exam
	`code`				VARCHAR(8), 
	title				VARCHAR(50),
	category_id			VARCHAR(50), 
	duration			VARCHAR(10) NOT NULL,
	creator_id			TINYINT NOT NULL,
	create_date			DATE
);
create table ExamQuetion(
	exam_id				TINYINT NOT NULL,
	question_id			TINYINT NOT NULL,
    FOREIGN KEY (question_id) REFERENCES question(question_id),
	FOREIGN KEY (exam_id) REFERENCES exam(exam_id)
);
INSERT INTO department(department_id,department_name) 
value(1,'marketing'),(2,'sale'),(3,'bao ve'),(4,'nhan su'),(5,'ky thuat'),(6,'tai chinh'),(7,'pho dam doc'),(8,'giam doc'),(9,'thu ki'),(10,'ban hang');
INSERT INTO `position`(position_id,position_name) 
value(1,'dev'),(2,'test'),(3,'scrum master'),(4,'PM'),(5,'test'),
		(6,'PM'),(7,'PM'),(8,'PM'),(9,'PM'),(10,'PM');
INSERT INTO `account`(account_id,email,username,fullname,department_id,position_id,creat_date) 
value(1,'a@mail.com','a','aa',3,2,'2021/03/22'),
(2,'b@mail.com','b','bb',4,1,'2021/04/21'),
(3,'c@mail.com','c','cc',5,3,'2021/05/22'),
(4,'d@mail.com','d','dd',5,2,'2021/07/22'),
(5,'e@mail.com','e','ee',3,5,'2021/06/22'),
(6,'f@mail.com','f','ff',1,2,'2021/09/22'),
(7,'g@mail.com','g','gg',3,6,'2021/06/03'),
(8,'h@mail.com','h','hh',7,2,'2021/09/12'),
(9,'i@mail.com','i','ii',4,2,'2021/09/02'),
(10,'k@mail.com','k','kk',1,4,'2021/09/22');
INSERT INTO `group`(`group_id`,group_name,creator_id,create_date) 
value(1,'gruop1',2,'2021/03/22'),(2,'gruop2',5,'2021/03/22'),(3,'gruop3',6,'2021/03/22'),(4,'gruop4',4,'2021/03/22'),(5,'gruop5',1,'2021/03/22'),
(6,'gruop6',2,'2021/03/22'),(7,'gruop7',1,'2021/03/22'),(8,'gruop8',9,'2021/03/22'),(9,'gruop9',5,'2021/03/22'),(10,'gruop10',4,'2021/03/22');
-- Question 2: lấy ra tất cả các phòng ban
select department_name from department;
-- Question 3: lấy ra id của phòng ban "Sale"
select department_id from department where department_name='sale';