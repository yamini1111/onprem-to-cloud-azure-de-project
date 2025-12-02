/*
1. On-Premise : Tables Creation scripts
2. On-Premise : Insert Data into tables scripts
3. On-Premise : Incremental load 1 - insert scripts for all tables
4. On-Premise : Incremental load 2 - insert scripts for all tables
5. Azure Cloud : SQL Server Scripts
6. Azure Cloud : SQL Server Stored procedure scripts

**********************************************************************
-------------- 1. On-Premise : Tables Creation scripts ---------------
**********************************************************************
*/



-- Customers table
CREATE TABLE Customers (
	CustomerID INT PRIMARY KEY,
	FirstName VARCHAR(50),
	LastName VARCHAR(50),
	Email VARCHAR(100),
	Phone VARCHAR(20),
	CreatedDate DATETIME DEFAULT GETDATE(),
	ModifiedDate DATETIME DEFAULT GETDATE()
);

-- Products Table
CREATE TABLE Products (
	ProductID INT PRIMARY KEY,
	ProductName VARCHAR(100),
	Price Decimal(10,2),
	Category VARCHAR(50),
	CreatedDate DATETIME DEFAULT GETDATE(),
	ModifiedDate DATETIME DEFAULT GETDATE()
);

-- Orders Table
CREATE TABLE Orders (
	OrderID INT PRIMARY KEY,
	CustomerID INT,
	OrderDate DATETIME DEFAULT GETDATE(),
	OrderStatus VARCHAR(50),
	CreatedDate DATETIME DEFAULT GETDATE(),
	ModifiedDate DATETIME DEFAULT GETDATE()
);


-- OrderItems Table
CREATE TABLE OrderItems (
	OrderItemID INT PRIMARY KEY,
	OrderID INT,
	ProductID INT,
	Quantity INT,
	TotalPrice DECIMAL(10,2),
	CreatedDate DATETIME DEFAULT GETDATE(),
	ModifiedDate DATETIME DEFAULT GETDATE()
);

-- Inventory Table
CREATE TABLE Inventory(
	ProductID INT PRIMARY KEY,
	StockQuantity INT,
	CreatedDate DATETIME DEFAULT GETDATE(),
	ModifiedDate DATETIME DEFAULT GETDATE()
);

-- Payments Table
CREATE TABLE Payments (
	PaymentID INT PRIMARY KEY,
	OrderID INT, 
	PaymentAmount Decimal(10,2),
	PaymentDate DATETIME,
	CreatedDate DATETIME DEFAULT GETDATE(),
	ModifiedDate DATETIME DEFAULT GETDATE()
);

-- Reviews Table
CREATE TABLE Reviews (
	ReviewID INT PRIMARY KEY,
	ProductID INT,
	CustomerID INT,
	Rating INT,
	CreatedDate DATETIME DEFAULT GETDATE(),
	ModifiedDate DATETIME DEFAULT GETDATE()
);

-- Promotions Table 
CREATE TABLE Promotions (
	PromotionID INT PRIMARY KEY,
	PromotionName VARCHAR(50),
	Discount DECIMAL(5,2),
	StartDate DATETIME,
	EndDate DATETIME,
	CreatedDate DATETIME DEFAULT GETDATE(),
	ModifiedDate DATETIME DEFAULT GETDATE()
);

-- ShippingDetails Table
CREATE TABLE ShippingDetails (
	ShippingID INT PRIMARY KEY,
	OrderID INT,
	ShippingMethod VARCHAR(50),
	TrackingNumber VARCHAR(20),
	ShipDate DATETIME,
	CreatedDate DATETIME DEFAULT GETDATE(),
	ModifiedDate DATETIME DEFAULT GETDATE()
);

-- Returns Table
CREATE TABLE Returns(
	ReturnID INT PRIMARY KEY,
	OrderID INT,
	ProductID INT,
	ReturnReason VARCHAR(100),
	ReturnDate DATETIME,
	CreatedDate DATETIME DEFAULT GETDATE(),
	ModifiedDate DATETIME DEFAULT GETDATE()
);

/*
**********************************************************************
----------- 2. On-Premise : Insert Data into tables scripts ----------
**********************************************************************
*/
/*
TRUNCATE TABLE OrderItems;
TRUNCATE TABLE Payments;
TRUNCATE TABLE ShippingDetails;
TRUNCATE TABLE Returns;
TRUNCATE TABLE Orders;
TRUNCATE TABLE Reviews;
TRUNCATE TABLE Inventory;
TRUNCATE TABLE Products;
TRUNCATE TABLE Promotions;
TRUNCATE TABLE Customers;
*/

