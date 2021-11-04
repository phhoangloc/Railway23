-- Question 1: Tạo trigger không cho phép người dùng nhập vào Group có ngày tạo trước 1 năm trước
	use testing_system;
    select * from `group_account`;
    drop TRIGGER IF EXISTS tri_ko_cho_nhap_vao_group_tao_1_nam_truoc;
    delimiter $$
    create TRIGGER tri_ko_cho_nhap_vao_group_tao_1_nam_truoc
		BEFORE INSERT on `group`
		FOR EACH ROW
			BEGIN
				DECLARE date_in date;
				SELECT date_sub(curdate(),INTERVAL 1 YEAR) INTO date_in;
				IF 
					NEW.create_date < date_in
                    THEN 
					SIGNAL SQLSTATE '12345'
                    SET MESSAGE_TEXT = 'ngày không hợp lệ';
				END IF;
			END$$
	delimiter ;	
SELECT * from `group`;
INSERT INTO `group`(group_name, creator_id, create_date) 
VALUES 
	('Nhóm test', 1	, '2021-10-18');
    
-- Question 2: Tạo trigger Không cho phép người dùng thêm bất kỳ user nào vào department "Sale" nữa, 
-- khi thêm thì hiện ra thông báo "Department "Sale" cannot add more user"
    drop TRIGGER IF EXISTS tri_ko_cho_nhap_vao_department_sale;
    delimiter $$
    create TRIGGER tri_ko_cho_nhap_vao_department_sale
		BEFORE INSERT on `account`
		FOR EACH ROW
			BEGIN
				DECLARE id_in int;
                select department_id into id_in
                from department
                where department_name='sale';
				IF 
					NEW.department_id = id_in
                    THEN 
					SIGNAL SQLSTATE '12345'
                    SET MESSAGE_TEXT = 'Department "Sale" cannot add more user';
				END IF;
			END$$
	delimiter ;	

	select *  from `account` ;
	select *  from `department` ;
    insert into `account`(account_id,email,user_name,full_name,department_id,position_id,create_date) 
    value (17,'ceceguyen@mail.com','cece','Nguyễn Văn Ce',3,2,'2016-09-22');
    
    
-- Question 3: Cấu hình 1 group có nhiều nhất là 5 user
    drop TRIGGER IF EXISTS tri_cau_hinh_group_5user;
    delimiter $$
    create TRIGGER tri_cau_hinh_group_5user
		BEFORE INSERT on `group_account`
		FOR EACH ROW
			BEGIN
            DECLARE gcount tinyint;
			SELECT count(account_id) into gcount 
			FROM group_account 
            WHERE group_id = new.group_id 
            GROUP BY group_id;
				IF 
					gcount >= 5 
                    THEN
                    SIGNAL SQLSTATE '12345'
                    SET MESSAGE_TEXT = 'group khong duoc qua 5 thanh vien';
				END IF;
			END$$
	delimiter ;	
    SELECT * FROM group_account;
INSERT INTO group_account(group_id, account_id, join_date) 
VALUES (3,16,'2021-10-18');


-- Question 4: Cấu hình 1 bài thi có nhiều nhất là 10 Question
USE testing_system;
SELECT count(question_id) FROM exam_question GROUP BY (exam_id) ;
	
	DROP TRIGGER IF EXISTS tri_cau_hinh_moi_bai_thi_10_question;
    delimiter $$
    CREATE TRIGGER tri_cau_hinh_moi_bai_thi_10_question
		BEFORE INSERT on `exam_question`
		FOR EACH ROW
			BEGIN
				DECLARE quesidcount tinyint;
				SELECT (count(question_id)) into quesidcount 
                FROM `exam_question`
                WHERE exam_id = new.exam_id 
                GROUP BY (exam_id);
                IF 
					quesidcount >= 10
                    THEN
                    SIGNAL SQLSTATE '12345'
                    SET MESSAGE_TEXT = 'exam khong duoc qua 10 cau hoi';
				END IF;
			END$$
	delimiter ;
    select * from exam_question;


-- Question 5: Tạo trigger không cho phép người dùng xóa tài khoản có email là admin@gmail.com 
-- (đây là tài khoản admin, không cho phép user xóa), 
-- còn lại các tài khoản khác thì sẽ cho phép xóa và sẽ xóa tất cả các thông tin liên quan tới user đó
DROP TRIGGER IF EXISTS tri_xoa_email;
    delimiter $$
    CREATE TRIGGER tri_xoa_email
		BEFORE delete on `account`
		FOR EACH ROW
			BEGIN
                if(old.email = 'admin@gmail.com')
				then 
					SIGNAL SQLSTATE '12345'
                    SET MESSAGE_TEXT = 'khong xoa duoc account admin';
				END IF;
			END$$
	delimiter ;
select * from `account`;
delete from `account` where email='admin@gmail.com';

