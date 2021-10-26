
 USE testing_system;
-- Exercise 1: Join
-- Question 1: Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ
SELECT * FROM `account`;
SELECT * FROM `department`;

SELECT a.full_name, d.*
	FROM `account` a
	JOIN `department` d
	ON a.department_id = d.department_id;
                
                
-- Question 2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010 
SELECT * FROM `account`;
SELECT *
	FROM `account`
	WHERE create_date < '2010-12-20'
;

-- Question 3: Viết lệnh để lấy ra tất cả các developer 
SELECT * FROM `position`;
SELECT * FROM `account`;

SELECT a.full_name, p.position_name
	FROM `account` a
	JOIN `position` p
	ON a.position_id = p.position_id
	WHERE p.position_name = 'dev';


-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
SELECT * FROM department;
SELECT * FROM `account`;

SELECT d.department_name
	FROM `department` d
	JOIN `account`a
	ON d.department_id=a.department_id
	GROUP BY d.department_id
	HAVING	count(d.department_id) >3;
                    
                    
-- Question 5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất
	SELECT* FROM question;
    SELECT * FROM exam;
    SELECT * FROM exam_question; 
    
    SELECT q.content, count(q.question_id)
		FROM question 	q
		LEFT JOIN exam_question eq
		ON q.question_id=eq.question_id
		GROUP BY (q.question_id)
		HAVING count(q.question_id)=(
			SELECT max(cnum) 
			FROM (SELECT count(q.question_id) cnum
				FROM question q
				LEFT JOIN exam_question eq
				ON q.question_id=eq.question_id
				GROUP BY (q.question_id)
                )tbl
			);
                                                    
-- Question 6: Thông kê mỗi category Question được sử dụng trong bao nhiêu Question
	SELECT* FROM category_question;
    SELECT* FROM question;
    SELECT cq.category_name, count(q.question_id)
		FROM category_question cq
			LEFT JOIN question q
				ON cq.category_id=q.category_id
					GROUP BY cq.category_id;

-- Question 7: Thông kê mỗi Question được sử dụng trong bao nhiêu Exam
	SELECT* FROM question;
    SELECT* FROM exam_question;
    SELECT q.content, count(eq.question_id) 'so lan su dung trong exam'
		FROM question q
		LEFT JOIN exam_question eq
		ON q.question_id = eq.question_id
		GROUP BY q.question_id;

-- Question 8: Lấy ra Question có nhiều câu trả lời nhất
SELECT* FROM answer;
	SELECT q.content,count(an.question_id)
	FROM question q
	LEFT JOIN answer an
	ON q.question_id = an.question_id
	GROUP BY q.question_id
    HAVING count(an.question_id)=(SELECT max(cnum) from(
		SELECT count(an.question_id) cnum
        FROM question q
		LEFT JOIN answer an
		ON q.question_id = an.question_id
		GROUP BY q.question_id ) tbl
        );
        
        
-- Question 9: Thống kê số lượng account trong mỗi group 
SELECT* FROM `group_account`;
SELECT * FROM `group`;
	SELECT g.group_name,count(ga.group_id)
	FROM `group` g
    LEFT JOIN `group_account` ga
    ON g.group_id=ga.group_id
    GROUP BY (g.group_id);
		
	
-- Question 10: Tìm chức vụ có ít người nhất
SELECT * FROM `position`;
SELECT * FROM `account`;
	SELECT p.position_name, count(a.position_id) 'số lượng'
	FROM position p
	LEFT JOIN `account` a
	ON p.position_id = a.position_id
		GROUP BY p.position_id
        HAVING count(a.position_id)=(
			SELECT min(cnum) 
            FROM(
                	SELECT count(a.position_id) cnum
					FROM position p
					LEFT JOIN `account` a
					ON p.position_id = a.position_id
					GROUP BY p.position_id) tbl
				);
                
-- Question 11: Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM
SELECT d.department_name, p.position_name, count(p.position_id) 'số người'
	FROM `department` d
    LEFT JOIN `account` a 
    ON d.department_id = a.department_id
    LEFT JOIN `position` p
    ON p.position_id = a.position_id
    GROUP BY d.department_name,p.position_name;

-- Question 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của 
	-- question, 
    -- loại câu hỏi, 
    -- ai là người tạo ra câu hỏi, 
    -- câu trả lời là gì, …
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
	RIGHT JOIN type_question 
	ON question.type_id = type_question.type_id
    GROUP BY (type_question.type_name);
    
    
-- Question 14:Lấy ra group không có account nào
SELECT * from `group`;
SELECT * from `group_account`;
	SELECT g.group_name
	FROM `group` g
    LEFT JOIN `group_account` ga
    ON g.group_id = ga.group_id
    WHERE ga.group_id IS NULL;
    
    
-- Question 16: Lấy ra question không có answer nào
SELECT* FROM question;
SELECT* FROM answer;
	SELECT q.content
	FROM question q
    LEFT JOIN answer an
    ON q.question_id = an.question_id
    WHERE an.content IS NULL;
	
-- Exercise 2: Union
-- Question 17: 
-- a) Lấy các account thuộc nhóm thứ 1
SELECT a.full_name
    FROM `account`a
    JOIN `group_account` ga
    ON a.account_id = ga.account_id
    WHERE ga.group_id = 1;
-- b) Lấy các account thuộc nhóm thứ 2
SELECT a.full_name
    FROM `account`a
    JOIN `group_account` ga
    ON a.account_id = ga.account_id
    WHERE ga.group_id = 2;
-- c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau
SELECT a.full_name
    FROM `account`a
    JOIN `group_account` ga
    ON a.account_id = ga.account_id
    WHERE ga.group_id = 1
    UNION
SELECT a.full_name
    FROM `account`a
    JOIN `group_account` ga
    ON a.account_id = ga.account_id
    WHERE ga.group_id = 2;
-- Question 18: 
-- a) Lấy các group có lớn hơn 5 thành viên
SELECT 			g.group_name, count(ga.account_id)
    FROM 		`group` g
    LEFT JOIN 	`group_account` ga
    ON 			g.group_id = ga.group_id
    GROUP BY	g.group_id
    HAVING 		count(ga.group_id)>5;
-- b) Lấy các group có nhỏ hơn 7 thành viên
SELECT 			g.group_name, count(ga.account_id)
    FROM 		`group` g
    LEFT JOIN 	`group_account` ga
    ON 			g.group_id = ga.group_id
    GROUP BY	g.group_id
    HAVING 		count(ga.group_id)<7;
-- c) Ghép 2 kết quả từ câu a) và câu b)
SELECT 			g.group_name, count(ga.account_id)
    FROM 		`group` g
    LEFT JOIN 	`group_account` ga
    ON 			g.group_id = ga.group_id
    GROUP BY	g.group_id
    HAVING 		count(ga.group_id)>5
    UNION ALL
	SELECT 		g.group_name, count(ga.account_id)
    FROM 		`group` g
    LEFT JOIN 	`group_account` ga
    ON 			g.group_id = ga.group_id
    GROUP BY	g.group_id
    HAVING 		count(ga.group_id)<7;