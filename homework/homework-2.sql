-- Câu 1 : Thống kê tất cả số lượng hàng tồn và số lượng hàng đang được đặt hàng cả tất cả những mặt hàng đang được bán (discontinued =0)
use Northwind

select pro.Discontinued, count(pro.Discontinued) as soLuong
from dbo.Products pro
group by pro.Discontinued

-- Câu 2 : Hiển thị loại hàng, mã hàng, tên hàng, số lượng hàng tồn do công ty Exotic Liquids cung cấp
select * from dbo.Products

select prod.ProductID as 'ma hang', prod.ProductName as 'ten hang', cate.CategoryName as 'loai hang', prod.UnitsInStock as 'so luong hang ton'
from dbo.Products prod join dbo.Categories cate
on prod.categoryID = cate.categoryID
where prod.SupplierID = 1

-- Câu 3 : Tìm mã, tên của tất cả các nhân viên đã từng làm việc với công ty khách hàng là công ty Ana Trujillo Emparedados y helados
select * from dbo.Employees
select * from dbo.Customers

select emp.EmployeeID, emp.FirstName, cus.CompanyName
from dbo.Employees emp join dbo.Orders orders
on emp.EmployeeID = orders.EmployeeID
join dbo.Customers cus
on cus.CustomerID = orders.CustomerID
where cus.CompanyName = 'Ana Trujillo Emparedados y helados'

-- Câu 4 : Hiển thị tên của tất cả mã nv, tên nhân viên đã từng làm việc với những khách hàng ở Germany

select emp.EmployeeID, emp.FirstName, cus.Country
from dbo.Employees emp join dbo.Orders orders
on emp.EmployeeID = orders.EmployeeID
join dbo.Customers cus
on cus.CustomerID = orders.CustomerID
where cus.Country = 'Germany'

/* Câu 5 : Hiển thị chi tiết mã đơn hàng, mã sản phẩm, số lượng sản phẩm, giá, chiết khấu,
thành tiền của những đơn hàng do trưởng phòng kinh doanh (Sale manager) trực
tiếp đảm nhận */

select * from dbo.Employees
select * from dbo.[Order Details Extended]

select orderDe.OrderID, orderDe.ProductID, orderDe.Quantity, orderDe.UnitPrice, orderDe.Discount, orderDe.ExtendedPrice, emp.FirstName, emp.Title
from dbo.[Order Details Extended] orderDe join dbo.Orders ord
on ord.OrderID = orderDe.OrderID
join dbo.Employees emp
on ord.EmployeeID = emp.EmployeeID
where emp.Title = 'Sales manager'

-- Câu 6 : Hãy sắp xếp tên những sản phẩm theo thự tự a, b, c
select * from dbo.Products
order by ProductName asc

-- Câu 7 : Tìm mã đơn hàng, mã khách hàng thực hiện đơn hàng có giá trị lớn nhất
select *  from dbo.[Order Details Extended] orderDe
select  * from dbo.[Order Details Extended] orderDe
where orderDe.ExtendedPrice = (select max(ExtendedPrice) from dbo.[Order Details Extended])

-- Câu 9. Hiển thị chi tiết những đơn hàng được giao dịch vào ngày 16/7/1996
select *  from dbo.[Orders] ord
where ord.OrderDate = '1996-07-04'
/* 10. Hiển thị những đơn hàng đã được đặt hàng từ ngày 16/7/1996  20/7/1996 và
được vận chuyển luôn trong thời gian đó. */

select ord.* from dbo.Orders ord
where ord.OrderDate  between '1996-07-16' and '1996-07-20'
and ord.ShippedDate between '1996-07-16' and '1996-07-20'

-- 11. Tìm những nhân viên đã chịu trách nhiệm từ 30 đơn hàng trở lên
select emp.* from dbo.Employees emp
where emp.EmployeeID in (
	select ord.EmployeeID from dbo.Orders ord
	group by ord.EmployeeID
	having count(ord.EmployeeID) > 30
)

select ord.EmployeeID, count(ord.EmployeeID) from dbo.Orders ord
group by ord.EmployeeID

with OrderTemp as (
select ord.EmployeeID, count(ord.EmployeeID) as 'soLuong' from dbo.Orders ord
group by ord.EmployeeID )

select * from orderTemp

/* 12. Tìm những nhân viên được thuê sau ít nhất một nhân viên khác và hiển thị danh
sách những người đã được thuê trước họ */
declare @count int
set @count = (select count(*) from dbo.Employees)
print @count

select emp.* from dbo.Employees emp

