-- Exercise 1: Join
use testing_system;
-- Question 1: Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ
SELECT `account`.full_name,`department`.department_name 
FROM `account` 
JOIN `department` 
ON `account`.department_id=`department`.department_id;
-- Question 2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010 
SELECT*FROM`account`;
SELECT*FROM`account`WHERE create_date < '2020-12-20';
-- Question 3: Viết lệnh để lấy ra tất cả các developer 
SELECT `account`.full_name,`position`.position_name 
FROM `account`
JOIN `position` ON `account`.position_id=`position`.position_id 
WHERE `position`.position_name ='developer';
-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
SELECT*FROM`department`;
SELECT (`department`.department_name), count(`department`.department_name) 
FROM `account`
JOIN `department` 
ON `account`.department_id=`department`.department_id 
GROUP BY (`department`.department_name) 
HAVING count(`department`.department_name)>3;
-- Question 5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất
SELECT*FROM`question`;
SELECT content, count(content)
FROM `question` 
GROUP BY (content) ORDER BY count(content) DESC;
-- Question 6: Thông kê mỗi category Question được sử dụng trong bao nhiêu Question 
SELECT*FROM`category_question`;
SELECT*FROM`question`;
SELECT `category_question`.category_name,count(`question`.category_id) 'được sử dụng trong question' 
FROM`question` RIGHT JOIN `category_question` 
ON `question`.category_id = `category_question`.category_id 
GROUP BY (`category_question`.category_name);
-- Question 7: Thông kê mỗi Question được sử dụng trong bao nhiêu Exam
SELECT*FROM`exam`;
SELECT*FROM`question`;
SELECT `question`.question_id,`question`.content, count(`exam_question`.question_id) AS 'duoc su dung trong exam' 
FROM `question` 
LEFT JOIN `exam_question` 
ON `question`.question_id=`exam_question`.question_id 
GROUP BY (`exam_question`.question_id);
-- Question 8: Lấy ra Question có nhiều câu trả lời nhất  
-- chưa lấy ra được câu hỏi có nhiều câu trả lời nhất
SELECT* from question;
SELECT `question`.content 'cau hoi' ,count(`question`.content) AS counter
FROM `question` 
JOIN `answer` 
ON `question`.question_id=`answer`.question_id 
GROUP BY (`question`.content)
HAVING counter = (SELECT max(counter) 
				FROM 
				(SELECT count(`question`.content) AS counter
				FROM `question` 
				JOIN `answer` 
				ON `question`.question_id=`answer`.question_id 
				GROUP BY (`question`.content)) tbl);
-- Question 9: Thống kê số lượng account trong mỗi group  
SELECT*FROM`group`;
SELECT*FROM`account`;
SELECT*FROM`group_account`;
SELECT `group`.group_name , count(`account`.full_name) 
FROM `group` 
JOIN `account` 
ON `account`.account_id=`group`.creator_id 
GROUP BY (`group`.group_name );
-- Question 10: Tìm chức vụ có ít người nhất min(count))
SELECT * FROM position;
SELECT * FROM `account`;
SELECT position.position_name, count(`account`.position_id) as nor 
FROM `position` 
JOIN `account` 
ON `account`.position_id=`position`.position_id 
GROUP BY(`account`.position_id) 
having nor = (select min(nor) from(
	SELECT count(`account`.position_id) as nor 
	FROM `position` 
	JOIN `account` 
	ON `account`.position_id=`position`.position_id 
	GROUP BY(`account`.position_id) 
    ) tbl);
-- ** Question 11: Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM -- chưa lọc được ra bao nhiêu dev,test...
SELECT * FROM `department`;
SELECT * FROM `position`;
SELECT * FROM `account`;
SELECT department_name, `position`.position_name
	FROM `position`
    JOIN (SELECT`department`.department_name,`account`.position_id
			FROM `department`
			JOIN `account`
			ON 	`department`.department_id=`account`.department_id
            ) as tbl
	ON `position`.position_id = tbl.position_id
    ORDER BY (department_name);
-- Question 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, …
select * from question;
select * from type_question;
SELECT question.question_id, question.content 'câu hỏi', type_question.type_name 'dạng câu hỏi' ,`account`.full_name 'người tạo' ,answer.content 'trả lời'
	FROM question 
	JOIN type_question ON question.type_id = type_question.type_id
	LEFT JOIN `account` ON question.creator_id = account.account_id
	left  JOIN answer ON question.question_id = answer.question_id;
-- Question 13: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm
SELECT type_question.type_name 'dạng câu hỏi', count(type_question.type_name)
	FROM question 
	JOIN type_question 
	ON question.type_id = type_question.type_id
    GROUP BY (type_question.type_name);
-- Question 14:Lấy ra group không có account nào
SELECT * from `group`;
SELECT group_name, full_name 
	from `group` 
    left join `account` 
    on `group`.creator_id = `account`.account_id
    WHERE full_name = null;
-- Question 16: Lấy ra question không có answer nào
SELECT * from `answer`;
SELECT question.content
	from `question` 
    left join `answer` 
    on `question`.question_id = `answer`.question_id
    where `answer`.content IS NULL;
-- Exercise 2: Union
-- Question 17: 
-- a) Lấy các account thuộc nhóm thứ 1
-- b) Lấy các account thuộc nhóm thứ 2
-- c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau
-- Question 18: 
-- a) Lấy các group có lớn hơn 5 thành viên
-- b) Lấy các group có nhỏ hơn 7 thành viên
-- c) Ghép 2 kết quả từ câu a) và câu b)