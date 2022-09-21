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
