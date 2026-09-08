   /* 
   CREATE DATABASE
   */

CREATE DATABASE EcommerceERP;
GO

USE EcommerceERP;
GO


  /* 
   1. CUSTOMERS
  */

CREATE TABLE Customers
(
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,

    CustomerName VARCHAR(100) NOT NULL,

    Email VARCHAR(150) NOT NULL UNIQUE,

    Phone VARCHAR(15),

    City VARCHAR(50),

    CreatedAt DATETIME DEFAULT GETDATE(),

    IsActive BIT DEFAULT 1
);
GO


INSERT INTO Customers
(CustomerName, Email, Phone, City, IsActive)
VALUES
('Amit Sharma', 'amit@gmail.com', '9876543210', 'Kolkata', 1),
('Rahul Das', 'rahul@gmail.com', '9876543211', 'Howrah', 1),
('Priya Singh', 'priya@gmail.com', '9876543212', 'Durgapur', 1),
('Arjun Roy', 'arjun@gmail.com', '9876543213', 'Siliguri', 1),
('Sneha Gupta', 'sneha@gmail.com', '9876543214', 'Kolkata', 1),
('Rohan Mehta', 'rohan@gmail.com', '9876543215', 'Delhi', 1),
('Ananya Sen', 'ananya@gmail.com', '9876543216', 'Kolkata', 1),
('Vikash Kumar', 'vikash@gmail.com', '9876543217', 'Patna', 1),
('Neha Agarwal', 'neha@gmail.com', '9876543218', 'Ranchi', 1),
('Sourav Ghosh', 'sourav@gmail.com', '9876543219', 'Kolkata', 1);
GO

SELECT * FROM Customers;
GO


    /* 
   2. CATEGORIES
    */

CREATE TABLE Categories
(
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,

    CategoryName VARCHAR(100) NOT NULL UNIQUE,

    Description VARCHAR(250)
);
GO


INSERT INTO Categories
(CategoryName, Description)
VALUES
('Laptops', 'Laptop computers'),
('Mobiles', 'Smartphones and mobile devices'),
('Tablets', 'Tablet computers'),
('Accessories', 'Computer accessories'),
('Headphones', 'Audio headphones'),
('Televisions', 'Smart and LED televisions'),
('Cameras', 'Digital cameras'),
('Gaming', 'Gaming products'),
('Printers', 'Printers and scanners'),
('Smart Watches', 'Wearable smart watches');
GO


  /* 
   3. SUPPLIERS
 */

CREATE TABLE Suppliers
(
    SupplierID INT IDENTITY(1,1) PRIMARY KEY,

    SupplierName VARCHAR(150) NOT NULL,

    Email VARCHAR(150),

    Phone VARCHAR(15),

    City VARCHAR(50),

    IsActive BIT DEFAULT 1
);
GO


INSERT INTO Suppliers
(SupplierName, Email, Phone, City, IsActive)
VALUES
('Tech World Pvt Ltd', 'techworld@gmail.com', '9000000001', 'Kolkata', 1),
('Digital India Suppliers', 'digitalindia@gmail.com', '9000000002', 'Delhi', 1),
('Smart Electronics', 'smart@gmail.com', '9000000003', 'Mumbai', 1),
('Global Gadgets', 'global@gmail.com', '9000000004', 'Bangalore', 1),
('Prime Computers', 'prime@gmail.com', '9000000005', 'Hyderabad', 1),
('NextGen Electronics', 'nextgen@gmail.com', '9000000006', 'Chennai', 1),
('Electro Hub', 'electrohub@gmail.com', '9000000007', 'Pune', 1),
('Future Tech', 'futuretech@gmail.com', '9000000008', 'Kolkata', 1),
('Galaxy Distributors', 'galaxy@gmail.com', '9000000009', 'Ahmedabad', 1),
('Digital Zone', 'digitalzone@gmail.com', '9000000010', 'Jaipur', 1);
GO


  /* 
   4. WAREHOUSES
 */

CREATE TABLE Warehouses
(
    WarehouseID INT IDENTITY(1,1) PRIMARY KEY,

    WarehouseName VARCHAR(100) NOT NULL,

    Location VARCHAR(150) NOT NULL
);
GO


INSERT INTO Warehouses
(WarehouseName, Location)
VALUES
('Kolkata Central Warehouse', 'New Town, Kolkata'),
('Howrah Warehouse', 'Howrah'),
('Delhi Warehouse', 'New Delhi'),
('Mumbai Warehouse', 'Mumbai'),
('Bangalore Warehouse', 'Bangalore'),
('Chennai Warehouse', 'Chennai'),
('Hyderabad Warehouse', 'Hyderabad'),
('Pune Warehouse', 'Pune'),
('Patna Warehouse', 'Patna'),
('Siliguri Warehouse', 'Siliguri');
GO


  /* 
   5. PRODUCTS
 */

