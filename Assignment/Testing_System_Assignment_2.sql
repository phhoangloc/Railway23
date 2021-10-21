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
DROP TABLE IF EXISTS department;
CREATE TABLE department(
	department_id		TINYINT NOT NULL AUTO_INCREMENT PRIMARY KEY , -- khoá chính phòng ban
	department_name		VARCHAR(50) NOT NULL UNIQUE
);
INSERT INTO department(department_id,department_name) 
values(1,'marketing'),(2,'sale'),(3,'bao ve'),(4,'nhan su'),(5,'ky thuat'),(6,'tai chinh'),(7,'pho dam doc'),(8,'giam doc'),(9,'thu ki'),(10,'ban hang');
-- Table 2: Position
--  PositionID: định danh của chức vụ (auto increment)
--  PositionName: tên chức vụ (Dev, Test, Scrum Master, PM)
DROP TABLE IF EXISTS `position`;
CREATE TABLE `position`(
	position_id			TINYINT AUTO_INCREMENT PRIMARY KEY NOT NULL, -- khoá chính chức vụ
	position_name		ENUM('Dev','Test','Scrum Master','PM','developer' )
);
INSERT INTO `position`(position_id,position_name) 
values(1,'dev'),(2,'test'),(3,'scrum master'),(4,'PM'),(5,'developer');
-- Table 3: Account
--  AccountID: định danh của User (auto increment)
--  Email:
--  Username:
--  FullName:
--  DepartmentID: phòng ban của user trong hệ thống
--  PositionID: chức vụ của User
--  CreateDate: ngày tạo tài khoản
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account`(
	`account_id`		TINYINT AUTO_INCREMENT PRIMARY KEY NOT NULL, -- khoá chính account
	`email`				VARCHAR(50) UNIQUE NOT NULL, -- không trùng 
	user_name			VARCHAR(20) UNIQUE NOT NULL, -- không trùng
	full_name			VARCHAR(30) NOT NULL, 
	department_id		TINYINT NOT NULL, -- khoá ngoại
	position_id			TINYINT NOT NULL, -- khoá ngoại
	create_date			DATE,
    FOREIGN KEY (position_id) REFERENCES `position`(position_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (department_id) REFERENCES department(department_id) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO `account`(account_id,email,user_name,full_name,department_id,position_id,create_date) 
values(1,'trautre@mail.com','trâu','trâu trẻ',3,2,'2021-03-22'),
(2,'daodich@mail.com','dao','giao vịt',4,1,'2021-04-21'),
(3,'loncoi@mail.com','lợn','lợn coi',5,3,'2021-05-22'),
(4,'gauden@mail.com','gấu','gấu đen',5,2,'2021-07-22'),
(5,'meocon@mail.com','mèo','mèo con',3,5,'2021-06-22'),
(6,'chuotnhat@mail.com','chuột','chuột nhắt',3,2,'2021-09-22'),
(7,'gari@mail.com','gà','gà ri',3,3,'2021-06-03'),
(8,'tinhtinh@mail.com','tinh','tinh tinh',7,4,'2021-09-12'),
(9,'hobao@mail.com','hổ','hổ báo',4,3,'2021-09-02'),
(10,'thotrang@mail.com','tho','thỏ trắng',1,5,'2021-09-22');
-- Table 4: Group
--  GroupID: định danh của nhóm (auto increment)
--  GroupName: tên nhóm
--  CreatorID: id của người tạo group
--  CreateDate: ngày tạo group
DROP TABLE IF EXISTS `group`;
create table `group`(
	`group_id`			TINYINT NOT NULL AUTO_INCREMENT PRIMARY KEY, -- khoá chính gruop
	group_name			VARCHAR(50) UNIQUE NOT NULL, -- tên nhóm không trùng
	creator_id			TINYINT NOT NULL, 
	create_date			DATE,
    FOREIGN KEY (creator_id) REFERENCES `account` (`account_id`) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO `group`(`group_id`,group_name,creator_id,create_date) 

values(1,'gruop1',2,'2021/03/22'),
(2,'gruop2',5,'2020/03/22'),
(3,'gruop3',6,'2019/03/22'),
(4,'gruop4',4,'2012/03/22'),
(5,'gruop5',1,'2014/03/22'),
(6,'gruop6',2,'2013/03/22'),
(7,'gruop7',1,'2015/03/22'),
(8,'gruop8',9,'2018/03/22'),
(9,'gruop9',5,'2019/03/22'),
(10,'gruop10',4,'2021/03/22');
-- Table 5: GroupAccount
--  GroupID: định danh của nhóm
--  AccountID: định danh của User
--  JoinDate: Ngày user tham gia vào nhóm
DROP TABLE IF EXISTS `group_account`;
create table `group_account`(
	`group_id`			TINYINT NOT NULL,
	account_id			TINYINT NOT NULL,
	join_date			DATE,
    PRIMARY KEY(group_id,account_id),
    FOREIGN KEY (group_id) REFERENCES `group`(group_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (account_id) REFERENCES account(account_id) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO `group_account`(`group_id`,account_id,join_date) 
values(1,3,'2021/03/22'),(2,8,'2021/03/22'),(3,1,'2021/03/22'),(4,5,'2021/03/22'),(5,6,'2021/03/22'),
(6,8,'2021/03/22'),(7,10,'2021/03/22'),(8,9,'2021/03/22'),(9,8,'2021/03/22'),(10,4,'2021/03/22');
-- Table 6: TypeQuestion
--  TypeID: định danh của loại câu hỏi (auto increment)
--  TypeName: tên của loại câu hỏi (Essay, Multiple-Choice)
DROP TABLE IF EXISTS type_question;
create table type_question(
	type_id				TINYINT AUTO_INCREMENT PRIMARY KEY, --  khoá chính typequestion
	`type_name`			ENUM('essay','multiple-choice') -- chỉ là essay và multiple-choice
);
INSERT INTO `type_question`(`type_id`,`type_name`) 
values(1,'essay'),(2,'multiple-choice');
-- Table 7: CategoryQuestion
--  CategoryID: định danh của chủ đề câu hỏi (auto increment)
--  CategoryName: tên của chủ đề câu hỏi (Java, .NET, SQL, Postman, Ruby,...)
DROP TABLE IF EXISTS category_question;
create table category_question(
	category_id			TINYINT AUTO_INCREMENT PRIMARY KEY NOT NULL, --  khoá chính categoryquestion
	category_name		VARCHAR(10)  NOT NULL UNIQUE
);
INSERT INTO `category_question`(`category_id`,`category_name`) 
values(1,'JAVA'),(2,'SQL'),(3,'NET'),(4,'RUBY'),(5,'HTML'),
(6,'C++'),(7,'C#'),(8,'JS'),(9,'CSS'),(10,'WP');
-- Table 8: Question
--  QuestionID: định danh của câu hỏi (auto increment)
--  Content: nội dung của câu hỏi
--  CategoryID: định danh của chủ đề câu hỏi
--  TypeID: định danh của loại câu hỏi
--  CreatorID: id của người tạo câu hỏi
--  CreateDate: ngày tạo câu hỏi
DROP TABLE IF EXISTS question;
create table question(
	question_id 		TINYINT AUTO_INCREMENT PRIMARY KEY NOT NULL, -- khoá chính câu hỏi
	content				VARCHAR(255) NOT NULL, -- nội dung câu hỏi
	category_id			TINYINT NOT NULL, -- khoá ngoại
	type_id				TINYINT NOT NULL, -- khoá ngoại
	creator_id			TINYINT NOT NULL, 
	create_day			DATE, 
    FOREIGN KEY (creator_id) REFERENCES `account`(`account_id`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (category_id) REFERENCES category_question(category_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (type_id) REFERENCES type_question(type_id) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO `question`(`question_id`,`content`,category_id,type_id,creator_id,create_day) 
values(1,'SQL la gi?', 3,3,3,'2021/10/10'),
(2,'SQL de lam gi?', 3,4,5,'2021/10/10'),
(3,'C++ su dung ra sao?', 1,4,5,'2021/10/10'),
(4,'HTML su dung ra sao?', 1,4,7,'2021/10/10'),
(5,'CSS su dung ra sao?', 1,2,5,'2021/10/10'),
(6,'cau hoi JS su dung ra sao?', 5,4,5,'2021/10/10'),
(7,'JS de lam gi?', 1,9,5,'2021/10/10'),
(8,'C++ la gi?', 1,4,9,'2021/10/10'),
(9,'C++ su dung ra sao?', 3,7,5,'2021/10/10'),
(10,'C++ ai su dung?', 6,4,2,'2021/10/10');

-- Table 9: Answer
--  AnswerID: định danh của câu trả lời (auto increment)
--  Content: nội dung của câu trả lời
--  QuestionID: định danh của câu hỏi
--  isCorrect: câu trả lời này đúng hay sai
DROP TABLE IF EXISTS answer;
CREATE TABLE answer (
    answer_id 			TINYINT AUTO_INCREMENT PRIMARY KEY NOT NULL, -- khoá chính answer
    content 			VARCHAR(500) NOT NULL,
    question_id 		TINYINT NOT NULL,
    is_correct 			BOOLEAN
);
INSERT INTO `answer`(answer_id,content,question_id,is_correct) 
values(1,'biet roi',9,1),(2,'khong biet',9,1),(3,'biet',9,0),(4,'vui',1,0),(5,'buon',6,0),(6,'chua biet',9,1),(7,'khong biet',9,1),(8,'biet',4,0),(9,'buon cuoi',9,0),(10,'khoc',8,0);
-- Table 10: Exam
--  ExamID: định danh của đề thi (auto increment)
--  Code: mã đề thi
--  Title: tiêu đề của đề thi
--  CategoryID: định danh của chủ đề thi
--  Duration: thời gian thi
--  CreatorID: id của người tạo đề thi
--  CreateDate: ngày tạo đề thi
DROP TABLE IF EXISTS exam;
create table exam(
	exam_id				TINYINT AUTO_INCREMENT PRIMARY KEY NOT NULL, -- khoá chính exam
	`code`				VARCHAR(8) NOT NULL UNIQUE, 
	title				VARCHAR(250) NOT NULL,
	category_id			VARCHAR(50) NOT NULL, 
	duration			TINYINT NOT NULL,
	creator_id			TINYINT NOT NULL,
	create_date			DATE
);
INSERT INTO `exam`(exam_id,`code`,title,category_id,duration,creator_id,create_date) 
values(1,'abc111','bai thi TIN HOC',3,60,1,'2021-10-19'),
(2,'abc222','bai thi SQL',3,60,1,'2012-10-19'),
(3,'abc333','bai thi Word',1,90,1,'2015-10-19'),
(4,'abc444','bai thi eccel',1,120,1,'2021-10-19'),
(5,'abc555','bai thi HTML',3,30,1,'2021-10-19'),
(6,'abc666','bai thi JS',3,15,1,'2018-10-19'),
(7,'abc777','bai thi CSS',3,45,1,'2021-10-19'),
(8,'abc888','bai thi C++',3,45,1,'2021-10-19'),
(9,'abc999','bai thi JAVA',1,75,1,'2021-10-19'),
(10,'abc101','bai thi PYTHON',1,60,1,'2021-10-19');
-- Table 11: ExamQuestion
--  ExamID: định danh của đề thi
--  QuestionID: định danh của câu hỏi
DROP TABLE IF EXISTS exam_question;
create table exam_question(
	exam_id				TINYINT NOT NULL,
	question_id			TINYINT NOT NULL,
    FOREIGN KEY (question_id) REFERENCES question(question_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (exam_id) REFERENCES `exam`(exam_id) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO exam_question(exam_id,question_id) 
values(1,10),(2,9),(3,8),(4,7),(5,6),(6,10),(7,4),(8,3),(9,10),(10,1);