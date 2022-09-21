# Learn-SQL
## Các kiểu JOIN :
![ảnh join](https://xuanthulab.net/photo/sql-joins-4213.jpg)
### JOIN(INNER JOIN)
```
SELECT cot
  FROM bang1
  INNER JOIN bang2
  ON bang1.cot = bang2.cot;
```
#### Ví dụ :
```
SELECT nhacung.nhacung_id, nhacung.nhacung_ten, donhang.donhang_ngay
FROM nhacung
INNER JOIN donhang
ON nhacung.nhacung_id = donhang.nhacung_id;
```

### LEFT OUTER JOIN
```
SELECT cot
  FROM bang1
  LEFT [OUTER] JOIN bang2
  ON bang1.cot = bang2.cot;
```
#### Ví dụ : 
```
SELECT nhacung.nhacung_id, nhacung.nhacung_ten, donhang.donhang_ngay
  FROM nhacung
  LEFT OUTER JOIN donhang
  ON nhacung.nhacung_id = donhang.nhacung_id;
  ```
### RIGHT OUTER JOIN
```
SELECT cot
 FROM bang1
 RIGHT [OUTER] JOIN bang2
 ON bang1.cot = bang2.cot;
```
#### Ví dụ :
```
SELECT donhang.donhang_id, donhang.donhang_ngay, nhacung.nhacung_ten
 FROM nhacung
 RIGHT OUTER JOIN donhang
 ON nhacung.nhacung_id = donhang.nhacung_id;
```

### FULL OUTER JOIN
```
SELECT nhacung.nhacung_id, nhacung.nhacung_ten, donhang.donhang_ngay
 FROM nhacung
 FULL OUTER JOIN donhang
 ON nhacung.nhacung_id = donhang.nhacung_id;
```
#### Ví dụ : 
```
SELECT nhacung.nhacung_id, nhacung.nhacung_ten, donhang.donhang_ngay
 FROM nhacung
 FULL OUTER JOIN donhang
 ON nhacung.nhacung_id = donhang.nhacung_id;
 ```
 
## Tạo Store Procedure 
> Stored Procedure được biên dịch và lưu vào bộ nhớ khi khởi tạo. Điều đó có nghĩa rằng nó sẽ thực thi nhanh hơn so với việc gửi từng đoạn lệnh SQL tới SQL Server. Vì nếu bạn gửi từng đoạn lệnh nhiều lần thì SQL Server cũng sẽ phải biên dịch lại nhiều lần, rất mất thời gian so với việc biên dịch sẵn.
Để tạo một stored procedure trong SQL Server chúng ta có thể theo dõi cú pháp sau
```
Create procedure <procedure_Name> 
As 
Begin 
<SQL Statement> 
END;
```
Ví dụ tạo một stored procedure lấy danh sách tất cả dòng dữ liệu trong bảng CUSTOMERS.
```
CREATE PROCEDURE SelectCustomerstabledata 
AS 
BEGIN
     SELECT * 
     FROM dbo.Customers 
END;
```
Sau khi khởi tạo thành công store procedure, chúng ta có thể thực thi chúng thông qua cú pháp :
```
EXEC SelectCustomerstabledata;
```
#### Ví dụ
Tạo một produre store pro_UpdateSinhVien để có thể update sinh viên từ mã sinh viên : 
```
create proc pro_UpdateSinhVien(@maSv int, @hoTenSv char(30),@maKhoa char(10),@namSinh int,@queQuan char(30))
as
begin
	if exists(select maSv from dbo.SinhVien where maSv=@maSv)
	begin 
		update SinhVien
		set hoTenSv = @hoTenSv,
		maKhoa = @maKhoa,
		namsinh = @namsinh,
		queQuan = @queQuan
		where maSv = @maSv

		Print N'Đã cập nhật thành công sinh viên có Mã SV : ' + CAST(@maSv AS NVARCHAR(30))
		Return 1
	end
	else 
		Print N'Không tồn tại sinh viên có mã SV là' + CAST(@maSv AS NVARCHAR(30))
		Return 0
	end
```
Sau khi tạo procedure store, procedure store sẽ xuất hiện trong Progammability -> Stored Procedures
Ta thực thi Procedure store ta mới tạo ở trên qua câu lệnh : 
```
exec pro_UpdateSinhVien 1, 'Le Quang Phong', ' Math', '2001', 'Ha Nam'
```
Như vậy sinh viên có maSv là 1 sẽ được thay đổi với các thông tin như trên.


## Try - Catch trong SQL
### Triển khai xử lý lỗi 
Trong quá trình phát triển phần mềm, một trong những điều quan trọng là cần quan tâm tới việc xử lý lỗi. Bằng một số cách, người dùng phải quan tâm tới việc xử lý các lỗi ngoại lệ khi thiết kết database. Các cơ chế xử lý khác nhau có thể được sử dụng.
- Khi thực thi các câu lệnh DML như INSERT,DELETE,UPDATe, người dùng có thể xử lý lỗi để đảm bảo chính xác đầu ra
- Khi transaction thất bại và user phải roll back transaction, một thông báo lỗi phù hợp cần được hiển thị cho người dùng.
- Khi làm việc với con trỏ trong SQL Server, người dùng có thể xử lý lỗi để đảm bảo chính xác kết quả.

### Khối lệnh try catch
> Khối lệnh TRY … CATCH được sử dụng để triển khai xử lý lỗi ngoại lệ trong Transact SQL. Một hoặc nhiều caual ệnh T-SQl sẽ được bao bởi khối TR. Nếu một lỗi xuất hiện trong khối TRY, luồng điều khiển sẽ chuyển qua khối catch, bên trong khối CATCH có thể bao gồm 1 hoặc nhiều câu lệnh.
[ảnh try catch](https://web888.vn/wp-content/uploads/2022/06/Screenshot_6-4.jpg)
```
BEGIN TRY
{sql_statement | statement_block}
END TRY
BEGIN CATCH
[ {sql_statement | statement_block}]
END CATCH
[;]
```
#### Ví dụ :
```
begin try
	insert into SinhVien values(9,'Hoang Xuan Nam',' aGeo',1999,'Ha Noi')
	print N' Insert thành công'
end try
begin catch
	print N'Insert thất bại, error ở dòng : ' + convert(nvarchar(3), error_line()) + N', Nội dung lỗi : '  + error_message()
end catch
```

#### Thông tin lỗi :
Danh sách các hàm hệ thống cung cấp thông tin lỗi:
- ERROR_NUMBER() : trả về số lỗi.
- ERROR_SERVERITY() : trả về mức độ nghiêm trọng
- ERROR_STATE(): trả về số trạng thái của lỗi.
- ERROR_PROCEDURE(): trả về tên cảu trigger hoặc stored procedure gây ra lỗi.
- ERROR_LINE(): trả về số dòng gây ra lỗi
- ERROR_MESSAGE(): trả về văn bản hooàn thiện của lỗi, văn bản sẽ chưa các giá trị được cung cấp làm tham số như object names, độ dài.

### Sử dụng Transaction
> Lệnh COMMIT trong SQL: Khi một Transaction hoàn chỉnh được hoàn thành thì lệnh COMMIT phải được gọi ra. Lệnh này sẽ giúp lưu những thay đổi tới cở sở dữ liệu
#### Lệnh ROLLBACK trong SQL
> Lệnh ROLLBACK trong SQL: là lệnh điều khiển Transaction được sử dụng để trao trả Transaction về trạng thái trước khi có các thay đổi mà chưa được lưu tới Database. Lệnh ROLLBACK chỉ có thể được sử dụng để undo các Transaction trước khi xác nhận bằng lệnh Commit hay Rollback cuối cùng.
#### Ví dụ : 
```
begin try
begin tran insert_tran
	insert into SinhVien values(10,'Vuong Quyen', ' Geo',1999,'Ha Noi')
	insert into SinhVien values(11,'Vuong Nam', ' Matha',1999,'Ha Noi')
	insert into SinhVien values(12,'Vuong Hau', ' Geo',1999,'Ha Noi')
	print N' Insert thành công'
commit tran insert_tran
end try
begin catch
	print N'Insert thất bại, error ở dòng : ' + convert(nvarchar(3), error_line()) + N', Nội dung lỗi : '  + error_message()
	rollback tran insert_tran
end catch
```
Ở đoạn lệnh trên, nếu không sử dụng transaction thì khi ta insert dòng 1 thành công, dòng 2 lỗi, dòng 3 thành công thì dòng 1 vẫn có thể insert thành công được ví sau khi insert dòng 1 thành công -> dòng 2 lỗi thì nhảy xuống CATCH. Việc sử dụng transaction giúp khi một dòng bất kỳ bị lỗi -> xuống catch thì sẽ rollback lại bằng câu lệnh : 
```
rollback tran insert_tran
```	
![image](https://user-images.githubusercontent.com/92925089/191565797-90af985b-7945-49ec-82d6-f5738ada8916.png)

## Tạo View trong SQL
> Trong SQL Server, View là đoạn lệnh truy vấn đã được viết sẵn và lưu bên trong cơ sở dữ liệu. Một View thì bao gồm 1 câu lệnh SELECT và khi bạn chạy View thì bạn sẽ thấy kết quả giống như khi bạn mở 1 Table. Các bạn có thể tưởng tượng nó giống như một Table ảo. Bởi vì nó có thể tổng hợp dữ liệu từ nhiều Table để tạo thành 1 Table ảo.
View rất hữu dụng khi bạn muốn cho nhiều người người truy cập ở các permission khác nhau. Cụ thể là:
- Hạn chế truy cập tới các Table cụ thể. Chỉ cho phép được xem qua View.
- Hạn chế truy cập vào vào Column của Table. Khi truy cập thông qua View bạn không thể biết được tên Column mà View đó truy cập vào.
- Liên kết các Column từ rất nhiều Table vào thành Table mới được thể hiện qua View.
- Trình bày các thông tin tổng hợp(VD: sử dụng funtion như COUNT, SUM, ...)
#### Cú pháp:
```
CREATE VIEW ViewName AS
SELECT ...
```
#### Ví dụ : 
```
-- Tạo View
create view ThongTinSinhVien
as 
	select sv.maSv, sv.hoTenSv, sv.maKhoa, k.tenKhoa, k.dienThoai as N'Điện thoại khoa'
	from SinhVien sv join Khoa k
	on sv.maKhoa = k.maKhoa

-- Sử dụng View
select svView.* from ThongTinSinhVien svView
```
![image](https://user-images.githubusercontent.com/92925089/191568112-668aa768-9549-4ded-8d8f-01347af89d7d.png)

