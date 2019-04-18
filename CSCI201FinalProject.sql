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
    buyTime INT(64),
    buyPrice FLOAT(32),
    amount FLOAT(11),
    FOREIGN KEY (portfolioID) REFERENCES Portfolio(PortfolioID)
);

CREATE TABLE Trades (
	portfolioID INT(11),
    symbol VARCHAR(8),
    buyTime INT(64),
    sellTime INT(64),
    buyPrice FLOAT(32),
    sellPrice FLOAT(32),
    amount FLOAT(11),
    FOREIGN KEY (portfolioID) REFERENCES Portfolio(portfolioID)
);

INSERT INTO User (username, userPassword)
	VALUES ('TestUsername1', 'TestPassword1'),
		   ('TestUsername2', 'TestPassword2'),
		   ('TestUsername3', 'TestPassword3');
           
INSERT INTO Portfolio (portfolioName)
	VALUES ('TestPortfolio');
    
INSERT INTO Positions (symbol, buyTime, buyPrice, amount)
	VALUES ('BTCUSDT', '1555567862', '5014.56', '0.358420'),
		   ('ETHUSDT', '1555567862', '163.75', '1.5673'),
		   ('XRPUSDT', '1555567877', '0.32236', '457.2312');
           
INSERT INTO Trades (symbol, buyTime, sellTime, buyPrice, sellPrice, amount)
	VALUES ('BTCUSDT', '1555567862', '1555567901', '5014.56', '5236.84', '0.358420'),
		   ('ETHUSDT', '1555567862', '1555567901', '163.75', '154.35', '1.5673'),
		   ('XRPUSDT', '1555567877', '1555567901', '0.32236', '0.37865', '457.2312');
    