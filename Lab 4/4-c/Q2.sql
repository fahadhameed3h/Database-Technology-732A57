DROP TABLE IF EXISTS Ticket;
DROP TABLE IF EXISTS Passenger;
DROP TABLE IF EXISTS CreditCard;
DROP TABLE IF EXISTS Contact;
DROP TABLE IF EXISTS Reservation;
DROP TABLE IF EXISTS Flight;
DROP TABLE IF EXISTS WeeklySchedule;
DROP TABLE IF EXISTS Route;
DROP TABLE IF EXISTS WeekDay;
DROP TABLE IF EXISTS Year;
DROP TABLE IF EXISTS Destination;

CREATE TABLE Destination(
    Code VARCHAR(3),
    Country VARCHAR(30),
    AirportName VARCHAR(30),
    CONSTRAINT PK_destination PRIMARY KEY(Code)
);

CREATE TABLE Year(
    Year INTEGER NOT NULL, 
    ProfitFactor DOUBLE NOT NULL, 
    CONSTRAINT PK_year PRIMARY KEY(year)
); 

CREATE TABLE WeekDay(
   Year INTEGER NOT NULL,
   Day VARCHAR(10),
   WeekDayFactor DOUBLE NOT NULL,
   CONSTRAINT PK_day PRIMARY KEY(day, year),
   CONSTRAINT FK_day_year FOREIGN KEY(year) REFERENCES Year(year)
);


CREATE TABLE Route(
    RouteID INTEGER NOT NULL AUTO_INCREMENT,
    DestinationFrom VARCHAR(3),
    DestinationTO VARCHAR(3),
    Year INTEGER,
    Routeprice DOUBLE DEFAULT 0,      
    CONSTRAINT PK_route PRIMARY KEY(RouteID)
);

ALTER TABLE Route ADD CONSTRAINT FK_destinationTO FOREIGN KEY(DestinationTO) REFERENCES Destination(Code);
ALTER TABLE Route ADD CONSTRAINT FK_destinationFrom FOREIGN KEY(DestinationFrom) REFERENCES Destination(Code);
ALTER TABLE Route ADD CONSTRAINT FK_Year FOREIGN KEY(Year) REFERENCES Year(Year);


CREATE TABLE WeeklySchedule(
    WeeklyScheduleID INTEGER NOT NULL AUTO_INCREMENT, 
    DepartureTime TIME,
    WS_RouteID INTEGER,
    Day VARCHAR(10), 
    Year INTEGER, 
    CONSTRAINT PK_weeklyschedule PRIMARY KEY(WeeklyScheduleID),
    CONSTRAINT FK_Routeid FOREIGN KEY(WS_RouteID) REFERENCES Route(RouteID),
    CONSTRAINT FK_day FOREIGN KEY(Day) REFERENCES WeekDay(Day),
    CONSTRAINT FK_yearR FOREIGN KEY(Year) REFERENCES Year(year)
);

CREATE TABLE Contact(
    PassportNumber INTEGER,
    Email VARCHAR(30) NOT NULL, 
    PhNumber BIGINT, 
    CONSTRAINT PK_contact PRIMARY KEY(PassportNumber)
);

CREATE TABLE CreditCard(
    CreditcardNumber BIGINT NOT NULL,
    Owner VARCHAR(30),
    CONSTRAINT PK_creditcard PRIMARY KEY(CreditcardNumber)
);

CREATE TABLE Passenger(
     PassportNumber INTEGER NOT NULL,
     PassangeName VARCHAR(30),
     CONSTRAINT PK_passenger PRIMARY KEY(PassportNumber)   
);

CREATE TABLE Flight(
    FlightNumber INTEGER NOT NULL AUTO_INCREMENT, 
    Seat INTEGER DEFAULT 40,
    Week INTEGER NOT NULL, 
    F_WeeklyScheduleID INTEGER NOT NULL,
    CONSTRAINT PK_flight PRIMARY KEY(FlightNumber),
    CONSTRAINT FK_WeeklySchedule FOREIGN KEY(F_WeeklyScheduleID) REFERENCES WeeklySchedule(WeeklyScheduleID)
);

CREATE TABLE Reservation(
    ReservationNumber INTEGER NOT NULL AUTO_INCREMENT,
    nrOfPassengers INTEGER, 
    FlightNumber INTEGER NOT NULL, 
    Payment Integer DEFAULT 0,
    PassportNumber INTEGER,
    CONSTRAINT PK_reservation PRIMARY KEY(ReservationNumber),
    CONSTRAINT FK_FlightNumber FOREIGN KEY(FlightNumber) REFERENCES Flight(FlightNumber)
);

CREATE TABLE Ticket(
    TicketNumber INTEGER,
    ReservationNumber INTEGER NOT NULL,
    CreditcardNumber BIGINT NOT NULL, 
    AmountPaid DOUBLE DEFAULT 0,
    PassportNumber INTEGER NOT NULL,
    CONSTRAINT PK_TicketNumber PRIMARY KEY(ReservationNumber,PassportNumber),
    CONSTRAINT FK_ReservationNumber FOREIGN KEY(ReservationNumber) REFERENCES Reservation(ReservationNumber),
    CONSTRAINT FK_PassportNumber FOREIGN KEY(PassportNumber) REFERENCES Passenger(PassportNumber)
);