CREATE TABLE Products
(
    ProductID INT IDENTITY(1,1) PRIMARY KEY,

    SKU VARCHAR(50) NOT NULL UNIQUE,

    ProductName VARCHAR(150) NOT NULL,

    CategoryID INT NOT NULL,

    SupplierID INT NOT NULL,

    Price DECIMAL(12,2) NOT NULL,

    CostPrice DECIMAL(12,2) NOT NULL,

    ReorderLevel INT NOT NULL DEFAULT 10,

    IsActive BIT DEFAULT 1,

    CONSTRAINT FK_Product_Category
        FOREIGN KEY (CategoryID)
        REFERENCES Categories(CategoryID),

    CONSTRAINT FK_Product_Supplier
        FOREIGN KEY (SupplierID)
        REFERENCES Suppliers(SupplierID),

    CONSTRAINT CK_Product_Price
        CHECK (Price >= 0),

    CONSTRAINT CK_Product_CostPrice
        CHECK (CostPrice >= 0)
);
GO


INSERT INTO Products
(SKU, ProductName, CategoryID, SupplierID, Price, CostPrice, ReorderLevel)
VALUES
('LAP001', 'Dell Inspiron 15', 1, 1, 55000, 47000, 5),
('LAP002', 'HP Pavilion 14', 1, 2, 62000, 53000, 5),
('MOB001', 'Samsung Galaxy S24', 2, 3, 75000, 65000, 10),
('MOB002', 'OnePlus 12', 2, 4, 58000, 50000, 10),
('TAB001', 'iPad Air', 3, 5, 65000, 55000, 5),
('ACC001', 'Logitech Keyboard', 4, 6, 1500, 1000, 15),
('ACC002', 'Logitech Mouse', 4, 7, 900, 600, 20),
('HEAD001', 'Sony Headphones', 5, 8, 12000, 9500, 10),
('TV001', 'LG 55 Inch Smart TV', 6, 9, 65000, 55000, 5),
('WATCH001', 'Apple Watch Series 9', 10, 10, 45000, 38000, 5);
GO


  /* 
   6. INVENTORY
  */

CREATE TABLE Inventory
(
    InventoryID INT IDENTITY(1,1) PRIMARY KEY,

    ProductID INT NOT NULL,

    WarehouseID INT NOT NULL,

    Quantity INT NOT NULL DEFAULT 0,

    LastUpdated DATETIME DEFAULT GETDATE(),

    CONSTRAINT FK_Inventory_Product
        FOREIGN KEY (ProductID)
        REFERENCES Products(ProductID),

    CONSTRAINT FK_Inventory_Warehouse
        FOREIGN KEY (WarehouseID)
        REFERENCES Warehouses(WarehouseID),

    CONSTRAINT CK_Inventory_Quantity
        CHECK (Quantity >= 0),

    CONSTRAINT UQ_Product_Warehouse
        UNIQUE(ProductID, WarehouseID)
);
GO


INSERT INTO Inventory
(ProductID, WarehouseID, Quantity)
VALUES
(1, 1, 3),
(2, 1, 25),
(3, 2, 8),
(4, 3, 30),
(5, 4, 2),
(6, 5, 50),
(7, 6, 100),
(8, 7, 6),
(9, 8, 4),
(10, 9, 20);
GO


/* 
   7. ORDERS
    */

CREATE TABLE Orders
(
    OrderID INT IDENTITY(1,1) PRIMARY KEY,

    CustomerID INT NOT NULL,

    OrderDate DATETIME NOT NULL,

    OrderStatus VARCHAR(30) NOT NULL,

    TotalAmount DECIMAL(12,2) NOT NULL,

    CONSTRAINT FK_Order_Customer
        FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID),

    CONSTRAINT CK_Order_Total
        CHECK (TotalAmount >= 0)
);
GO


INSERT INTO Orders
(CustomerID, OrderDate, OrderStatus, TotalAmount)
VALUES
(1, '2026-08-01', 'Delivered', 56500),
(2, '2026-08-03', 'Delivered', 75000),
(3, '2026-08-05', 'Shipped', 65000),
(4, '2026-08-07', 'Delivered', 12900),
(5, '2026-08-10', 'Processing', 62000),
(6, '2026-08-12', 'Delivered', 75900),
(7, '2026-08-15', 'Shipped', 45000),
(8, '2026-08-18', 'Delivered', 65800),
(9, '2026-08-20', 'Processing', 13500),
(10, '2026-08-25', 'Delivered', 58000);
GO


  /* 
   8. ORDER ITEMS
 */

