Drop Function IF exists calculateFreeSeats;
Drop Function IF exists calculatePrice;

DELIMITER //
CREATE FUNCTION calculateFreeSeats(flightnumber_val INTEGER)
RETURNS INTEGER

BEGIN
   DECLARE passengersCount INTEGER;
   DECLARE freeSeats INTEGER;
   SELECT sum(nrOfPassengers) into passengersCount from Reservation
   where ReservationNumber in
   (SELECT ReservationNumber from Reservation where FlightNumber = flightnumber_val);
   SET freeSeats = 41 - passengersCount;
   RETURN freeSeats;

END;
// 
DELIMITER ;


DELIMITER //

CREATE FUNCTION calculatePrice(in_flightnumber INT)
RETURNS DOUBLE DETERMINISTIC
BEGIN
    DECLARE FirstRoute DOUBLE;
    DECLARE WD_Factor DOUBLE;
    DECLARE ReservedPessangers Integer;
    DECLARE PF_Factor DOUBLE;
    DECLARE totalPrice DOUBLE;
    DECLARE WeekLYSD_ID Integer;
    DECLARE NumTotalSeats Integer;
    SET NumTotalSeats = 40;

    SELECT F_WeeklyScheduleID INTO WeekLYSD_ID
    FROM Flight
    WHERE Flight.FlightNumber = in_flightnumber;
        
    SELECT Routeprice into FirstRoute FROM Route INNER JOIN WeeklySchedule
        ON WeeklySchedule.WS_RouteID = Route.RouteID
        AND WeekLYSD_ID = WeeklySchedule.WeeklyScheduleID;
    
    SELECT WeekDayFactor into WD_Factor FROM WeekDay
    INNER JOIN WeeklySchedule
    ON WeeklySchedule.Day= WeekDay.Day
    AND WeeklySchedule.Year = WeekDay.Year
    AND WeekLYSD_ID = WeeklySchedule.WeeklyScheduleID;
        
    SET ReservedPessangers = NumTotalSeats - calculateFreeSeats(in_flightnumber);
    
    SELECT ProfitFactor into PF_Factor
    FROM Year 
    WHERE Year = (SELECT Year 
                    FROM WeeklySchedule 
                    WHERE WeeklyScheduleID = (SELECT F_WeeklyScheduleID FROM Flight WHERE FlightNumber = in_flightnumber));
     
    SET totalPrice = FirstRoute * WD_Factor * ((ReservedPessangers + 1)/40) * PF_Factor;

    RETURN totalPrice;
END;// 
DELIMITER ;