-- Question 6: Không sử dụng cấu hình default cho field DepartmentID của table Account, 
-- hãy tạo trigger cho phép người dùng khi tạo account không điền vào departmentID thì sẽ được phân vào phòng ban "waiting Department"
DROP TRIGGER IF EXISTS tri_tao_account_khong_tao_phong;
    delimiter $$
    CREATE TRIGGER tri_tao_account_khong_tao_phong
		BEFORE insert on `account`
		FOR EACH ROW
			BEGIN
				DECLARE waitingroom INT;
                select department_id into waitingroom
                    from `department`
                    where department_name = 'phòng chờ';
                if
					new.department_id is null
				then
					set new.department_id = waitingroom;
				end if;
			END$$
	delimiter ;
    delete from `account` where account_id=17;
    insert into `account`(account_id,email,user_name,full_name,department_id,position_id,create_date)
    value(17,'beguyen@mail.com','b','Nguyễn Văn Be',null,2,'2016-09-22');
    select * from `account`;
    
    
    
-- Question 7: Cấu hình 1 bài thi chỉ cho phép user tạo tối đa 4 answers cho mỗi question, trong đó có tối đa 2 đáp án đúng.
DROP TRIGGER IF EXISTS tri_cau_hinh_bai_thi;
    delimiter $$
    CREATE TRIGGER tri_cau_hinh_bai_thi
		BEFORE insert on `answer`
		FOR EACH ROW
			BEGIN
				DECLARE question_in INT;
                DECLARE iscorrect_in INT;
                select count(question_id) into question_in
                    from `answer`
                    where question_id=new.question_id;
				select count(is_correct) into iscorrect_in
					from `answer`
					where is_correct= 1
                    and question_id=new.question_id;
				if
					(question_in >=4) 
                    or (iscorrect_in >=2 and new.is_correct =1)
				then
					SIGNAL SQLSTATE '12345'
					SET MESSAGE_TEXT = 'khong the chen du lieu';
				end if;
			END$$
	delimiter ;
select * from answer;
INSERT INTO answer(answer_id,content,question_id,is_correct) 
VALUES(12,'biet roi',1,1),(13,'biet roi',1,1);
delete from answer where answer_id=13;
-- Question 8: Viết trigger sửa lại dữ liệu cho đúng:
-- Nếu người dùng nhập vào gender của account là nam, nữ, chưa xác định Thì sẽ đổi lại thành M, F, U cho giống với cấu hình ở database


DROP TRIGGER IF EXISTS tri_sua_du_lieu;
    delimiter $$
    CREATE TRIGGER tri_sua_du_lieu
		BEFORE INSERT ON `account`
		FOR EACH ROW
			BEGIN
                 IF
					NEW.gender ='nam' 
				THEN
					SET NEW.gender = 'M';
				END IF;
				IF
					NEW.gender ='nu'
				THEN
					SET NEW.gender ='F';
				END IF;
				IF
					NEW.gender ='khong xac dinh'
				THEN
					SET NEW.gender = 'U';
				END IF;
			END $$ 
	delimiter ;
    
    select * from `account`;

INSERT INTO `account`(gender) 
value('khong xac dinh');


-- Question 9: Viết trigger không cho phép người dùng xóa bài thi mới tạo được 2 ngày 
DROP TRIGGER IF EXISTS Trg_CheckBefDelExam;
 DELIMITER $$
 CREATE TRIGGER Trg_CheckBefDelExam
 BEFORE DELETE ON `exam`
 FOR EACH ROW
BEGIN
	DECLARE v_CreateDate DATETIME;
	SET v_CreateDate = DATE_SUB(NOW(),INTERVAL 2 DAY);
	IF (OLD.CreateDate > v_CreateDate) THEN
	SIGNAL SQLSTATE '12345'
	SET MESSAGE_TEXT = 'Cant Delete This Exam!!';
	END IF ;
 END $$
DELIMITER ;
 

-- Question 10: Viết trigger chỉ cho phép người dùng chỉ được update, delete các question khi question đó chưa nằm trong exam nào
-- Question 12: Lấy ra thông tin exam trong đó:
-- Duration <= 30 thì sẽ đổi thành giá trị "Short time"
-- 30 < Duration <= 60 thì sẽ đổi thành giá trị "Medium time" Duration > 60 thì sẽ đổi thành giá trị "Long time"
select* from exam;
select exam_id,code,case when duration<=30 then 'Short time'
	when duration <=60 then 'Medium time'
    else 'Long time'
    end as 'time',duration
    from exam;

-- Question 13: Thống kê số account trong mỗi group và in ra thêm 1 column nữa có tên là the_number_user_amount và mang giá trị được quy định như sau:

-- Nếu số lượng user trong group =< 5 thì sẽ có giá trị là few
-- Nếu số lượng user trong group <= 20 và > 5 thì sẽ có giá trị là normal Nếu số lượng user trong group > 20 thì sẽ có giá trị là higher
-- Question 14: Thống kê số mỗi phòng ban có bao nhiêu user, nếu phòng ban nào không có user thì sẽ thay đổi giá trị 0 thành "Không có User"
