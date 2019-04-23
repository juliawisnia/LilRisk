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
	VALUES ('LilUser', 'lilpassword'),
		   ('LilWayne', 'a'),
		   ('LilDicky', 'a'),
		   ('LilPeep','a'),
           ('LilYatchy','a');
           
INSERT INTO Portfolio (userID, portfolioName)
	VALUES (1, 'LilDemo'),
		   (1, 'LilRisky'),
           (1, 'BigRisky'),
		   (2, 'Uproar'),
		   (2, 'Mirror'),
		   (2, 'Forever'),
           (3, 'TooHigh'),
		   (3, 'Molly'),
		   (4, 'Runaway'),
           (4, '16Lines'),
		   (5, 'OnMe'),
		   (5, 'Dripped'),
           (5, 'DRAM');

INSERT INTO Positions (portfolioID, symbol, buyTime, buyPrice, amount)
	VALUES (1, 'ETHUSDT', '1550020448000', '163.75', '2.5673'),
		   (1, 'XRPUSDT', '1555627435000', '0.32236', '457.2312'),
           (1, 'EOSUSDT', '1555627486000', '5.0872', '103.8762'),
           (1, 'IOTAUSDT', '155562738800', '0.2997', '598.32'),
           (1, 'ADAUSDT', '1555628428800', '0.068557', '2304.72'),
		   (2, 'XRPUSDT', '1550020448000', '0.31755', '423.12'),
           (2, 'IOTAUSDT', '155562738800', '0.2997', '598.32'),
		   (3, 'ADAUSDT', '1555628428800', '0.071257', '1874.37'),
           (3, 'ETHUSDT', '1555627439400', '173.75', '32.5983'),
           (3, 'EOSUSDT', '1555622354070', '4.9202', '204.9283'),
		   (4, 'ETHUSDT', '1555627432000', '173.75', '12.5673'),
           (4, 'EOSUSDT', '1555627454000', '5.1102', '58.9283'),
		   (4, 'IOTAUSDT', '155562738800', '0.2997', '598.32'),
           (4, 'ADAUSDT', '1555628428800', '0.068557', '2304.72'),
		   (5, 'ETHUSDT', '1555627432000', '177.75', '18.5983'),
           (5, 'ADAUSDT', '1555628428800', '0.068557', '2284.72'),
           (5, 'XRPUSDT', '1550028648000', '0.31755', '873.12'),
		   (6, 'XRPUSDT', '1550020448000', '0.31755', '423.12'),
           (6, 'IOTAUSDT', '155562738800', '0.2997', '598.32'),
           (7, 'IOTAUSDT', '155562738800', '0.2997', '827.92'),
           (8, 'XRPUSDT', '1550020448000', '0.32236', '457.2312'),
           (8, 'ETHUSDT', '1555627432000', '189.75', '8.5983'),
           (8, 'XRPUSDT', '1550023448', '0.30855', '183.12'),
           (9, 'EOSUSDT', '1555626354070', '4.9202', '204.9283'),
		   (10, 'EOSUSDT', '1555626273070', '4.9802', '144.9283'),
           (10, 'IOTAUSDT', '155562736800', '0.2797', '346.32'),
           (11, 'ADAUSDT', '1555628428800', '0.072557', '2304.72'),
           (12, 'ADAUSDT', '1555628428800', '0.071257', '1874.37'),
           (12, 'ETHUSDT', '1555627439400', '173.75', '32.5983'),
           (12, 'EOSUSDT', '1555622354070', '4.9202', '204.9283'),
           (13, 'ETHUSDT', '1555627439400', '173.75', '32.5983');
           

INSERT INTO Trades (portfolioID, symbol, buyTime, sellTime, buyPrice, sellPrice, amount)
	VALUES (1, 'BTCUSDT', '1555627432000', '1555627796000', '5014.56', '5236.84', '0.358420'),
		   (1, 'ETHUSDT', '1555627432000', '1555627796000', '163.75', '154.35', '1.5673'),
		   (1, 'XRPUSDT', '1555627432000', '1555627796000', '0.32236', '0.37865', '457.2312'),
		   (4, 'BTCUSDT', '1555627432000', '1555627796000', '5214.56', '5436.84', '1.358420'),
		   (4, 'ETHUSDT', '1555627432000', '1555627796000', '173.75', '181.35', '12.5673'),
		   (4, 'XRPUSDT', '1555627432000', '1555627796000', '0.32236', '0.37865', '457.2312');
    