-- Customers (IDs 1-5)
INSERT INTO Customers (CustomerID, FirstName, LastName, Email, Phone)
VALUES
(1, 'Alice', 'Johnson', 'alice.johnson@example.com', '555-0101'),
(2, 'Bob', 'Smith', 'bob.smith@example.com', '555-0102'),
(3, 'Carol', 'Nguyen', 'carol.nguyen@example.com', '555-0103'),
(4, 'David', 'Lee', 'david.lee@example.com', '555-0104'),
(5, 'Eva', 'Patel', 'eva.patel@example.com', '555-0105');

-- Products (ProductID 101-105)
INSERT INTO Products (ProductID, ProductName, Price, Category)
VALUES
(101, 'Widget A', 19.99, 'Widgets'),
(102, 'Widget B', 29.99, 'Widgets'),
(103, 'Gadget X', 49.50, 'Gadgets'),
(104, 'Gadget Y', 79.00, 'Gadgets'),
(105, 'Accessory Z', 9.95, 'Accessories');

-- Inventory (for products 101-105)
INSERT INTO Inventory (ProductID, StockQuantity)
VALUES
(101, 100),
(102, 150),
(103, 75),
(104, 40),
(105, 500);

-- Orders (OrderID 1001-1005) - omit Created/Modified
INSERT INTO Orders (OrderID, CustomerID, OrderStatus)
VALUES
(1001, 1, 'Completed'),
(1002, 2, 'Processing'),
(1003, 3, 'Completed'),
(1004, 4, 'Cancelled'),
(1005, 5, 'Processing');

-- OrderItems (OrderItemID 5001-5005) - link Orders & Products
INSERT INTO OrderItems (OrderItemID, OrderID, ProductID, Quantity, TotalPrice)
VALUES
(5001, 1001, 101, 2, 2 * 19.99),
(5002, 1002, 103, 1, 1 * 49.50),
(5003, 1003, 102, 3, 3 * 29.99),
(5004, 1004, 105, 5, 5 * 9.95),
(5005, 1005, 104, 1, 1 * 79.00);

-- Payments (PaymentID 2001-2005) - provide PaymentDate explicitly
INSERT INTO Payments (PaymentID, OrderID, PaymentAmount, PaymentDate)
VALUES
(2001, 1001, 39.98, '2025-11-01 10:00:00'),
(2002, 1002, 49.50, '2025-11-02 11:15:00'),
(2003, 1003, 89.97, '2025-11-03 12:30:00'),
(2004, 1004, 49.75, '2025-11-04 13:45:00'),
(2005, 1005, 79.00, '2025-11-05 14:00:00');

-- Reviews (ReviewID 3001-3005)
INSERT INTO Reviews (ReviewID, ProductID, CustomerID, Rating)
VALUES
(3001, 101, 1, 5),
(3002, 103, 2, 4),
(3003, 102, 3, 5),
(3004, 105, 4, 3),
(3005, 104, 5, 4);

-- Promotions (PromotionID 4001-4005)
INSERT INTO Promotions (PromotionID, PromotionName, Discount, StartDate, EndDate)
VALUES
(4001, 'Black Friday', 20.00, '2025-11-20', '2025-11-30'),
(4002, 'Holiday Sale', 15.00, '2025-12-15', '2026-01-05'),
(4003, 'Clearance', 30.00, '2025-10-01', '2025-10-31'),
(4004, 'New Year Deal', 10.00, '2026-01-01', '2026-01-15'),
(4005, 'Summer Offer', 5.00, '2025-06-01', '2025-06-30');

-- ShippingDetails (ShippingID 6001-6005) - include ShipDate values
INSERT INTO ShippingDetails (ShippingID, OrderID, ShippingMethod, TrackingNumber, ShipDate)
VALUES
(6001, 1001, 'Ground', 'TRK1001', '2025-11-02'),
(6002, 1002, 'Air', 'TRK1002', '2025-11-03'),
(6003, 1003, 'Ground', 'TRK1003', '2025-11-04'),
(6004, 1004, 'Ground', 'TRK1004', '2025-11-05'),
(6005, 1005, 'Sea', 'TRK1005', '2025-11-06');

-- Returns (ReturnID 7001-7005) - some returned items
INSERT INTO Returns (ReturnID, OrderID, ProductID, ReturnReason, ReturnDate)
VALUES
(7001, 1004, 105, 'Damaged', '2025-11-08'),
(7002, 1002, 103, 'Not as described', '2025-11-09'),
(7003, 1003, 102, 'Changed mind', '2025-11-10'),
(7004, 1001, 101, 'Wrong size', '2025-11-11'),
(7005, 1005, 104, 'Late delivery', '2025-11-12');


