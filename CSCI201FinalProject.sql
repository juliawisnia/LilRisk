DROP DATABASE IF EXISTS LilRisk;
CREATE DATABASE LilRisk;
USE LilRisk;

CREATE TABLE User (
	userID INT(11) PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    userPassword VARCHAR(50) NULL
);

CREATE TABLE Portfolio (
	userID INT(11),
    portfolioID INT(11) PRIMARY KEY AUTO_INCREMENT,
	portfolioName VARCHAR(20)
);

CREATE TABLE Positions (
	portfolioID INT(11),
    symbol VARCHAR(8),
    dateTime VARCHAR(30),
    buyPrice FLOAT(32),
    amount FLOAT(11)
);

CREATE TABLE Trades (
	portfolioID INT(11),
    symbol VARCHAR(8),
    dateTime VARCHAR(30),
    buyPrice FLOAT(32),
    sellPrice FLOAT(32),
    amount FLOAT(11)
);

INSERT INTO User (username, userPassword)
	VALUES ('TestUsername1', 'TestPassword1'),
		   ('TestUsername2', 'TestPassword2'),
		   ('TestUsername3', 'TestPassword3');
           
INSERT INTO Portfolio (portfolioName)
	VALUES ('TestPortfolio');
    
INSERT INTO Positions (symbol, dateTime, buyPrice, amount)
	VALUES ('BTCUSDT', 'April 10 9:16:05', '5014.56', '0.358420'),
		   ('ETHUSDT', 'April 11 14:34:25', '163.75', '1.5673'),
		   ('XRPUSDT', 'April 11 20:54:15', '0.32236', '457.2312');
           
INSERT INTO Trades (symbol, dateTime, buyPrice, sellPrice, amount)
	VALUES ('BTCUSDT', 'April 10 9:16:05', '5014.56', '5236.84', '0.358420'),
		   ('ETHUSDT', 'April 11 14:34:25', '163.75', '154.35', '1.5673'),
		   ('XRPUSDT', 'April 11 20:54:15', '0.32236', '0.37865', '457.2312');
    
