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

