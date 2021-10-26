use testing_system;
-- Exercise 1: Tiếp tục với Database Testing System
-- (Sử dụng subquery hoặc CTE)
-- Question 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale
drop view IF EXISTS v_question1;
create view v_question1 as (
SELECT full_name fn, d.department_name
FROM `account` a
LEFT JOIN `department` d
ON a.department_id=d.department_id
WHERE d.department_name= "sale");
-- Question 2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất 
drop view IF EXISTS v_question2;
create view v_question2 as (
select a.full_name, count(ga.account_id)
from `account` a
right join `group_account` ga
on a.account_id=ga.account_id
group by a.full_name
having count(a.account_id) = (select max(cou_a)
							from (select count(a.account_id) as cou_a
									from `account` a
									right join `group_account` ga
									on a.account_id=ga.account_id
									group by a.full_name ) max )
);
-- Question 3: Tạo view có chứa câu hỏi có những content quá dài (content quá 300 từ được coi là quá dài) và xóa nó đi
<<<<<<< HEAD
select * from `question`;
drop view IF EXISTS v_question3;
CREATE view v_question3 as (
select q.content
from `question` q
where (LENGTH(content) - LENGTH(REPLACE(content, ' ', '')) + 1 < 300)
);
delete from v_question3;


-- Question 4: Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất 
drop view IF EXISTS v_question4;
CREATE view v_question4 as (
	select d.department_name,count(d.department_id)
	FROM `account` a
	RIGHT JOIN `department` d
	ON a.department_id=d.department_id
    group by d.department_id
	having count(d.department_id)=(
		select max(cnum) 
        from(select count(a.department_id) cnum
			FROM `account` a
			RIGHT JOIN `department` d
			ON a.department_id=d.department_id
            group by a.department_id) tbl)
);
-- Question 5: Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo
drop view IF EXISTS v_question5;
CREATE view v_question5 as (
	select q.content
    from question q
    left join account a
    on q.creator_id = a.account_id
    where a.full_name like 'Nguyễn%'
    );
-- Chú ý:
--  Viết đúng coding convention
--  Tuần thủ các best practice
--  Không chép bài người khác (sẽ có hình thức phạt nếu bị phát hiện)
=======

select content
from `question`
where length(content)>300;

-- Question 4: Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất 
-- Question 5: Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo
>>>>>>> d2ccc2364894f7e5ff7737b23471b2bfbc7ba14c
