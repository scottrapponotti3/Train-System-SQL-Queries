
/* User Table */
CREATE TABLE User (
    Username VARCHAR(20) PRIMARY KEY,
    Password VARCHAR(20) NOT NULL,
    Unique(Password)
);

/* Manager Table */
CREATE TABLE Manager (
    Username VARCHAR(20) PRIMARY KEY,
    FOREIGN KEY(Username) REFERENCES User(Username)
);

/* Customer Table */
CREATE TABLE Customer (
    Username VARCHAR(20) PRIMARY KEY REFERENCES User(Username),
    EmailAddress VARCHAR(50) NOT NULL,
    IsStudent INT(1) DEFAULT 0,
    UNIQUE(EmailAddress)
);

/* Card Table */
CREATE TABLE Card (
    CardNumber BIGINT(16) PRIMARY KEY,
    CVV INT(3) NOT NULL,
    Name VARCHAR(100) NOT NULL,
    ExpirationDate VARCHAR(7) NOT NULL,
    Username VARCHAR(20) NOT NULL,
	FOREIGN KEY(Username) REFERENCES Customer(Username)
);

/* Reservation Table */
CREATE TABLE Reservation (
    ReservationID INT(5) AUTO_INCREMENT PRIMARY KEY,
    NumUpdates INT(11) DEFAULT 0,
    CancellationDate DATE DEFAULT NULL,
    IsCancelled INT(1) DEFAULT 0,
    Username VARCHAR(20) NOT NULL,
    CardNumber BIGINT(16),
    FOREIGN KEY(Username) REFERENCES Customer(Username),
    FOREIGN KEY(CardNumber) REFERENCES Card(CardNumber)
);

/* Train Table */
CREATE TABLE Train (
    TrainNumber VARCHAR(50) PRIMARY KEY,
	1stClassPrice FLOAT(5,2),
    2ndClassPrice FLOAT(5,2)
);

/* Review Table */
CREATE TABLE Review (
	ReviewNum INT(5) AUTO_INCREMENT,
	Username VARCHAR(20),
	Rating VARCHAR(20) NOT NULL,
	Comment VARCHAR(250),
	TrainNumber VARCHAR(50) NOT NULL,
	PRIMARY KEY(ReviewNum,Username),
	FOREIGN KEY(TrainNumber) REFERENCES Train(TrainNumber),
	FOREIGN KEY (Username) REFERENCES Customer(Username)
);

/* Station Table */
CREATE TABLE Station (
    Location VARCHAR (50),
    StationName VARCHAR(50),
    PRIMARY KEY (Location, StationName)
);

/* Route Table */
CREATE TABLE Route (
    RouteNum INT (5) AUTO_INCREMENT,
	Location VARCHAR (50),
    StationName VARCHAR(50),
    ArrivalTime TIME,
    DepartureTime TIME,
    PRIMARY KEY (RouteNum),
    FOREIGN KEY (Location, StationName) REFERENCES Station(Location,StationName)
);

/* Takes Table */
CREATE TABLE Takes (
    RouteNum INT(5),
    TrainNumber VARCHAR(50),
    PRIMARY KEY (RouteNum, TrainNumber),
    FOREIGN KEY (RouteNum) REFERENCES Route(RouteNum),
    FOREIGN KEY(TrainNumber) REFERENCES Train(TrainNumber)
);

/* Ticket Table */
CREATE TABLE Ticket (
    TicketID INT(5) AUTO_INCREMENT,
    ReservationID INT(5),
    NumBags INT(1) NOT NULL,
    DepartureDate DATE NOT NULL,
    PassengerName VARCHAR(20) NOT NULL,
    ArrivalRouteNum INT(5) NOT NULL,
	DepartureRouteNum INT(5) NOT NULL,
    Class VARCHAR(10),
    Price FLOAT(6,2),
    PRIMARY KEY (TicketID),
    FOREIGN KEY (ArrivalRouteNum) REFERENCES Route(RouteNum),
    FOREIGN KEY (DepartureRouteNum) REFERENCES Route(RouteNum),
    FOREIGN KEY (ReservationID) REFERENCES Reservation(ReservationID)
);

/* System Table */
CREATE TABLE System (
    MaxBags INT(1),
    FreeBags INT(1),
    SDiscount FLOAT(3,2),
    ChargeFee FLOAT(5,2),
    PRIMARY KEY (MaxBags)
);
