-- Question 2: lấy ra tất cả các phòng ban
select department_name from department;
-- Question 3: lấy ra id của phòng ban "Sale"
select department_id from department where department_name='sale';
-- Question 4: lấy ra thông tin account có full name dài nhất
SELECT * FROM `account` WHERE length(full_name) = (SELECT max(LENGTH(full_name)) FROM `account`);
-- Question 5: Lấy ra thông tin account có full name dài nhất và thuộc phòng ban có id = 3
SELECT * FROM `account` WHERE length(full_name) = (SELECT max(LENGTH(full_name)) FROM `account`) AND department_id=3;
-- Question 6: Lấy ra tên group đã tham gia trước ngày 20/12/2019
SELECT * FROM `group`;
SELECT group_name FROM `group` WHERE create_date < '2019-12-20';
-- Question 7: Lấy ra ID của question có >= 4 câu trả lời
SELECT * FROM `answer`;
SELECT question_id FROM `answer` GROUP BY  question_id HAVING count(question_id)>4;
-- Question 8: Lấy ra các mã đề thi có thời gian thi >= 60 phút và được tạo trước ngày 20/12/2019
SELECT * FROM `exam`;
SELECT `code` FROM `exam` WHERE duration > 60;
-- Question 9: Lấy ra 5 group được tạo gần đây nhất
SELECT * FROM `group`;
SELECT group_name FROM `group` order by create_date desc limit 5;
-- Question 10: Đếm số nhân viên thuộc department có id = 2
SELECT * FROM `department`;
SELECT count(department_id) FROM department GROUP BY department_id HAVING department_id=2;
-- Question 11: Lấy ra nhân viên có tên bắt đầu bằng chữ "D" và kết thúc bằng chữ "o"
SELECT * FROM `account`;
SELECT user_name FROM `account` WHERE user_name LIKE 'D%o';
-- Question 12: Xóa tất cả các exam được tạo trước ngày 20/12/2019
SELECT * FROM `exam`;
DELETE FROM `exam` WHERE create_date < '2019-12-20';
-- Question 13: Xóa tất cả các question có nội dung bắt đầu bằng từ "câu hỏi"
SELECT * FROM `question`;
DELETE FROM `question` WHERE content LIKE 'cau hoi%';
-- Question 14: Update thông tin của account có id = 5 thành tên "Nguyễn Bá Lộc" và email thành loc.nguyenba@vti.com.vn
SELECT * FROM `account`;
UPDATE `account` SET full_name= 'Nguyễn Bá Lộc', email='loc.nguyenba@vti.com.vn'
WHERE	account_id = 5;
-- Question 15: update account có id = 5 sẽ thuộc group có id = 4
UPDATE `account` SET account_id = 11
WHERE	account_id = 5;