/*
*******************************************************************************
------- 3. On-Premise : Incremental load 1 - insert scripts for all tables ------
*******************************************************************************
*/

-- Customers (6-10)
INSERT INTO Customers (CustomerID, FirstName, LastName, Email, Phone)
VALUES
(6, 'Frank', 'Miller', 'frank.miller@example.com', '555-0106'),
(7, 'Grace', 'Chen', 'grace.chen@example.com', '555-0107'),
(8, 'Hassan', 'Ali', 'hassan.ali@example.com', '555-0108'),
(9, 'Ivy', 'Khan', 'ivy.khan@example.com', '555-0109'),
(10, 'Jake', 'Turner', 'jake.turner@example.com', '555-0110');

-- Products (106-110)
INSERT INTO Products (ProductID, ProductName, Price, Category)
VALUES
(106, 'Widget C', 24.99, 'Widgets'),
(107, 'Gadget Z', 99.00, 'Gadgets'),
(108, 'Accessory A', 4.99, 'Accessories'),
(109, 'Accessory B', 14.95, 'Accessories'),
(110, 'Device Q', 199.99, 'Devices');

-- Inventory for new products
INSERT INTO Inventory (ProductID, StockQuantity)
VALUES
(106, 120),
(107, 30),
(108, 1000),
(109, 300),
(110, 15);

-- Orders (1006-1010)
INSERT INTO Orders (OrderID, CustomerID, OrderStatus)
VALUES
(1006, 6, 'Processing'),
(1007, 7, 'Completed'),
(1008, 8, 'Completed'),
(1009, 9, 'Processing'),
(1010, 10, 'Processing');

-- OrderItems (5006-5010)
INSERT INTO OrderItems (OrderItemID, OrderID, ProductID, Quantity, TotalPrice)
VALUES
(5006, 1006, 106, 1, 24.99),
(5007, 1007, 107, 2, 2 * 99.00),
(5008, 1008, 108, 10, 10 * 4.99),
(5009, 1009, 109, 1, 14.95),
(5010, 1010, 110, 1, 199.99);

-- Payments (2006-2010)
INSERT INTO Payments (PaymentID, OrderID, PaymentAmount, PaymentDate)
VALUES
(2006, 1006, 24.99, '2025-11-13 09:00:00'),
(2007, 1007, 198.00, '2025-11-13 10:00:00'),
(2008, 1008, 49.90, '2025-11-14 11:00:00'),
(2009, 1009, 14.95, '2025-11-14 12:00:00'),
(2010, 1010, 199.99, '2025-11-15 13:00:00');

-- Reviews (3010-3014)
INSERT INTO Reviews (ReviewID, ProductID, CustomerID, Rating)
VALUES
(3010, 106, 6, 4),
(3011, 107, 7, 5),
(3012, 108, 8, 3),
(3013, 109, 9, 4),
(3014, 110, 10, 5);

-- Promotions (4006-4010)
INSERT INTO Promotions (PromotionID, PromotionName, Discount, StartDate, EndDate)
VALUES
(4006, 'Flash Sale', 12.50, '2025-11-25', '2025-11-25'),
(4007, 'Weekend Promo', 7.50, '2025-12-05', '2025-12-07'),
(4008, 'Spring Promo', 8.00, '2026-03-01', '2026-03-31'),
(4009, 'Loyalty Offer', 5.00, '2025-09-01', '2025-12-31'),
(4010, 'Clearout', 25.00, '2025-11-10', '2025-11-20');

-- ShippingDetails (6011-6015)
INSERT INTO ShippingDetails (ShippingID, OrderID, ShippingMethod, TrackingNumber, ShipDate)
VALUES
(6011, 1006, 'Air', 'TRK1006', '2025-11-14'),
(6012, 1007, 'Ground', 'TRK1007', '2025-11-14'),
(6013, 1008, 'Air', 'TRK1008', '2025-11-15'),
(6014, 1009, 'Ground', 'TRK1009', '2025-11-15'),
(6015, 1010, 'Air', 'TRK1010', '2025-11-16');

-- Returns (7011-7015)
INSERT INTO Returns (ReturnID, OrderID, ProductID, ReturnReason, ReturnDate)
VALUES
(7011, 1007, 107, 'Defective', '2025-11-16'),
(7012, 1008, 108, 'Wrong color', '2025-11-17'),
(7013, 1009, 109, 'Late arrival', '2025-11-18'),
(7014, 1006, 106, 'No longer needed', '2025-11-18'),
(7015, 1010, 110, 'Ordered by mistake', '2025-11-19');


