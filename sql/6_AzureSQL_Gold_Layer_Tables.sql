
-- Gold Layer Tables

CREATE TABLE YaerMonthlySales
(
	year int,
	month int,
	TotalSales decimal(10,2)
);

CREATE TABLE TopProducts
(
	ProductID int,
	TotalQuantity int
);

CREATE TABLE OrderAnalysis
(
	OrderID int,
	TotalOrderAmount decimal(10,2),
	TotalOrderQuantity int
);

CREATE TABLE SalesAnalysis
(
	ProductID int,
	OrderYear int,
	OrderMonth int,
	TotalSalesAmount decimal(10,2),
	TotalNumberOfOrders int
);



