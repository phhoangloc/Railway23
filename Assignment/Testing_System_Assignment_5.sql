-- Exercise 1: Tiếp tục với Database Testing System
-- (Sử dụng subquery hoặc CTE)
-- Question 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale
create view question1 as (
SELECT full_name fn, d.department_name
FROM `account` a
LEFT JOIN `department` d
ON a.department_id=d.department_id
WHERE d.department_name= "sale");
-- Question 2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất 
select * from `group_account`;
create view question2 as (
select a.full_name, count(a.full_name)
from `account` a
right join `group_account` ga
on a.account_id=ga.account_id
group by a.full_name
having count(a.full_name) = (select max(cou_a)
							from (select count(a.full_name) as cou_a
									from `account` a
									right join `group_account` ga
									on a.account_id=ga.account_id
									group by a.full_name ) max )
);
-- Question 3: Tạo view có chứa câu hỏi có những content quá dài (content quá 300 từ được coi là quá dài) và xóa nó đi
select * from `question`;
delete
from `question`
where length(content)>300;
-- Question 4: Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất 
-- Question 5: Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo
-- Chú ý:
--  Viết đúng coding convention
--  Tuần thủ các best practice
--  Không chép bài người khác (sẽ có hình thức phạt nếu bị phát hiện)