CREATE TABLE OrderItems
(
    OrderItemID INT IDENTITY(1,1) PRIMARY KEY,

    OrderID INT NOT NULL,

    ProductID INT NOT NULL,

    Quantity INT NOT NULL,

    UnitPrice DECIMAL(12,2) NOT NULL,

    Discount DECIMAL(12,2) DEFAULT 0,

    CONSTRAINT FK_OrderItem_Order
        FOREIGN KEY (OrderID)
        REFERENCES Orders(OrderID),

    CONSTRAINT FK_OrderItem_Product
        FOREIGN KEY (ProductID)
        REFERENCES Products(ProductID),

    CONSTRAINT CK_OrderItem_Quantity
        CHECK (Quantity > 0),

    CONSTRAINT CK_OrderItem_Price
        CHECK (UnitPrice >= 0)
);
GO


INSERT INTO OrderItems
(OrderID, ProductID, Quantity, UnitPrice, Discount)
VALUES
(1, 1, 1, 55000, 0),
(1, 6, 1, 1500, 0),
(2, 3, 1, 75000, 0),
(3, 5, 1, 65000, 0),
(4, 8, 1, 12000, 0),
(4, 7, 1, 900, 0),
(5, 2, 1, 62000, 0),
(6, 1, 1, 55000, 0),
(6, 7, 1, 900, 0),
(7, 10, 1, 45000, 0);
GO


   /* 
   9. PAYMENTS
    */

CREATE TABLE Payments
(
    PaymentID INT IDENTITY(1,1) PRIMARY KEY,

    OrderID INT NOT NULL,

    Amount DECIMAL(12,2) NOT NULL,

    PaymentMethod VARCHAR(30) NOT NULL,

    PaymentStatus VARCHAR(30) NOT NULL,

    PaymentDate DATETIME DEFAULT GETDATE(),

    TransactionReference VARCHAR(100),

    CONSTRAINT FK_Payment_Order
        FOREIGN KEY (OrderID)
        REFERENCES Orders(OrderID),

    CONSTRAINT CK_Payment_Amount
        CHECK (Amount > 0)
);
GO


INSERT INTO Payments
(OrderID, Amount, PaymentMethod, PaymentStatus, TransactionReference)
VALUES
(1, 56500, 'UPI', 'Completed', 'TXN10001'),
(2, 75000, 'Card', 'Completed', 'TXN10002'),
(3, 65000, 'UPI', 'Completed', 'TXN10003'),
(4, 12900, 'Cash', 'Completed', 'TXN10004'),
(5, 62000, 'Card', 'Pending', 'TXN10005'),
(6, 75900, 'UPI', 'Completed', 'TXN10006'),
(7, 45000, 'Card', 'Completed', 'TXN10007'),
(8, 65800, 'UPI', 'Completed', 'TXN10008'),
(9, 13500, 'Cash', 'Pending', 'TXN10009'),
(10, 58000, 'UPI', 'Completed', 'TXN10010');
GO


   /* 
   10. SHIPMENTS
  */

CREATE TABLE Shipments
(
    ShipmentID INT IDENTITY(1,1) PRIMARY KEY,

    OrderID INT NOT NULL UNIQUE,

    CourierName VARCHAR(100),

    TrackingNumber VARCHAR(100),

    ShipmentStatus VARCHAR(30),

    ShippedDate DATETIME,

    DeliveredDate DATETIME,

    CONSTRAINT FK_Shipment_Order
        FOREIGN KEY (OrderID)
        REFERENCES Orders(OrderID)
);
GO


INSERT INTO Shipments
(OrderID, CourierName, TrackingNumber, ShipmentStatus, ShippedDate, DeliveredDate)
VALUES
(1, 'BlueDart', 'BD10001', 'Delivered', '2026-08-02', '2026-08-04'),
(2, 'Delhivery', 'DL10002', 'Delivered', '2026-08-04', '2026-08-06'),
(3, 'BlueDart', 'BD10003', 'Shipped', '2026-08-06', NULL),
(4, 'DTDC', 'DT10004', 'Delivered', '2026-08-08', '2026-08-10'),
(5, 'Delhivery', 'DL10005', 'Processing', NULL, NULL),
(6, 'BlueDart', 'BD10006', 'Delivered', '2026-08-13', '2026-08-15'),
(7, 'DTDC', 'DT10007', 'Shipped', '2026-08-16', NULL),
(8, 'Delhivery', 'DL10008', 'Delivered', '2026-08-19', '2026-08-21'),
(9, 'BlueDart', 'BD10009', 'Processing', NULL, NULL),
(10, 'DTDC', 'DT10010', 'Delivered', '2026-08-26', '2026-08-28');
GO


  /* 
   11. JOIN QUERIES
  */