/*
*******************************************************************************
------- 4. On-Premise : Incremental load 2 - insert scripts for all tables ------
*******************************************************************************
*/
-- Customers (11-15)
INSERT INTO Customers (CustomerID, FirstName, LastName, Email, Phone)
VALUES
(11, 'Kali', 'Rao', 'kali.rao@example.com', '555-0111'),
(12, 'Liam', 'Garcia', 'liam.garcia@example.com', '555-0112'),
(13, 'Maya', 'Singh', 'maya.singh@example.com', '555-0113'),
(14, 'Noah', 'Brown', 'noah.brown@example.com', '555-0114'),
(15, 'Olivia', 'Martinez', 'olivia.martinez@example.com', '555-0115');

-- Products (111-115)
INSERT INTO Products (ProductID, ProductName, Price, Category)
VALUES
(111, 'Device R', 249.99, 'Devices'),
(112, 'Accessory C', 7.99, 'Accessories'),
(113, 'Widget D', 34.99, 'Widgets'),
(114, 'Gadget Q', 59.99, 'Gadgets'),
(115, 'Special Item', 499.00, 'Specials');

-- Inventory for new products
INSERT INTO Inventory (ProductID, StockQuantity)
VALUES
(111, 20),
(112, 600),
(113, 80),
(114, 55),
(115, 5);

-- Orders (1011-1015)
INSERT INTO Orders (OrderID, CustomerID, OrderStatus)
VALUES
(1011, 11, 'Processing'),
(1012, 12, 'Completed'),
(1013, 13, 'Completed'),
(1014, 14, 'Cancelled'),
(1015, 15, 'Processing');

-- OrderItems (5011-5015)
INSERT INTO OrderItems (OrderItemID, OrderID, ProductID, Quantity, TotalPrice)
VALUES
(5011, 1011, 111, 1, 249.99),
(5012, 1012, 112, 4, 4 * 7.99),
(5013, 1013, 113, 2, 2 * 34.99),
(5014, 1014, 114, 1, 59.99),
(5015, 1015, 115, 1, 499.00);

-- Payments (2011-2015)
INSERT INTO Payments (PaymentID, OrderID, PaymentAmount, PaymentDate)
VALUES
(2011, 1011, 249.99, '2025-11-20 09:30:00'),
(2012, 1012, 31.96, '2025-11-20 10:30:00'),
(2013, 1013, 69.98, '2025-11-21 11:30:00'),
(2014, 1014, 59.99, '2025-11-21 12:30:00'),
(2015, 1015, 499.00, '2025-11-22 13:30:00');

-- Reviews (3020-3024)
INSERT INTO Reviews (ReviewID, ProductID, CustomerID, Rating)
VALUES
(3020, 111, 11, 5),
(3021, 112, 12, 4),
(3022, 113, 13, 5),
(3023, 114, 14, 2),
(3024, 115, 15, 5);

-- Promotions (4011-4015)
INSERT INTO Promotions (PromotionID, PromotionName, Discount, StartDate, EndDate)
VALUES
(4011, 'Anniversary', 18.00, '2025-11-01', '2025-11-07'),
(4012, 'Member Special', 6.00, '2025-12-01', '2025-12-31'),
(4013, 'Weekend Flash', 11.00, '2025-12-13', '2025-12-14'),
(4014, 'Clearance 2', 40.00, '2026-02-01', '2026-02-28'),
(4015, 'Early Bird', 3.00, '2025-11-25', '2025-11-30');

-- ShippingDetails (6021-6025)
INSERT INTO ShippingDetails (ShippingID, OrderID, ShippingMethod, TrackingNumber, ShipDate)
VALUES
(6021, 1011, 'Ground', 'TRK1011', '2025-11-23'),
(6022, 1012, 'Air', 'TRK1012', '2025-11-24'),
(6023, 1013, 'Ground', 'TRK1013', '2025-11-24'),
(6024, 1014, 'Sea', 'TRK1014', '2025-11-25'),
(6025, 1015, 'Air', 'TRK1015', '2025-11-25');

-- Returns (7021-7025)
INSERT INTO Returns (ReturnID, OrderID, ProductID, ReturnReason, ReturnDate)
VALUES
(7021, 1012, 112, 'Incorrect item', '2025-11-26'),
(7022, 1013, 113, 'Damaged', '2025-11-26'),
(7023, 1011, 111, 'Not needed', '2025-11-27'),
(7024, 1014, 114, 'Changed mind', '2025-11-27'),
(7025, 1015, 115, 'Defective', '2025-11-28');


select * from dbo.Customers;
select * from dbo.Inventory;
select * from dbo.OrderItems;
select * from dbo.Orders;
select * from dbo.Payments;
select * from dbo.Products;
select * from dbo.Promotions;
select * from dbo.Returns;
select * from dbo.Reviews;
select * from dbo.ShippingDetails;


