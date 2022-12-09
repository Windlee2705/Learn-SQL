create database QuanLySinhVien
use QuanLySinhVien
create table SinhVien(
	MSSV int identity(1,1) primary key,
	Lop varchar(10),
	Ho varchar(10),
	Ten varchar(10), 
	NgaySinh datetime,
	GioiTinh bit
)

create table MonHoc(
	MSMon int identity(1,1) primary key,
	TenMon varchar(30)
)

create table DiemThi(
	MSSV int, 
	MSMon int, 
	LanThi int,
	Diem int,
	FOREIGN KEY (MSSV) REFERENCES SinhVien(MSSV),
)
go


alter table DiemThi add foreign key (MSMon) references MonHoc(MSMon)

alter table DiemThi 
	add default 1 for LanThi,
	check(Diem>=0 and Diem<=10)

alter table SinhVien alter column Lop varchar(30)

-------------------------------------------------

insert into SinhVien values('Dien tu 06','Le Quang','Phong','05/27/2001','True')
insert into SinhVien values('Dien tu 06','Nguyen','Son','06/25/2001','True')
insert into SinhVien values('CNTT 08','Ha','Thuong','05/28/2003','False')

use QuanLySinhVien
delete from SinhVien
select * from SinhVien
-------------------------------------------------

insert into MonHoc values('Ky thuat lap trinh')
insert into MonHoc values('Co so du lieu')
insert into MonHoc values('Ky thuat dien tu')
insert into MonHoc values('Lap trinh vi xu ly')
select * from DiemThi
-------------------------------------------------

insert into DiemThi values(13,4,3,8)

-- Tạo View --
select * from DiemThi

alter view wwLanThiCuoi as (
	select sv.MSSV, dt.MSMon, dt.LanThi  from  dbo.SinhVien sv
	join DiemThi dt 
	on sv.MSSV = dt.MSSV
	where dt.LanThi = select max(LanThi) from dbo.DiemThi
)
select * from wwLanThiCuoi order by mssv, msmon

select MSSV, MSMon, LanThiMax = max(LanThi) from wwLanThiCuoi 
group by mssv,msmon
order by mssv, msmon



alter view wwDiemThiCuoi as (
	select mssv, msmon, lanthimax = max(lanthi), max(diem) as diem
	from dbo.DiemThi
	group by mssv,msmon
)
select * from DiemThi order by mssv, msmon
select * from wwDiemThiCuoi order by mssv, msmon

update DiemThi set mssv = 12 where mssv = 13 and msmon = 4 


-- Tạo trigger -- 
/* 
Tạo trigger Insert cho table DiemThi dùng điền tự động số thứ tự lần thi khi thêm 
điểm thi một môn học của một sinh viên. Ví dụ sinh viên A đã thi môn học M hai lần thì lần thi mới thêm vào phải là 3.
*/
use quanlysinhvien
select * from dbo.DiemThi

alter trigger trig_AutoLanThi on DiemThi
for INSERT
AS
	declare @MSSV int
	declare @MSMon int
	select @MSSV = MSSV,@MSMon = MSMon from inserted
	if NOT EXISTS (select * from DiemThi where MSSV=@MSSV and MSMon=@MSMon)
		begin
			print 'MSSV them vao khong ton tai'
			rollback tran
			return
		end
	update DiemThi set lanthi = lanthi 



insert into DiemThi values(13,1,default,5)

select * from dbo.DiemThi


/* 
Viết thủ tục hoặc hàm liệt kê kết quả thi các môn của một sinh viên khi biết 
mã số của sinh viên (MSSV) gồm các thông tin: mã số môn học, lần thi, điểm thi. Trong đó, mã số sinh viên là giá trị input
*/

CREATE PROCEDURE ThongTinSV(@mssv int)
AS
BEGIN
     if exists(select * from DiemThi where MSSV = @mssv)
		begin 
			 select * from DiemThi where MSSV = @mssv
		end
	 else 
		print N'Không tồn tại sinh viên có mssv là ' + cast(@mssv as nvarchar(30))
		return 0
END;

exec ThongTinSV 13
