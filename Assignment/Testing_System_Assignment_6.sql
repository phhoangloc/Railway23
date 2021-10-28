-- Exercise 1: Tiếp tục với Database Testing System
USE testing_system;
-- Question 1: Tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các account thuộc phòng ban đó
DELIMITER $$
DROP PROCEDURE IF EXISTS input_fullname;
	CREATE PROCEDURE input_fullname (
		IN namein varchar(50)
    )
    BEGIN 
		SELECT * 
        FROM `account`
        WHERE full_name = namein ;
	END; $$
    DELIMITER ;

CALL input_fullname('su tu');
    
    
-- Question 2: Tạo store để in ra số lượng account trong mỗi group
select * from group_account;
 DELIMITER $$
DROP PROCEDURE IF EXISTS count_account;
	CREATE PROCEDURE count_account ()
    BEGIN
		SELECT ga.group_id, count(ga.account_id) 'số account'
        FROM group_account ga
        GROUP BY (ga.group_id);
	END; $$
DELIMITER ;
call count_account;


-- Question 3: Tạo store để thống kê mỗi type question có bao nhiêu question được tạo trong tháng hiện tại
 DELIMITER $$
DROP PROCEDURE IF EXISTS count_type_in_question;
	CREATE PROCEDURE count_type_in_question ()
		BEGIN
			select tq.type_id,count(q.question_id),month(q.create_day)
            from type_question tq
            right join question q
            on tq.type_id = q.type_id
            group by q.create_day,tq.type_id
            having (month(q.create_day) = (SELECT MONTH(NOW()) monn));
		END; $$
   DELIMITER     
   call count_type_in_question();
   
   
-- Question 4: Tạo store để trả ra id của type question có nhiều câu hỏi nhất
	DELIMITER $$
DROP PROCEDURE IF EXISTS type_max_question;
	CREATE PROCEDURE type_max_question ()
    BEGIN
		SELECT tq.type_id
		FROM type_question tq
        RIGHT JOIN question q
        ON tq.type_id = q.type_id
        group by tq.type_id
        having count(tq.type_id)
        =
        (select max(cnum) from (SELECT count(q.question_id) cnum
							FROM type_question tq
							RIGHT JOIN question q
							ON tq.type_id = q.type_id
							group by tq.type_id) tbl);
	END; $$
    DELIMITER  
    call type_max_question();
-- Question 5: Sử dụng store ở question 4 để tìm ra tên của type question
    
    
-- Question 6: Viết 1 store cho phép người dùng nhập vào 1 chuỗi và trả về group có tên 
	-- chứa chuỗi của người dùng nhập vào hoặc trả về user có username chứa chuỗi của người dùng nhập vào
    select * from`group_account`;
    DELIMITER $$
DROP PROCEDURE IF EXISTS input_group;
	CREATE PROCEDURE input_group (in input text)
    BEGIN
		select *
        from `group_account` ga
        right join `account` a
        on ga.account_id = a.account_id
        left join `group`g
        on ga.group_id = g.group_id
        where g.group_name = input
        or 	a.user_name = input
        or 	a.full_name = input;
	END; $$
    DELIMITER  
    
    call input_group('gruop1');
        
		
-- Question 7: Viết 1 store cho phép người dùng nhập vào thông tin fullName, email và trong store sẽ tự động gán:
--  username sẽ giống email nhưng bỏ phần @..mail đi
-- positionID: sẽ có default là developer
-- departmentID: sẽ được cho vào 1 phòng chờ
 -- Sau đó in ra kết quả tạo thành công
-- Question 8: Viết 1 store cho phép người dùng nhập vào Essay hoặc Multiple-Choice
	-- để thống kê câu hỏi essay hoặc multiple-choice nào có content dài nhất
-- Question 9: Viết 1 store cho phép người dùng xóa exam dựa vào ID
-- Question 10: Tìm ra các exam được tạo từ 3 năm trước và xóa các exam đó đi (sử dụng store ở câu 9 để xóa)
	-- Sau đó in số lượng record đã remove từ các table liên quan trong khi removing
-- Question 11: Viết store cho phép người dùng xóa phòng ban bằng cách người dùng  
	-- nhập vào tên phòng ban và các account thuộc phòng ban đó sẽ được 
	-- chuyển về phòng ban default là phòng ban chờ việc
-- Question 12: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong năm nay
-- Question 13: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong 6 tháng gần đây nhất
 -- (Nếu tháng nào không có thì sẽ in ra là "không có câu hỏi nào trong tháng")
