-- Exercise 1: Join
use testing_system;
-- Question 1: Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ
SELECT `account`.full_name,`position`.position_name FROM `account`,`position` WHERE `account`.position_id=`position`.position_id;
-- Question 2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010 
SELECT*FROM`account`;
SELECT*FROM`account`WHERE create_date < '2010-12-20';
-- Question 3: Viết lệnh để lấy ra tất cả các developer 
SELECT `account`.full_name,`position`.position_name FROM `account`,`position` WHERE `account`.position_id=`position`.position_id AND `position`.position_name ='developer';
-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
SELECT*FROM`department`;
SELECT `account`.full_name,`department`.department_name FROM `account`,`department`  WHERE `account`.department_id=`department`.department_id;
SELECT (`department`.department_name), count(`department`.department_name) from `account`,`department` 
WHERE `account`.department_id=`department`.department_id GROUP BY (`department`.department_name) HAVING count(`department`.department_name)>3;
-- Question 5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất
SELECT*FROM`question`;
SELECT content, count(content)
FROM `question`
GROUP BY (content) ;
-- Question 6: Thông kê mỗi category Question được sử dụng trong bao nhiêu Question
-- Question 7: Thông kê mỗi Question được sử dụng trong bao nhiêu Exam
-- Question 8: Lấy ra Question có nhiều câu trả lời nhất
-- Question 9: Thống kê số lượng account trong mỗi group 
-- Question 10: Tìm chức vụ có ít người nhất
-- Question 11: Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM
-- Question 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của 
--  question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, …
-- Question 13: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm
-- Question 14:Lấy ra group không có account nào
-- Question 15: Lấy ra group không có account nào
-- Question 16: Lấy ra question không có answer nào
-- Exercise 2: Union
-- Question 17: 
-- a) Lấy các account thuộc nhóm thứ 1
-- b) Lấy các account thuộc nhóm thứ 2
-- c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau
-- Question 18: 
-- a) Lấy các group có lớn hơn 5 thành viên
-- b) Lấy các group có nhỏ hơn 7 thành viên
-- c) Ghép 2 kết quả từ câu a) và câu b)