-- Week 7 Assignment: Database Design and Normalization

-- Question 1: Achieving 1NF (First Normal Form)
-- Task: Transform the ProductDetail table into 1NF by ensuring each row represents a single product for an order.
-- Approach: The Products column contains multiple values (e.g., 'Laptop, Mouse'), violating 1NF. 
-- We need to split these into separate rows, with one product per row, while keeping OrderID and CustomerName.

CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100)
);

INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product)
VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');

-- Explanation: The new table ProductDetail_1NF has one product per row, satisfying 1NF by eliminating multi-valued attributes.
-- Each row now represents a single product for an order, with OrderID and CustomerName repeated as needed.

-- Question 2: Achieving 2NF (Second Normal Form)
-- Task: Transform the OrderDetails table (already in 1NF) into 2NF by removing partial dependencies.
-- Approach: The CustomerName column depends only on OrderID, not the full primary key (OrderID, Product), violating 2NF.
-- We split the table into two: one for order-level data (Orders) and one for product-level data (Product).

-- Step 1: Create the Orders table to store OrderID and CustomerName
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

INSERT INTO Orders (OrderID, CustomerName)
VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

-- Step 2: Create the Product table to store OrderID, Product, and Quantity
CREATE TABLE Product (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

INSERT INTO Product (OrderID, Product, Quantity)
VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);

-- Explanation: The Orders table stores customer information that depends only on OrderID.
-- The Product table stores product details, with (OrderID, Product) as the primary key, ensuring all non-key columns (Quantity)
-- fully depend on the entire primary key. The foreign key ensures referential integrity.
