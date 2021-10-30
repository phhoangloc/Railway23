-- Exercise 1: Tiếp tục với Database Testing System
USE testing_system;
-- Question 1: Tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các account thuộc phòng ban đó
DROP PROCEDURE IF EXISTS sp_nhap_ten_phong_ban;
DELIMITER $$
	CREATE PROCEDURE sp_nhap_ten_phong_ban(
		IN namein varchar(50)
    )
    BEGIN 
		SELECT a.full_name
        FROM `position` p
        join `account` a
        on p.position_id=a.position_id
        WHERE p.position_name = namein ;
	END$$
    DELIMITER ;

CALL sp_nhap_ten_phong_ban('dev');
    
    
-- Question 2: Tạo store để in ra số lượng account trong mỗi group
DROP PROCEDURE IF EXISTS sp_so_account_trong_group;
 DELIMITER $$
	CREATE PROCEDURE sp_so_account_trong_group ()
    BEGIN
		SELECT g.group_name, count(ga.account_id) 'số account'
        FROM `group` g
        left join group_account ga
        on g.group_id = ga.group_id
        GROUP BY (g.group_id);
	END; $$
DELIMITER ;
call sp_so_account_trong_group;


-- Question 3: Tạo store để thống kê mỗi type question có bao nhiêu question được tạo trong tháng hiện tại
DROP PROCEDURE IF EXISTS sp_moi_type_co_bao_nhieu_question_trong_thang_hien_tai;
 DELIMITER $$
	CREATE PROCEDURE sp_moi_type_co_bao_nhieu_question_trong_thang_hien_tai ()
		BEGIN
			select tq.type_id,count(q.question_id),month(q.create_day)
            from type_question tq
            right join question q
            on tq.type_id = q.type_id
            where month(q.create_day) = (SELECT MONTH(NOW()) monn)
            and year (q.create_day) = (SELECT year(NOW()) monn)
            group by q.create_day,tq.type_id;
			
		END; $$
   DELIMITER     
   call sp_moi_type_co_bao_nhieu_question_trong_thang_hien_tai();
   
select* from `question`;
   
-- Question 4: Tạo store để trả ra id của type question có nhiều câu hỏi nhất
DROP PROCEDURE IF EXISTS sp_type_co_nhieu_cau_hoi_nhat;
	DELIMITER $$
	CREATE PROCEDURE sp_type_co_nhieu_cau_hoi_nhat ()
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
    call sp_type_co_nhieu_cau_hoi_nhat();
    
    
    
-- Question 5: Sử dụng store ở question 4 để tìm ra tên của type question
    
    set @typenameout=2;
    select tq.type_name from type_question tq where type_id = @typenameout;
-- Question 6: Viết 1 store cho phép người dùng nhập vào 1 chuỗi và trả về group có tên 
	-- chứa chuỗi của người dùng nhập vào hoặc trả về user có username chứa chuỗi của người dùng nhập vào
    DROP PROCEDURE IF EXISTS sp_input_group;
    DELIMITER $$
	CREATE PROCEDURE sp_input_group (in input varchar(50))
    BEGIN
		SELECT g.group_name as 'kết quả tìm kiếm'
        FROM `group` g 
        WHERE g.group_name LIKE
			CONCAT("%",input,"%")
		UNION
		SELECT a.user_name 
        FROM `account` a 
        WHERE a.user_name LIKE
			CONCAT("%",input,"%");
	END$$
    DELIMITER  
    
    call sp_input_group('lợn');
        
		
-- Question 7: Viết 1 store cho phép người dùng nhập vào thông tin fullName, email và trong store sẽ tự động gán:
-- username sẽ giống email nhưng bỏ phần @..mail đi
-- positionID: sẽ có default là developer
-- departmentID: sẽ được cho vào 1 phòng chờ
select* from `account`;
-- Sau đó in ra kết quả tạo thành công
  DROP PROCEDURE IF EXISTS sp_input_fullname;
    DELIMITER $$
	CREATE PROCEDURE sp_input_fullname (in fullnamein varchar(50), in emailin varchar(50))
    Begin
		declare de_user_name varchar(50) default SUBSTRING_INDEX(emailin,'@',1);
		declare de_position_id INT default 1; 
        declare de_derpartment_id INT default 11;
        
        insert into `account`(email,full_name,user_name,position_id,department_id)
        values(emailin,fullnamein,de_user_name,de_position_id,de_derpartment_id);
	end$$
    DELIMITER ;
     call sp_input_fullname('Nguyễn Văn Bê','benguyen@mail.com');
     select * from `account` 
     where full_name = 'Nguyễn Văn Bê'
     and email = 'benguyen@mail.com' ;


-- Question 8: Viết 1 store cho phép người dùng nhập vào Essay hoặc Multiple-Choice
	-- để thống kê câu hỏi essay hoặc multiple-choice nào có content dài nhất
    select* from type_question;
    select* from question;
    DROP PROCEDURE IF EXISTS sp_nhap_type_question;
    DELIMITER $$
	CREATE PROCEDURE sp_nhap_type_question(IN typein enum( 'essay','Multiple-Choice'))
		BEGIN
		    SELECT tq.type_id,q.content,LENGTH(content)
            FROM question q
			LEFT JOIN type_question tq
			ON q.type_id = tq.type_id
            where tq.type_name = typein
            and length(q.content) =  (
				SELECT max(LENGTH(content)) 
				FROM question q
				LEFT JOIN type_question tq
				ON q.type_id = tq.type_id
                where tq.type_name = typein
            );
		END$$
    DELIMITER ;
    
    call sp_nhap_type_question('Multiple-Choice');
    
-- Question 9: Viết 1 store cho phép người dùng xóa exam dựa vào ID
DROP PROCEDURE IF EXISTS sp_nhap_examid;
DELIMITER $$
CREATE PROCEDURE sp_nhap_examid(IN typein INT)
	BEGIN 
		DELETE 
		FROM `exam`
		WHERE exam_id = typein;
	END$$
DELIMITER ;

call sp_nhap_examid('1');
select* from `exam`;
-- Question 10: Tìm ra các exam được tạo từ 3 năm trước và xóa các exam đó đi (sử dụng store ở câu 9 để xóa)
	-- Sau đó in số lượng record đã remove từ các table liên quan trong khi removing
DROP PROCEDURE IF EXISTS sp_xoa_examid_theo_nam;
DELIMITER $$
CREATE PROCEDURE sp_xoa_examid_theo_nam()
	BEGIN 
		DELETE 
		FROM `exam`
		WHERE year(create_date) = (year(now)-3);
	END$$
DELIMITER ;
    
-- Question 11: Viết store cho phép người dùng xóa phòng ban bằng cách người dùng  
	-- nhập vào tên phòng ban và các account thuộc phòng ban đó sẽ được 
	-- chuyển về phòng ban default là phòng ban chờ việc
    
    
-- Question 12: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong năm nay


-- Question 13: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong 6 tháng gần đây nhất
 -- (Nếu tháng nào không có thì sẽ in ra là "không có câu hỏi nào trong tháng")
