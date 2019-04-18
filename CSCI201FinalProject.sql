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
    buyTime BIGINT(64),
    buyPrice FLOAT(32),
    amount FLOAT(11),
    FOREIGN KEY (portfolioID) REFERENCES Portfolio(PortfolioID)
);

CREATE TABLE Trades (
	portfolioID INT(11),
    symbol VARCHAR(8),
    buyTime BIGINT(64),
    sellTime BIGINT(64),
    buyPrice FLOAT(32),
    sellPrice FLOAT(32),
    amount FLOAT(11),
    FOREIGN KEY (portfolioID) REFERENCES Portfolio(portfolioID)
);

INSERT INTO User (username, userPassword)
	VALUES ('TestUsername1', 'TestPassword1'),
		   ('TestUsername2', 'TestPassword2'),
		   ('TestUsername3', 'TestPassword3'),
           ('a','a');
           

    