-- Exercise 1: Join
use testing_system;
-- Question 1: Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ
SELECT a.full_name,d.*
FROM `account` a
JOIN `department` d
ON a.department_id=d.department_id;


-- Question 2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010 
SELECT*FROM`account`;
SELECT*FROM`account`
WHERE create_date > '2010-12-20';


-- Question 3: Viết lệnh để lấy ra tất cả các developer 
SELECT a.full_name
FROM `account` a
JOIN `position` p
ON a.position_id=p.position_id 
WHERE p.position_name ='dev';


-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
SELECT*FROM`department`;
SELECT (d.department_name)
FROM `account` a
JOIN `department` d
ON a.department_id=d.department_id 
GROUP BY (d.department_id) 
HAVING count(d.department_id)>3;


-- Question 5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất
SELECT*FROM`question`;
SELECT*FROM`exam_question`;
select q.*
from question q 
join exam_question eq
on q.question_id=eq.question_id
group by (q.question_id)
having count(eq.exam_id) =(select max(count_exam)
							from (
									select count(eq.exam_id) count_exam
									from question q 
									join exam_question eq
									on q.question_id=eq.question_id
									group by (q.question_id)
                                    ) tbl
							);
                            
                            
-- Question 6: Thông kê mỗi category Question được sử dụng trong bao nhiêu Question 
SELECT*FROM`category_question`;
SELECT*FROM`question`;
SELECT cq.category_name,count(q.question_id)
FROM`category_question` cq
left JOIN `question` q
ON cq.category_id = q.category_id
group by cq.category_id;


-- Question 7: Thông kê mỗi Question được sử dụng trong bao nhiêu Exam
SELECT*FROM`exam_question`;
SELECT*FROM`question`;
SELECT*FROM`exam`;
SELECT q.content, count(eq.question_id) AS 'duoc su dung trong exam' 
FROM `question` q
LEFT JOIN `exam_question` eq
ON eq.question_id=q.question_id
group by q.question_id ;


-- Question 8: Lấy ra Question có nhiều câu trả lời nhất  
-- chưa lấy ra được câu hỏi có nhiều câu trả lời nhất
SELECT* from question;
SELECT* from answer;
SELECT `question`.content 'cau hoi' ,count(`question`.question_id) AS counter
FROM `question` 
JOIN `answer` 
ON `question`.question_id=`answer`.question_id 
GROUP BY (`question`.question_id)
HAVING counter = (SELECT max(counter) 
				FROM 
				(SELECT count(`answer`.question_id) AS counter
				FROM `answer` 
				GROUP BY (`answer`.question_id)) tbl);
                
                
                
-- Question 9: Thống kê số lượng account trong mỗi group  
SELECT*FROM`group`;
SELECT*FROM`account`;
SELECT*FROM`group_account`;
SELECT g.group_name , count(ga.account_id) 'số lượng account'
FROM `group` g
right JOIN `group_account` ga
ON ga.group_id=g.group_id
GROUP BY (g.group_id);



-- Question 10: Tìm chức vụ có ít người nhất)

SELECT * FROM position;
SELECT * FROM `account`;
SELECT position.position_name, count(`account`.account_id) as nor 
FROM `position` 
RIGHT JOIN `account` 
ON `account`.position_id=`position`.position_id 
GROUP BY(`account`.position_id) 
having nor = (select min(nor) from(
	SELECT count(`account`.position_id) as nor 
	FROM `position` 
	LEFT JOIN `account` 
	ON `account`.position_id=`position`.position_id 
	GROUP BY(`account`.position_id) 
    ) tbl);
    
-- ** Question 11: Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM -- chưa lọc được ra bao nhiêu dev,test...
SELECT * FROM `department`;
SELECT * FROM `position`;
SELECT * FROM `account`;