where emp.EmployeeID in (
	select top (@count-1) EmployeeID from dbo.Employees empChild
	order by empChild.HireDate desc
)
order by emp.HireDate
-- Cách 2 : 
select emp.* from dbo.Employees emp

where emp.EmployeeID not in (
	select top (1) EmployeeID from dbo.Employees empChild
	order by empChild.HireDate asc
)
order by emp.HireDate

-- 13. Hãy tìm mã, tên, giá hiện tại những mặt hàng mã công ty Around the Horn đã mua 
select invo.ProductID, invo.ProductName, prod.UnitPrice as 'Don gia', count(invo.productID) from dbo.Invoices invo
join dbo.Products prod
on invo.ProductID = prod.ProductID
where invo.CustomerName = 'Around the Horn'
group by invo.ProductID,invo.ProductName,prod.[UnitPrice]

-- 14. Tìm những nhân viên vào sau Margaret Peacock
declare @datePeacock datetime
set @datePeacock = (select pea.HireDate from dbo.Employees pea 
	where pea.LastName = 'Peacock' and pea.FirstName = 'Margaret' 
)
print @datePeacock

select emp.* from dbo.Employees emp

where emp.HireDate > @datePeacock
order by emp.HireDate

-- 15. Hãy tìm 3 đơn hàng được đặt sau cùng
select top(3) ord.* from dbo.Orders ord
order by ord.OrderDate desc

-- 16. Hãy hiển thị 10 khách hàng có nhiều đơn hàng nhất trong năm 1998
with tempTable as (
	select top(10) ord.CustomerID, count(ord.CustomerID) as 'soLuongDatHang'
	from dbo.Orders ord 
	group by ord.CustomerID
	order by count(ord.CustomerID) desc
)

select cus.CompanyName, temp.* 
from dbo.Customers cus join tempTable temp
on cus.CustomerID = temp.CustomerID

-- 17. Tìm những khách hàng đặt hàng trong năm 1997
use Northwind
select cus.* from dbo.Customers cus
where cus.CustomerID in (
	select ord.CustomerID from dbo.Orders ord
where year(ord.OrderDate) = '1997'
group by ord.CustomerID )

/* 18. Tìm tất cả những mã đơn, tên công ty, thành phố, nước của những khách hàng vào
tháng của những đơn hàng đặt vào 12/1996 và yêu cầu nhận được hàng vào năm
1997. */

select *,(cast(datepart(mm,OrderDate) as varchar)+'-'+cast(datepart(yyyy,OrderDate) as varchar)) as MonthYear from dbo.Orders
where (cast(datepart(mm,OrderDate) as varchar)+'-'+cast(datepart(yyyy,OrderDate) as varchar)) = '12-1996'
and year(RequiredDate) = '1997'

-- 19. Tính tổng tiền hàng được bán theo từng năm
select year(invc.OrderDate) as 'nam', sum(invc.ExtendedPrice) as 'tongTien' from dbo.Invoices invc
group by year(invc.OrderDate)

-- 20. Tìm những nhân viên được thuê sau cùng
select top(1) emp.* from dbo.Employees emp
order by emp.HireDate desc

-- 21. Hiển thị những đơn hàng có tổng tiền hàng lớn nhất
select invc.* from dbo.Invoices invc
where invc.ExtendedPrice = (select max(ExtendedPrice) from dbo.Invoices)

-- 22. Tìm ra tên những khách hàng đặt số lượng đơn hàng lớn nhất
with tempInvoice as (
	select ord.CustomerID, count(ord.CustomerID) as 'soLuong' from dbo.Orders ord
	group by ord.CustomerID 
)

select * from dbo.Customers 
	where CustomerID in (
	select CustomerID from Orders
	where CustomerID in (
		select CustomerID from tempInvoice
		where soLuong = (select max(soLuong) from tempInvoice)
	)
	group by CustomerID
	)

/* 23. Hiển thị tên khách hàng, mã đơn hàng, tổng tiền hàng của mỗi đơn. Sắp xếp theo
thứ tự tổng tiền hàng giảm dần, mã đơn hàng tăng dần */
select * from dbo.Invoices
order by ExtendedPrice desc, OrderID asc

/* 24. Hiển thị mã đơn hàng, tên nhân viên phụ trách những đơn hàng có giá trị doanh
thu từ 200 trở lên */

select ord.OrderID, emp.EmployeeID, (emp.FirstName + ' ' + emp.LastName) as 'ho ten' from dbo.Orders ord
join dbo.Employees emp
on ord.EmployeeID = emp.EmployeeID
where ord.OrderID in  (
	select invc.OrderID from dbo.Invoices invc
	where invc.ExtendedPrice > 200
)
