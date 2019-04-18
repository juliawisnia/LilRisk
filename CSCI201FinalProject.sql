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
	portfolioName VARCHAR(20),
	FOREIGN KEY (userID) REFERENCES User(userID)
);

CREATE TABLE Positions (
	portfolioID INT(11),
    symbol VARCHAR(8),
    buyTime VARCHAR(30),
    buyPrice FLOAT(32),
    amount FLOAT(11),
    FOREIGN KEY (portfolioID) REFERENCES Portfolio(PortfolioID)
);

CREATE TABLE Trades (
	portfolioID INT(11),
    symbol VARCHAR(8),
    buyTime VARCHAR(30),
    sellTime VARCHAR(30),
    buyPrice FLOAT(32),
    sellPrice FLOAT(32),
    amount FLOAT(11),
    FOREIGN KEY (portfolioID) REFERENCES Portfolio(portfolioID)
);

INSERT INTO User (username, userPassword)
	VALUES ('TestUsername1', 'TestPassword1'),
		   ('TestUsername2', 'TestPassword2'),
		   ('TestUsername3', 'TestPassword3');
           
INSERT INTO Portfolio (userID, portfolioName)
	VALUES (1, 'TestPortfolio');
    
INSERT INTO Positions (portfolioID, symbol, buyTime, buyPrice, amount)
	VALUES (1, 'BTCUSDT', 'April 10 9:16:05', '5014.56', '0.358420'),
		   (1, 'ETHUSDT', 'April 11 14:34:25', '163.75', '1.5673'),
		   (1, 'XRPUSDT', 'April 11 20:54:15', '0.32236', '457.2312');
           
INSERT INTO Trades (portfolioID, symbol, buyTime, sellTime, buyPrice, sellPrice, amount)
	VALUES (1, 'BTCUSDT', 'April 10 9:16:05', 'April 11 9:16:05', '5014.56', '5236.84', '0.358420'),
		   (1, 'ETHUSDT', 'April 11 14:34:25', 'April 12 9:16:05', '163.75', '154.35', '1.5673'),
		   (1, 'XRPUSDT', 'April 11 20:54:15', 'April 12 9:16:05', '0.32236', '0.37865', '457.2312');
    