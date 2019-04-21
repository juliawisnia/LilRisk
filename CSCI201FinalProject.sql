DROP DATABASE IF EXISTS steelest_LilRisk;
CREATE DATABASE steelest_LilRisk;
USE steelest_LilRisk;

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
    symbol VARCHAR(12),
    buyTime BIGINT(64),
    buyPrice FLOAT(32),
    amount FLOAT(32),
    FOREIGN KEY (portfolioID) REFERENCES Portfolio(PortfolioID)
);

CREATE TABLE Trades (
	portfolioID INT(11),
    symbol VARCHAR(12),
    buyTime BIGINT(64),
    sellTime BIGINT(64),
    buyPrice FLOAT(32),
    sellPrice FLOAT(32),
    amount FLOAT(32),
    FOREIGN KEY (portfolioID) REFERENCES Portfolio(portfolioID)
);

CREATE TABLE Friends(
	userID INT(11),
    friendID INT(11),
    FOREIGN KEY (userID) REFERENCES User(userID),
    FOREIGN KEY (friendID) REFERENCES User(userID)
);



INSERT INTO User (username, userPassword)
	VALUES ('TestUsername1', 'TestPassword1'),
		   ('TestUsername2', 'TestPassword2'),
		   ('TestUsername3', 'TestPassword3'),
                   ('Julia','Wisnia');
           
INSERT INTO Portfolio (userID, portfolioName)
	VALUES (1, 'TestPortfolio'),
		   (4, 'Julia'),
          	   (4, 'Mallika'),
       	           (4, 'Robert'),
                   (4, 'Alan');

INSERT INTO Positions (portfolioID, symbol, buyTime, buyPrice, amount)
	VALUES (1, 'BTCUSDT', '1555627432', '5014.56', '0.358420'),
		   (1, 'ETHUSDT', '1555627432', '163.75', '1.5673'),
		   (1, 'XRPUSDT', '15556274325', '0.32236', '457.2312'),
          	   (2, 'BTCUSDT', '1555627432', '5214.56', '1.358420'),
       	           (2, 'ETHUSDT', '1555627432', '173.75', '12.5673'),
		   (3, 'ETHUSDT', '1555627432', '173.75', '12.5673'),
		   (4, 'XRPUSDT', '15556274325', '0.32236', '457.2312'),
      	           (5, 'BTCUSDT', '1555627432', '4214.56', '1.358420');
           

INSERT INTO Trades (portfolioID, symbol, buyTime, sellTime, buyPrice, sellPrice, amount)
	VALUES (1, 'BTCUSDT', '1555627432', '1555627796000', '5014.56', '5236.84', '0.358420'),
		   (1, 'ETHUSDT', '1555627432', '1555627796000', '163.75', '154.35', '1.5673'),
		   (1, 'XRPUSDT', '1555627432', '1555627796000', '0.32236', '0.37865', '457.2312'),
           	   (4, 'BTCUSDT', '1555627432', '1555627796000', '5214.56', '5436.84', '1.358420'),
		   (4, 'ETHUSDT', '1555627432', '1555627796000', '173.75', '181.35', '12.5673'),
		   (4, 'XRPUSDT', '1555627432', '1555627796000', '0.32236', '0.37865', '457.2312');
    