SELECT acc.department_id, COUNT(acc.position_id) 'Số chức vụ', p.position_name
		FROM department dept 
			JOIN `account` acc ON dept.department_id = acc.department_id
			JOIN `position` p ON acc.position_id = p.position_id 
            WHERE p.position_name IN('Dev', 'Test','Scrum Master','PM')
			GROUP BY acc.department_id, p.position_name;

    
-- Question 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của question, 
-- loại câu hỏi, 
-- ai là người tạo ra câu hỏi, câu trả lời là gì, …

select * from question;

select * from type_question;

select * from category_question;

SELECT q.question_id, q.content 'câu hỏi', 
		t.type_name 'dạng câu hỏi' ,
		a.full_name 'người tạo' ,
		an.content 'trả lời',
        cq.category_name 'loại câu hỏi'
	FROM question q
	LEFT JOIN type_question t ON q.type_id = t.type_id
	LEFT JOIN `account` a ON q.creator_id = a.account_id
	LEFT JOIN answer an ON q.question_id = an.question_id
    LEFT JOIN category_question cq  ON cq.category_id = q.category_id ;


-- Question 13: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm
SELECT type_question.type_name 'dạng câu hỏi', count(type_question.type_name)
	FROM question 
	right JOIN type_question 
	ON question.type_id = type_question.type_id
    GROUP BY (type_question.type_name);
    
    
-- Question 14:Lấy ra group không có account nào
SELECT * FROM `group`;
SELECT * FROM `group_account`;
SELECT g.group_name, g.group_id
	FROM `group` g
    LEFT JOIN `group_account` ga
    ON g.group_id = ga.group_id
    WHERE ga.account_id IS NULL;
-- Question 16: Lấy ra question không có answer nào
SELECT * FROM `answer`;
SELECT question.content
	FROM `question` 
    LEFT JOIN `answer` 
    ON `question`.question_id = `answer`.question_id
    WHERE `answer`.content IS NULL;
    
    
    
-- Exercise 2: Union
-- Question 17: 
-- a) Lấy các account thuộc nhóm thứ 1
SELECT `account`.full_name
FROM  `account`
JOIN  `group_account`
ON `account`.account_id = `group_account`.account_id
WHERE `group_account`.group_id=1;
-- b) Lấy các account thuộc nhóm thứ 2
SELECT*FROM`account`;
SELECT*FROM`group_account`;
SELECT `account`.full_name
FROM  `account`
JOIN  `group_account`
ON `account`.account_id = `group_account`.account_id
WHERE `group_account`.group_id=2;
-- c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau
SELECT*FROM`account`;
SELECT*FROM`group_account`;
SELECT `account`.full_name
FROM  `account`
JOIN  `group_account`
ON `account`.account_id = `group_account`.account_id
WHERE `group_account`.group_id=1
UNION 
SELECT `account`.full_name
FROM  `account`
JOIN  `group_account`
ON `account`.account_id = `group_account`.account_id
WHERE `group_account`.group_id=2;




-- Question 18: 
-- a) Lấy các group có lớn hơn 5 thành viên
select*from`account`;
select*from`group_account`;
select*from`group`;
select g.group_id,count(ga.account_id)
from `group` g
join `group_account`ga
on 	 g.group_id = ga.group_id
group by (g.group_id)
having count(ga.account_id)>5;
-- b) Lấy các group có nhỏ hơn 7 thành viên
select g.group_id,count(ga.account_id)
from `group` g
right join `group_account`ga
on 	 g.group_id = ga.group_id
group by (g.group_id)
having count(ga.account_id)<7;
-- c) Ghép 2 kết quả từ câu a) và câu b)
select g.group_id,count(ga.account_id)
from `group` g
right join `group_account`ga
on 	 g.group_id = ga.group_id
group by (g.group_id)
having count(ga.account_id)>5
union all
select g.group_id,count(ga.account_id)
from `group` g
right join `group_account`ga
on 	 g.group_id = ga.group_id
group by (g.group_id)
having count(ga.account_id)<7;