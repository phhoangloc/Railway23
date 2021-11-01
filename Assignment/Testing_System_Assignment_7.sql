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
            declare gcount tinyint;
			select count(account_id) into gcount 
			from group_account 
            where group_id = new.group_id group by group_id;
				IF 
					gcount >= 5 
                    then
                    SIGNAL SQLSTATE '12345'
                    SET MESSAGE_TEXT = 'group khong duoc qua 5 thanh vien';
				END IF;
			END$$
	delimiter ;	
    select * from group_account;
INSERT INTO group_account(group_id, account_id, join_date) 
VALUES (3,16,'2021-10-18');
-- Question 4: Cấu hình 1 bài thi có nhiều nhất là 10 Question


-- Question 5: Tạo trigger không cho phép người dùng xóa tài khoản có email là admin@gmail.com (đây là tài khoản admin, không cho phép user xóa), còn lại các tài khoản khác thì sẽ cho phép xóa và sẽ xóa tất cả các thông tin liên quan tới user đó
-- Question 6: Không sử dụng cấu hình default cho field DepartmentID của table Account, hãy tạo trigger cho phép người dùng khi tạo account không điền vào departmentID thì sẽ được phân vào phòng ban "waiting Department"
-- Question 7: Cấu hình 1 bài thi chỉ cho phép user tạo tối đa 4 answers cho mỗi question, trong đó có tối đa 2 đáp án đúng.
-- Question 8: Viết trigger sửa lại dữ liệu cho đúng:
-- Nếu người dùng nhập vào gender của account là nam, nữ, chưa xác định Thì sẽ đổi lại thành M, F, U cho giống với cấu hình ở database
-- Question 9: Viết trigger không cho phép người dùng xóa bài thi mới tạo được 2 ngày Question 10: Viết trigger chỉ cho phép người dùng chỉ được update, delete các
-- question khi question đó chưa nằm trong exam nào
-- Question 12: Lấy ra thông tin exam trong đó:
-- Duration <= 30 thì sẽ đổi thành giá trị "Short time"
-- 30 < Duration <= 60 thì sẽ đổi thành giá trị "Medium time" Duration > 60 thì sẽ đổi thành giá trị "Long time"
-- Question 13: Thống kê số account trong mỗi group và in ra thêm 1 column nữa có tên là the_number_user_amount và mang giá trị được quy định như sau:
-- VTI ACADEMY
-- VTI ACADEMY
-- HỘ CHIẾU LẬP TRÌNH VIÊN DOANH NGHIỆP
--     WAY TO ENTERPRISE – CON ĐƯỜNG ĐẾN DOANH NGHIỆP
-- Nếu số lượng user trong group =< 5 thì sẽ có giá trị là few
-- Nếu số lượng user trong group <= 20 và > 5 thì sẽ có giá trị là normal Nếu số lượng user trong group > 20 thì sẽ có giá trị là higher
-- Question 14: Thống kê số mỗi phòng ban có bao nhiêu user, nếu phòng ban nào không có user thì sẽ thay đổi giá trị 0 thành "Không có User"
