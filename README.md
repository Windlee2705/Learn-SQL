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
 
## UNION trong SQL Server 
> https://viettuts.vn/sql/menh-de-union-trong-sql#goto-h2-1
 
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

## Cách lấy n chữ số sau dấu phẩy trong SQL Server 
```
select cast(your_float_column as decimal(10,2))
from your_table
```

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

## Cursor trong SQL
> Trong các truy vấn T-SQL, như tại các Stored Procedure, ta có thể sử dụng các con trỏ CURSOR để duyệt qua dữ liệu. Ta hiểu CURSOR là một tập hợp kết quả truy vấn (các hàng), với CURSOR ta có thể duyệt qua từng hàng kết quả để thi hành những tác vụ phức tạp. Ở một thời điểm, CURSOR có thể truy cập bởi một con trỏ đến một hàng của nó, bạn chỉ thể dịch chuyển con trỏ từ dòng này sang dòng khác.
#### Để sử dụng con trỏ trong các Procedure, cần thực hiện theo các bước:
Bước 1: khai báo con trỏ, trỏ đến một tập dữ liệu (kết quả của Select) bằng lệnh DECLARE
Ví dụ có một tập dữ liệu từ câu lệnh Select như sau:
```
SELECT id,name FROM Product
```
Ta khai báo một con trỏ đặt tên là cursorProduct thì sẽ viết như sau:
```
DECLARE cursorProduct CURSOR FOR
SELECT id, title FROM Product
```
Bước 2: Khi bắt đầu quá trình đọc các dòng dữ liệu từ Cursor trên, thì phải mở con trỏ, thực hiện như sau:
```
Open cursorProduct
```
Khi Cursor được mở, con trỏ sẽ trỏ tới dòng đầu tiên của tập dữ liệu, lúc này có thể đọc nội dung dòng đó bằng lệnh FETCH
Bước 3: Đọc dữ liệu sử dụng lệnh như sau:
```
FETCH NEXT FROM cursorProduct INTO @id, @title
```
Lệnh trên sẽ đọc nội dung dòng hiện tại, lưu vào biến @id và @title (vì dữ liệu trong Cursor này có 2 cột). Nếu đọc thành công thì dịch chuyển con trỏ tới dòng tiếp theo
Để kiệm tra việc FETCH thành công thì kiểm tra điều kiện @@FETCH_STATUS = 0
Kết hợp những điều trên lại, để đọc từng dòng từ đầu đến cuối sẽ làm như sau:
```
WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'ID:' + CAST(@id as nvarchar)
    PRINT 'TITLE:' @title

    FETCH NEXT FROM cursorProduct INTO @it, @title
END
```
Bước 4: sau khi không còn dùng đến Cursor, cần đóng lại và giải phóng các tài nguyên nó chiếm giữ
```
CLOSE cursorProduct
DEALLOCATE cursorProduct
```
### Tóm tắt lại các câu lệnh với Cursor : 
```
--Khai báo biến @id, @title để lưu nội dung đọc
DECLARE @id int
DECLARE @title nvarchar(200)


DECLARE cursorProduct CURSOR FOR  -- khai báo con trỏ cursorProduct
SELECT id, title FROM Product     -- dữ liệu trỏ tới

OPEN cursorProduct                -- Mở con trỏ

FETCH NEXT FROM cursorProduct     -- Đọc dòng đầu tiên
      INTO @id, @title

WHILE @@FETCH_STATUS = 0          --vòng lặp WHILE khi đọc Cursor thành công
BEGIN
                                  --In kết quả hoặc thực hiện bất kỳ truy vấn
                                  --nào dựa trên kết quả đọc được
    PRINT 'ID:' + CAST(@id as nvarchar)
    PRINT 'TITLE:' @title

    FETCH NEXT FROM cursorProduct -- Đọc dòng tiếp
          INTO @id, @title
END

CLOSE cursorProduct              -- Đóng Cursor
DEALLOCATE cursorProduct         -- Giải phóng tài nguyên
```

