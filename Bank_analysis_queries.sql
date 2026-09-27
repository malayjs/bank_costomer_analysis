CREATE DATABASE BI ;
USE bi ;

CREATE TABLE Customers(
CustomerID INT PRIMARY KEY ,
Name VARCHAR(50),
Age INT ,
Gender VARCHAR(30),
Region VARCHAR (50),
IncomeLevel VARCHAR (10)
);

CREATE TABLE Accounts (
AccountID INT PRIMARY KEY ,
Cust_id INT, FOREIGN KEY (Cust_id) references Customers(CustomerID),
AccountType VARCHAR (50),
Balance DECIMAL(12,2),
AccountStatus VARCHAR (50)
);

CREATE TABLE Transactions(
    TransactionID INT PRIMARY KEY,
    Acc_ID INT,
    Date VARCHAR(20),
    Amount DECIMAL(12,2),
    TransactionType VARCHAR(50)
);

SELECT Date
FROM Transactions
LIMIT 5;

SELECT COUNT(*) FROM Customers;
SELECT COUNT(*) FROM Accounts;
SELECT COUNT(*) FROM Transactions;

# How many accounts are closed?

SELECT COUNT(*) AS ClosedAccounts
FROM Accounts
WHERE AccountStatus='Closed';

# How many accounts have high loan balance (> ₹3,00,000)?

SELECT COUNT(*) AS HighLoanAccounts
FROM Accounts
WHERE AccountType='Loan'
AND Balance > 300000;

# Which region has the highest total balance?

SELECT
Customers.Region,
SUM(Accounts.Balance) AS TotalBalance
FROM Customers 
JOIN Accounts 
ON customers.CustomerID = Accounts.Cust_id
GROUP BY customers.Region
ORDER BY TotalBalance DESC;

# What is the average balance by income level?

SELECT
customers.IncomeLevel,
AVG(Accounts.Balance) AS AvgBalance
FROM Customers 
JOIN Accounts 
ON Customers.CustomerID = Accounts.Cust_id
GROUP BY customers.IncomeLevel;

# Monthly transaction trend

SELECT
LEFT(Date,7) AS Month,
COUNT(*) AS Transactions
FROM Transactions
GROUP BY Month
ORDER BY Month;

# How many customers are in each region?

SELECT
Region,
COUNT(*) AS Customers
FROM Customers
GROUP BY Region;

# Which account type is most common?

SELECT
AccountType,
COUNT(*) AS TotalAccounts
FROM Accounts
GROUP BY AccountType
ORDER BY TotalAccounts DESC;

# Top 10 customers by balance
SELECT
  Customers.Name,
  SUM(Accounts.Balance) AS TotalBalance
FROM Customers
JOIN Accounts
  ON Customers.CustomerID = Accounts.Cust_id
GROUP BY
  Customers.CustomerID,
  Customers.Name
ORDER BY
  TotalBalance DESC
LIMIT 10;
# Account Status Distribution

SELECT
AccountStatus,
COUNT(*) AS TotalAccounts
FROM Accounts
GROUP BY AccountStatus;

# How many loan accounts exist?

SELECT COUNT(*) AS LoanAccounts
FROM Accounts
WHERE AccountType='Loan';