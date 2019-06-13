DROP PROCEDURE IF EXISTS addYear;
DROP PROCEDURE IF EXISTS addDay;
DROP PROCEDURE IF EXISTS addDestination;
DROP PROCEDURE IF EXISTS addRoute;
DROP PROCEDURE IF EXISTS addFlight;

DELIMITER //
CREATE PROCEDURE addYear(IN yearVal INTEGER, IN factorVal DOUBLE)
  BEGIN
	INSERT INTO Year(Year, ProfitFactor)
	VALUES (yearVal, factorVal);
  END;  //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE addDay(IN yearVal INTEGER,  IN dayVal VARCHAR(10),  IN factorVal DOUBLE)
  BEGIN
	INSERT INTO WeekDay(Year, Day, WeekDayFactor)
	VALUES (yearVal, dayVal, factorVal);
  END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE addDestination(IN airport_code VARCHAR(3), IN name VARCHAR(30), IN country VARCHAR(30))
  BEGIN
	INSERT INTO Destination(Code, Country, AirportName)
	VALUES (airport_code, country, name);
  END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE addRoute(IN departure_airport_code VARCHAR(3), IN arrival_airport_code VARCHAR(3), IN year INTEGER, IN routeprice DOUBLE)
  BEGIN
	INSERT INTO Route(DestinationFrom, DestinationTo, Year, Routeprice)
	VALUES (departure_airport_code, arrival_airport_code, year, routeprice);
  END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE addFlight(IN departure_airport_code VARCHAR(3), IN arrival_airport_code VARCHAR(3), IN yearVal INTEGER, IN dayVal varchar(10), IN departure_time TIME)
  BEGIN
	
       DECLARE PreviousID INTEGER;
       DECLARE currRouteID INTEGER;
       DECLARE currWeek INT DEFAULT 1;
  	
       SELECT RouteID INtO currRouteID 
	FROM Route 
	WHERE Year=yearVal AND DestinationTO=arrival_airport_code AND DestinationFrom=departure_airport_code;

       INSERT INTO WeeklySchedule(DepartureTime, WS_RouteID, Day, Year)
       VALUES(departure_time,currRouteID, dayVal, yearVal);

     	SET PreviousID = LAST_INSERT_ID(); 
	
	WHILE currWeek <= 52 DO
           INSERT INTO Flight(Week, F_WeeklyScheduleID) VALUES (currWeek, PreviousID);
	   SET currWeek = currWeek + 1;
	END WHILE;

  END //
DELIMITER ;