-- Exercise 1: Tiếp tục với Database quản lý Fresher
use fresher_training_management;
-- Question 1: Thêm ít nhất 10 bản ghi vào tables
SELECT* FROM trainee;
INSERT INTO trainee(trainee_id,full_name,birth_date,gender,et_eq,et_gmath,et_english, training_class,evaluation_notes, VTI_account)
values
	(1, 'Ung Hoang Phuc','1980-01-01', 'male', 15, 15, 40, 'ca si', 'hat hay','VTI001'),
	(2, 'Dam Vinh Hung','1980-04-04', 'male', 13, 19, 45, 'ca si', 'hat hay','VTI002'),
    (3, 'Son Tung','1994-01-18', 'male', 19, 15, 20, 'ca si', 'hat hay','VTI003'),
    (4, 'Soobin','1992-07-01', 'male', 18, 15, 30, 'ca si', 'hat hay','VTI004'),
    (5, 'Min','1996-05-01', 'female', 15, 15, 25, 'ca si', 'hat hay','VTI005'),
    (6, 'Xuan Bac','1975-01-06', 'male', 20, 15, 35, 'dien vien', 'noi gioi','VTI006'),
    (7, 'Hoai Linh','1982-03-21', 'male', 15, 20, 40, 'dien vien hai', 'dien gioi','VTI007'),
    (8, 'Vo Hoang Yen','1990-01-01', 'female', 15, 10, 20, 'nguoi mau', 'nguoi dep mat dep','VTI008'),
    (9, 'Pham Nhat Vuong','1970-04-01', 'male', 20, 20, 50, 'doanh nhan', 'giau','VTI009'),
    (10, 'My Ling','1980-10-01', 'female', 20, 15, 35, 'ca si', 'hat hay','VTI010');
-- Question 2: Viết lệnh để lấy ra tất cả các thực tập sinh đã vượt qua bài test đầu vào, nhóm chúng thành các tháng sinh khác nhau
SELECT* FROM trainee;
SELECT full_name, month(birth_date) AS "tháng sinh" FROM trainee ORDER BY month(birth_date);
-- Question 3: Viết lệnh để lấy ra thực tập sinh có tên dài nhất, lấy ra các thông tin sau: tên, tuổi, các thông tin cơ bản (như đã được định nghĩa trong table)
SELECT* FROM trainee;
SELECT* FROM trainee WHERE length(full_name) = (SELECT max(length(full_name)) FROM trainee);
-- Question 4: Viết lệnh để lấy ra tất cả các thực tập sinh là ET, 1 ET thực tập sinh lànhững người đã vượt qua bài test đầu vào và thỏa mãn số điểm như sau:
--  ET_IQ + ET_Gmath>=20
--  ET_IQ>=8
--  ET_Gmath>=8
--  ET_English>=18
SELECT* FROM trainee;
-- Question 5: xóa thực tập sinh có TraineeID = 3
SELECT* FROM trainee;
DELETE FROM trainee WHERE trainee_id=3;
-- Question 6: Thực tập sinh có TraineeID = 5 được chuyển sang lớp "2". Hãy cập nhật thông tin vào database
UPDATE trainee SET training_class="2" WHERE trainee_id= 5;