SELECT
    p.ProductID,
    p.ProductName,
    c.CategoryName,
    p.Price
FROM Products p
INNER JOIN Categories c
    ON p.CategoryID = c.CategoryID;
GO


SELECT
    p.ProductName,
    p.Price,
    s.SupplierName,
    s.City
FROM Products p
INNER JOIN Suppliers s
    ON p.SupplierID = s.SupplierID;
GO


SELECT
    p.ProductName,
    i.Quantity,
    p.ReorderLevel
FROM Products p
INNER JOIN Inventory i
    ON p.ProductID = i.ProductID
WHERE i.Quantity <= p.ReorderLevel;
GO


SELECT
    c.CustomerName,
    o.OrderID,
    o.OrderDate,
    o.OrderStatus,
    o.TotalAmount
FROM Customers c
INNER JOIN Orders o
    ON c.CustomerID = o.CustomerID
ORDER BY o.TotalAmount DESC;
GO


   /*
   12. AGGREGATE QUERIES
   */

SELECT
    SUM(TotalAmount) AS TotalRevenue
FROM Orders;
GO


SELECT
    c.CustomerName,
    COUNT(o.OrderID) AS TotalOrders,
    SUM(o.TotalAmount) AS TotalSpent
FROM Customers c
INNER JOIN Orders o
    ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerName
ORDER BY TotalSpent DESC;
GO


SELECT
    c.CustomerName,
    SUM(o.TotalAmount) AS TotalSpent
FROM Customers c
INNER JOIN Orders o
    ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerName
HAVING SUM(o.TotalAmount) > 50000
ORDER BY TotalSpent DESC;
GO


   /* 
   13. TOP 5 PRODUCTS
   */

SELECT TOP 5
    p.ProductName,
    SUM(oi.Quantity) AS UnitsSold
FROM Products p
INNER JOIN OrderItems oi
    ON p.ProductID = oi.ProductID
GROUP BY p.ProductName
ORDER BY UnitsSold DESC;
GO


   /* 
   14. SECOND HIGHEST PRICE
    */

SELECT
    MAX(Price) AS SecondHighestPrice
FROM Products
WHERE Price <
(
    SELECT MAX(Price)
    FROM Products
);
GO


   /* 
   15. CTE + DENSE_RANK
   */

WITH ProductSales AS
(
    SELECT
        p.ProductID,
        p.ProductName,
        SUM(oi.Quantity * oi.UnitPrice) AS Revenue
    FROM Products p
    INNER JOIN OrderItems oi
        ON p.ProductID = oi.ProductID
    GROUP BY
        p.ProductID,
        p.ProductName
)
SELECT
    ProductName,
    Revenue,
    DENSE_RANK() OVER
    (
        ORDER BY Revenue DESC
    ) AS SalesRank
FROM ProductSales;
GO


/* 
   16. VIEW
   */

CREATE VIEW vw_ProductInventory
AS
SELECT
    p.ProductID,
    p.ProductName,
    c.CategoryName,
    w.WarehouseName,
    i.Quantity,
    p.ReorderLevel,
    p.Price
FROM Products p
INNER JOIN Categories c
    ON p.CategoryID = c.CategoryID
INNER JOIN Inventory i
    ON p.ProductID = i.ProductID
INNER JOIN Warehouses w
    ON i.WarehouseID = w.WarehouseID;
GO


SELECT *
FROM vw_ProductInventory;
GO


/* 
   17. STORED PROCEDURE
   */

CREATE PROCEDURE GetCustomerOrders
    @CustomerID INT
AS
BEGIN

    SELECT
        o.OrderID,
        o.OrderDate,
        o.OrderStatus,
        o.TotalAmount
    FROM Orders o
    WHERE o.CustomerID = @CustomerID
    ORDER BY o.OrderDate DESC;

END;
GO


/* Execute procedure */
EXEC GetCustomerOrders @CustomerID = 1;
GO


/* 
   18. TRANSACTION
    */

BEGIN TRANSACTION;

UPDATE Inventory
SET
    Quantity = Quantity - 1,
    LastUpdated = GETDATE()
WHERE ProductID = 1
AND WarehouseID = 1;

UPDATE Orders
SET OrderStatus = 'Confirmed'
WHERE OrderID = 1;

COMMIT TRANSACTION;
GO