#### Ví dụ : 
```
declare @maSv int

declare cursorXepLoai cursor for 
select maSv from ThongTinHuongDan

open cursorXepLoai

fetch next from cursorXepLoai into @maSv

while @@FETCH_STATUS = 0
begin
	declare @xepLoai char(20), @ketQua decimal(5,2)
		
		-- Lấy kết quả từ view ThôngTinHuongDan
		select @ketQua = ketQua
		from ThongTinHuongDan
		where @maSv = maSv
		
		-- 
		if @ketQua >= 8
			set @xepLoai = 'Gioi'
		else if @ketQua >= 5 and @ketQua < 8
			set @xepLoai = 'Kha'
		else set @xepLoai = 'Trung Binh'

		-- Update xep loai
		update ThongTinHuongDan
		set xepLoai  = @xepLoai
		where maSv = @maSv

	fetch next from cursorXepLoai into @maSv
end

close cursorXepLoai
deallocate cursorXepLoai
```
Khi thực hiện câu lệnh trên, ta sẽ update xếp loại của view ThongTinHuongDan như sau : 
![image](https://user-images.githubusercontent.com/92925089/191795256-f5881cd0-b099-4cf4-9fe4-c3bee79275c6.png)

## With - as trong SQL
![image](https://user-images.githubusercontent.com/92925089/192136020-7f253833-6a80-453c-9d5e-7fb7a337422d.png)

```
WITH ten_alias AS (lenh_truy_van_con)  
SELECT danh_sach_cot FROM  ten_alias [ten_bang]  
[WHERE dieu_kien_join]  
```
> With sẽ lưu một số cột được chỉ định vào trong một bảng tạm. Mệnh đề được sử dụng để xác định một quan hệ tạm thời sao cho đầu ra của quan hệ tạm thời này có sẵn và được sử dụng bởi truy vấn được liên kết với mệnh đề WITH.
> AS trong SQL được sử dụng để gán tạm thời một tên mới cho một cột trong bảng. Việc này giúp biểu diễn các kết quả truy vấn và cho phép lập trình viên gán nhãn cho các kết quả một cách thích hợp, mà không thay tên các cột trong bảng vĩnh viễn.
#### Ví dụ : Từ bảng Product detail extended trong csdl NorthWind, lấy ra những mặt hàng có đơn giá trung bình lớn hơn trung bình của tất cả các đơn giá trong database
```
with PriceTrungBinhTungMatHang as (
	select ProductID, ProductName, avg(ExtendedPrice) as trungbinh from dbo.[Order Details Extended] 
	group by ProductID, ProductName
),
	PriceTrungBinhAll as (
	select avg(ExtendedPrice) as trungBinhAll from dbo.[Order Details Extended]
)

select PriceTrungBinhTungMatHang.* from PriceTrungBinhTungMatHang,PriceTrungBinhAll 
where PriceTrungBinhTungMatHang.trungbinh > PriceTrungBinhAll.trungBinhAll
```
Ở đoạn code trên, ta sử dụng mệnh đề with để tạo ra 2 bảng tạm là PriceTrungBinhTungMatHang và PriceTrungBinhAll.

## Function trong SQL
> Function (Hàm) là một đối tượng trong cơ sở dữ liệu bao gồm một tập nhiều câu lệnh được nhóm lại với nhau và được tạo ra với mục đích sử dụng lại. Trong SQL Server, hàm được lưu trữ và bạn có thể truyền các tham số vào cũng như trả về các giá trị.
### Cú pháp tạo function
Để tạo một function trong SQL Server, ta sử dụng cú pháp như dưới đây:
```
CREATE FUNCTION [schema_name.]function_name
( [ @parameter [ AS ] [type_schema_name.] datatype
[ = default ] [ READONLY ]
, @parameter [ AS ] [type_schema_name.] datatype
[ = default ] [ READONLY ] ]
)

RETURNS return_datatype

[ WITH { ENCRYPTION
| SCHEMABINDING
| RETURNS NULL ON NULL INPUT
| CALLED ON NULL INPUT
| EXECUTE AS Clause ]

[ AS ]

BEGIN

[declaration_section]

executable_section

RETURN return_value

END;
```
Trong đó, các tham số : 
- schema_name: Tên schema (lược đồ) sở hữu function.
- function_name: Tên gán cho function.
- @parameter: Một hay nhiều tham số được truyền vào hàm.
- type_schema_name: Kiểu dữ liệu của schema (nếu có).
- Datatype: Kiểu dữ liệu cho @parameter.
- Default: Giá trị mặc định gán cho @parameter.
- READONLY: @parameter không thể bị function ghi đè lên.
- return_datatype: Kiểu dữ liệu của giá trị trả về.
- ENCRYPTION: Mã nguồn (source) của function sẽ không được lưu trữ dưới dạng text trong hệ thống.
- SCHEMABINDING: Đảm bảo các đối tượng không bị chỉnh sửa gây ảnh hưởng đến function.
- RETURNS NULL ON NULL INPUT: Hàm sẽ trả về NULL nếu bất cứ parameter nào là NULL.
- CALL ON NULL INPUT: Hàm sẽ thực thi cho dù bao gồm tham số là NULL.
- EXECUTE AS clause: Xác định ngữ cảnh bảo mật để thực thi hàm.
- return_value: Giá trị được trả về.

#### Ví dụ : trong table HuongDan trong csdl ThucTap, t muốn xem sinh viên đó xếp loại gì, trước đây ta dùng con trỏ để duyệt qua từng hàng trong bảng, bây giờ với function ta cũng có thể set sinh viên đó xếp loại gì : 
```
create function funcXepLoai( 
@hd_ketQua as decimal(5,2)
)
returns char(50)

as begin 

declare @hd_xepLoai char(50);

if @hd_ketQua is null
	return 'Chua co ket qua'

if @hd_ketQua >= 8
	set @hd_xepLoai = 'Gioi'
else if @hd_ketQua >=5 and @hd_ketQua<8
	set @hd_xepLoai = 'Kha'
else set @hd_xepLoai = 'Trung Binh'

return @hd_xepLoai

end
```
Sau khi khai báo function funcXepLoai như bên trên, function này nhận vào 1 tham số là hd_ketQua với kiểu dữ liệu decimal(5,2) và trả về kiểu dữ liệu char(50) để xếp loại sinh viên. Khi sử dụng function đó, ta thực hiện câu lệnh : 
```
select hd.*, dbo.funcXepLoai(hd.ketQua) as test  from dbo.HuongDan hd
```
Sau đó, ta sẽ thu được kết quả như sau : 
![image](https://user-images.githubusercontent.com/92925089/192147245-61e641ec-90f5-4b08-b10b-fe64fe7a14f5.png)

### Drop Function (Xóa bỏ function)
> Một khi đã tạo thành công các function thì cũng sẽ có những trường hợp bạn muốn xóa bỏ function khỏi cơ sở dữ liệu vì một vài lý do.
#### Cú pháp : 
```
DROP FUNCTION function_name;
```
#### Ví dụ : 
```
DROP FUNCTION funcXepLoai;
```
Sử dụng câu lệnh này, ta sẽ xóa bỏ function có tên là funcXepLoai ra khỏi database

## Case
> Câu lệnh CASE dùng để thiết lập điều kiện rẽ nhánh trong SQL Server, tương tự chức năng của câu lệnh IF-THEN-ELSE.
Case có 2 định dạng : 
- Hàm CASE đơn giản hay còn gọi là Simple CASE.
- Hàm CASE tìm kiếm hay còn gọi là Searched CASE.
> Trong đó :
- Simple CASE là so sánh một biểu thức với một bộ các biểu thức đơn giản để xác định kết quả.
- Searched CASE là đánh giá một bộ các biểu thức Boolean để xác định kết quả.
- Cả 2 định dạng trên đều hỗ trợ đối số ELSE (nhưng không bắt buộc).
### Cú pháp : 
```
CASE bieuthuc_dauvao
WHEN bieuthuc_1 THEN ketqua_1
WHEN bieuthuc_2 THEN ketqua_2
...
WHEN bieuthuc_n THEN ketqua_n
ELSE ketqua_khac
END

// Hoặc Searched CASE

CASE
WHEN dieukien_1 THEN ketqua_1
WHEN dieukien_2 THEN ketqua_2
...
WHEN dieukien_n THEN ketqua_n
ELSE ketqua_khac
END
```
#### Ví dụ : 
Simple Case : 
```
SELECT tenchuyenmuc, Code
(CASE code
WHEN 01 THEN 'Laptrinh-Quantrimang.com'
WHEN 02 THEN 'Congnghe-Quantrimang.com'
WHEN 03 THEN 'Cuocsong-Quantrimang.com'
ELSE 'Khoahoc-Quantrimang.com'
END) AS Chuyenmuc
FROM chuyenmuc
ORDER BY Code
```
![image](https://user-images.githubusercontent.com/92925089/194116275-8eb377b3-605d-4d89-a300-20301fb97b41.png)

Searched CASE : 
```
SELECT tenchuyenmuc,
CASE
WHEN code = 01 THEN 'Laptrinh-Quantrimang.com'
WHEN code = 02 THEN 'Congnghe-Quantrimang.com'
WHEN code = 03 THEN 'Cuocsong-Quantrimang.com'
ELSE 'Khoahoc-Quantrimang.com'
END
FROM chuyenmuc;
```
So sánh 2 điều kiện : 
```
SELECT
CASE
WHEN code < 2 THEN 'Laptrinh-Quantrimang.com'
WHEN code = 2 THEN 'Congnghe-Quantrimang.com'
END
FROM chuyenmuc;
```

## Các hàm Ranking trong SQL Server
> Các hàm Ranking cho phép bạn có thể đánh số liên tục (xếp loại) cho các tập hợp kết quả. Các hàm này có thể được sử dụng để cung cấp số thứ tự trong hệ thống đánh số tuần tự khác nhau. Có thể hiểu đơn giản như sau: bạn có từng con số nằm trên từng dòng liên tục, tại dòng thứ nhất xếp loại số 1, dòng thứ 2 xếp loại số là 2… Bạn có thể sử dụng hàm ranking theo các nhóm số tuần tự, mỗi một nhóm sẽ được đánh số theo lược đồ 1,2,3 và nhóm tiếp theo lại bắt đầu bằng 1,2,3…
### Dữ liệu chạy thử cho các ví dụ : 
```
SET NOCOUNT ON
CREATE TABLE Person(
FirstName VARCHAR(10),
Age INT,
Gender CHAR(1))
INSERT INTO Person VALUES ('Ted',23,'M')
INSERT INTO Person VALUES ('John',40,'M')
INSERT INTO Person VALUES ('George',6,'M')
INSERT INTO Person VALUES ('Mary',11,'F')
INSERT INTO Person VALUES ('Sam',17,'M')
INSERT INTO Person VALUES ('Doris',6,'F')
INSERT INTO Person VALUES ('Frank',38,'M')
INSERT INTO Person VALUES ('Larry',5,'M')
INSERT INTO Person VALUES ('Sue',29,'F')
INSERT INTO Person VALUES ('Sherry',11,'F')
INSERT INTO Person VALUES ('Marty',23,'F')
```

### Hàm Row_Number
> Hàm đầu tiên tôi muốn nói tới là ROW_NUMBER. Hàm này trả lại một dãy số tuần tự bắt đầu từ 1 cho mỗi dòng hay nhóm trong tập hợp kết quả. Hàm ROW_NUMBER sẽ có cú pháp sau:
```
ROW_NUMBER ( ) OVER ( [ ] )
```
#### Ví dụ :
Ví dụ dưới sẽ đánh số liên tục cho tất cả các dòng trong bảng Person và sắp xếp chúng theo trường Age
```
SELECT ROW_NUMBER() OVER (ORDER BY Age) AS [Row Number by Age],
FirstName,
Age
FROM Person
```
Kết quả thu được : 

![image](https://user-images.githubusercontent.com/92925089/195785494-451c0349-e84c-4915-aab8-fb6b968f53e3.png)

Bạn có thể thấy tôi đã đánh số liên tục cho toàn bộ các dòng trong bảng Person bắt đầu từ số 1, và tập hợp kết quả được sắp xếp theo cột Age. Sự sắp xếp này được hoàn thiện là do tiêu chuẩn “ORDER BY Age” trong mệnh đề ORDER BY của hàm ROW_NUMBER.

Giả sử bạn không muốn tập hợp kết quả của bạn được sắp xếp mà muốn đưa bảng trở lại sắp xếp theo số bản ghi của từng dòng. Hàm ROW_NUMBER lại luôn yêu cầu phải có mệnh đề ORDER BY, vậy bạn cần phải đưa một giá trị nào đó vào trong mệnh đề này. Trong hàm truy vấn bên dưới tôi đã chỉ định “SELECT 1” vào trong mệnh đề ORDER BY, điều này sẽ chỉ trả lại kết quả là bảng như đã lưu trữ ban đầu và tất nhiên cách đánh số tuần tự vẫn bắt đầu từ 1:
```
SELECT ROW_NUMBER() OVER (ORDER BY (SELECT 1)) AS [Row Number by Record Set],
FirstName,
Age
FROM Person
```
Và đây là kết quả khi chạy câu lệnh truy vấn trên : 
![image](https://user-images.githubusercontent.com/92925089/195837593-8476d93a-6634-45ce-97cc-d4fd3c08242c.png)
> Hàm ROW_NUMBER không chỉ cho phép bạn sắp xếp toàn bộ tập hợp dòng mà còn có thể sử dụng mệnh đề PARTITION để lọc ra nhóm dòng cần đánh số. Các dòng sẽ được đánh số tuần tự trong từng giá trị PARTITION độc nhất. Các dãy số được đánh sẽ luôn bắt đầu từ 1 cho từng giá trị PARTITION mới trong tập hợp bản ghi của bạn. Hãy xem hàm truy vấn dưới đây
```
SELECT ROW_NUMBER() OVER (PARTITION BY Gender ORDER BY Age) AS [Partition by Gender],
FirstName,
Age,
Gender
FROM Person
```
Khi chạy truy vấn trên, tập hợp kết quả sẽ ra như sau:
![image](https://user-images.githubusercontent.com/92925089/195837750-904dccb4-0ac7-4036-aaad-b37649deeb42.png)

## UPDATE trong SQL Server 
> UPDATE là truy vấn được sử dụng để chỉnh sửa những bản ghi đã tồn tại trong bảng. Bạn có thể sử dụng mệnh đề WHERE với lệnh UPDATE để cập nhật các hàng được chọn, nếu không muốn tất cả các hàng trong bảng bị ảnh hưởng.
### Cú pháp lệnh UPDATE trong SQL:
```
UPDATE TEN_BANG
SET cot1 = gia_tri1, cot2 = gia_tri2...., cotN = gia_triN
WHERE [DIEU_KIEN];
```
Nếu muốn sử dụng nhiều hơn một điều kiện trong WHERE, bạn đừng quên toán tử AND và OR mà chúng ta đã biết tới trong bài SQL trước nhé.<br/>
Lưu ý: Hãy cẩn thận khi cập nhật các bản ghi trong một bảng! Chú ý tới mệnh đề WHERE trong lệnh UPDATE. Mệnh đề WHERE chỉ định (các) bản ghi nào cần được cập nhật. Nếu bạn bỏ qua mệnh đề WHERE, tất cả các bản ghi trong bảng sẽ được cập nhật!
### Ví dụ về lệnh UPDATE trong SQL
![image](https://user-images.githubusercontent.com/92925089/205989283-6134f3f8-e27b-4fe5-b8b9-b1863fd0fb08.png)
```
UPDATE NHANVIEN 
SET DIACHI = 'Hanoi' 
WHERE ID = 3;
```
![image](https://user-images.githubusercontent.com/92925089/205989398-550b794c-602f-466a-ac4d-79bec9e270f8.png)
#### Update nhiều bản ghi
![image](https://user-images.githubusercontent.com/92925089/205989520-2b95b27e-c4cc-466d-89a0-90ea224061c6.png)

## Alter trong SQL
> Trong SQL Server, lệnh ALTER TABLE được dùng để thêm cột, chỉnh sửa cột, xóa cột, đổi tên cột hoặc đổi tên bảng.
![image](https://user-images.githubusercontent.com/92925089/205990273-90910333-2788-414f-8047-7e729fa87569.png)
### Thêm cột vào bảng trong SQL Server
```
ALTER TABLE ten_bang
  ADD ten_cot dinh_nghia_cot;
```
```
ALTER TABLE Quantrimang
  ADD Luotxem FLOAT(10);
```
![image](https://user-images.githubusercontent.com/92925089/205990509-e5be2bb8-2534-442d-a7ee-bc5b1cde3e89.png)
### Thêm nhiều cột vào bảng trong SQL Server
```
ALTER TABLE Quantrimang
  ADD Bientap VARCHAR(50),
      Trangthai VARCHAR(50);
```
![image](https://user-images.githubusercontent.com/92925089/205990657-25cbe925-b7a5-4937-9b34-748b65c9db2a.png)
### Chỉnh sửa cột trong bảng trong SQL Server
```
ALTER TABLE Quantrimang
  ALTER COLUMN Trangthai VARCHAR(75) NOT NULL;
```
Lệnh trên sẽ sửa cột Trangthai sang kiểu dữ liệu VARCHAR(75) và không chấp nhận giá trị NULL.
### Xóa cột của bảng trong SQL Server
```
ALTER TABLE Quantrimang
  DROP COLUMN Bientap;
```
![image](https://user-images.githubusercontent.com/92925089/205990907-6fbef801-049f-4b70-96c1-2d46cac11959.png)
### Đổi tên cột của bảng trong SQL Server
![image](https://user-images.githubusercontent.com/92925089/205991120-d21445e4-de63-401f-97ae-a0eac1ac83e3.png)
### Đổi tên bảng trong SQL Server
![image](https://user-images.githubusercontent.com/92925089/205991184-9dd0c8a8-0708-434f-b080-50c844576f3e.png)

