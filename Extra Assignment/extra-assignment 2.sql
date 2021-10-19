
-- Exercise 1:Design a table
DROP DATABASE IF EXISTS Fresher_Training_Management;
CREATE DATABASE Fresher_Training_Management;
use Fresher_Training_Management;
-- Ta có database để quản lý fresher, có table Trainee với các trường như sau:
CREATE TABLE trainee (
--  TraineeID: định danh của thực tập sinh (auto increment)
	trainee_id 		TINYINT AUTO_INCREMENT PRIMARY KEY,
--  Full_Name: tên đầy đủ của thực tập sinh
	full_name		VARCHAR(50) NOT NULL,
--  Birth_Date: ngày sinh của thực tập sinh
	birth_date		DATE NOT NULL,
--  Gender: chỉ có 3 giá trị male, female, and unknown
	gender			ENUM('Male','Female','Unknow'),
--  ET_IQ: Entry test point (IQ) - Điểm test đầu vào của thực tập sinh (integer cógiá trị từ 0  20)
	et_eq			INT CHECK(0<=et_eq AND et_eq<=20),
--  ET_Gmath: Entry test point (Gmath) - Điểm test đầu vào của thực tập sinh (integer có giá trị từ 0  20)
	et_gmath		INT check(0<=et_gmath AND et_gmath<=20),
--  ET_English: Entry test point (English) - Điểm test đầu vào của thực tập sinh (integer có giá trị từ 0  50)
	et_english		INT check(0<=et_english AND et_english<=50),
--  Training_Class: mã lớp của thực tập sinh đang học
	training_class	VARCHAR(8),
--  Evaluation_Notes: 1 vài note đánh giá (free text).
	evaluation_notes VARCHAR(255)
);
-- Question 1: Tạo table với các ràng buộc và kiểu dữ liệu
-- Question 2: thêm trường VTI_Account với điều kiện not null & unique
-- Chú ý: chú tới tới các best practice
ALTER TABLE trainee ADD `VTI_Account` varchar(50) not null ;
-- Exercise 2: Data Types
DROP DATABASE IF EXISTS Exercise_2;
CREATE DATABASE Exercise_2;
USE Exercise_2;
CREATE TABLE data_types(
-- Bảng bên dưới sẽ có ít nhất 1 triệu bản ghi, có chứa các thông tin sau:
-- Bạn phải chọn 1 kiểu dữ liệu phù hợp để tối ưu không gian lưu trữ mỗi hàng của bảng
-- Column Description
-- ID Primary Key, mỗi lần insert 1 bản ghi mới thì ID sẽ tăng lên 1
	ID 		MEDIUMINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
-- Name 1 chuỗi bằng tiếng anh
	`name`	VARCHAR(20),
-- Code Có 5 ký tự là alphanumeric code
	`code` 	VARCHAR(5),
-- ModifiedDate Thời gian của lần sửa đổi cuối cùng (Datatime)
	modified_date 	DATE
    );
-- Exercise 3: Data Types (2)
DROP DATABASE IF EXISTS Exercise_3;
CREATE DATABASE Exercise_3;
USE Exercise_3;
CREATE TABLE data_types_2(
-- ID Primary Key, mỗi lần insert 1 bản ghi mới thì ID sẽ tăng lên 1
	ID 		MEDIUMINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
-- Name 1 chuỗi bằng tiếng anh
	`name` 	VARCHAR(20),
-- BirthDate Ngày sinh nhật
	`birthday` DATE,
-- Gender Là Integer gồm 3 giá trị: 0 là Male, 1là Female, NULL là Unknown
	gender ENUM('0','1','unknow'),
-- IsDeletedFlag Có 2 giá trì: 0 là đang hoạt động, 1 là đã xóa.
	is_delete_flag ENUM('0','1')
);
