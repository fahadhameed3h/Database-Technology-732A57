drop procedure if exists addReservation;
drop procedure if exists addPassenger;
drop procedure if exists addContact;
drop procedure if exists addPayment;

delimiter //
create procedure addReservation(
	in departure_airport_code VarCHAR(3), 
	in arrival_airport_code VarCHAR(3),
	in year INTEGER, 
	in week INTEGER, 
	in day VarCHAR(10), 
	in time time,
	in number_of_passengers INTEGER, 
	out output_reservation_nr INTEGER)

begin
  declare CurerentFlightNumber INTEGER;
  declare reservationid INTEGER;
  declare RID INTEGER;
  declare R_ID INTEGER;

  set CurerentFlightNumber = NULL;
  set reservationid = NULL;

  select RouteID into RID from Route as R_TB where R_TB.DestinationFrom = departure_airport_code and R_TB.DestinationTO = arrival_airport_code;
  select RouteID into R_ID from Route as R_TB where R_TB.DestinationFrom = departure_airport_code and R_TB.DestinationTO = arrival_airport_code;

    select FlightNumber into CurerentFlightNumber from Flight as FLt
    where FLt.Week = week
    and FLt.F_WeeklyScheduleID in (select WeeklyScheduleID from WeeklySchedule as WS_TB where WS_TB.Year = year 
				    and WS_TB.Day = day 
				    and WS_TB.DepartureTime = time 
				    and WS_TB.WS_RouteID in (RID));
    	
	if(CurerentFlightNumber IS NULL) then
	     select 'There exist no flight for the given route, date and time' as 'message';
        elseif ( number_of_passengers > (calculateFreeSeats(CurerentFlightNumber))) then
	      select 'There are not enough seats available on the chosen flight' as 'Message';
	else              
	      	
	      insert into Reservation(nrOfPassengers, FlightNumber) values (number_of_passengers,CurerentFlightNumber);
	      select max(ReservationNumber) into reservationid from Reservation
	      where CurerentFlightNumber = FlightNumber and nrOfPassengers = number_of_passengers;

       set output_reservation_nr = reservationid;
   end if;
  
end;

// 
delimiter ;

delimiter //

CREATE PROCEDURE addPassenger(IN reservation_nr INTEGER, IN passport_nr INTEGER, IN name varchar(30))

BEGIN

DECLARE ContactCheck, reservationNumberCheck,Flight_number_Check, CheckFreeSeats, psNum , IsPaymentDone INTEGER;

select ReservationNumber into reservationNumberCheck
from Reservation
where ReservationNumber = reservation_nr;

select FlightNumber into Flight_number_Check from Reservation where ReservationNumber = reservation_nr;
select Seat into CheckFreeSeats from Flight where FlightNumber = Flight_number_Check;
select count(*) into IsPaymentDone from Reservation where ReservationNumber = reservation_nr AND Payment = 1;

IF (reservationNumberCheck is NULL) THEN
	select 'The given reservation number does not exist' as 'message';

ELSEIF (IsPaymentDone <> 0) THEN
	SELECT "The booking has already been payed and no further passengers can be added" AS Message;
ELSE 

	select PassportNumber into psNum from Passenger where passport_nr = PassportNumber;

	IF (psNum is NULL) THEN
		insert into Passenger(PassportNumber, PassangeName)
		values (passport_nr, name);

		update Ticket
		set PassportNumber = passport_nr
		where ReservationNumber = reservation_nr;

		Set CheckFreeSeats = CheckFreeSeats - 1;

		update Flight
		set Seat = CheckFreeSeats
		where FlightNumber = Flight_number_Check;

	Else
		update Ticket
		set PassportNumber = passport_nr
		where ReservationNumber = reservation_nr;
END IF;
END IF;

END;
//	 
delimiter ;


delimiter //
CREATE PROCEDURE addContact(IN reservation_nr INTEGER, IN passport_number INTEGER, IN email varchar(30), IN phone bigint)

BEGIN

DECLARE in_reservation_Number, passport_in_reservation, PassangerNUmberChe, ContactNumberCHe INTEGER;

select PassportNumber into PassangerNUmberChe
from Passenger
where PassportNumber = passport_number;

select ReservationNumber into in_reservation_Number
from Reservation
where ReservationNumber = reservation_nr;

select PassportNumber into ContactNumberCHe
from Contact
where PassportNumber = passport_number;


IF (PassangerNUmberChe is NULL) THEN
	SELECT "The person is not a passenger of the reservation" AS Message;
ELSEIF (in_reservation_Number is NULL) THEN
	SELECT "The given reservation number does not exist" AS Message;
ELSE
	INSERT INTO Contact(PassportNumber, Email, PhNumber) VALUES (passport_number, email, phone);
	UPDATE Reservation SET PassportNumber = passport_number WHERE ReservationNumber = reservation_nr;

END IF;

END
// 
delimiter ;

delimiter //

create procedure addPayment(in reservation_nr int,
				in cardholder_name varchar(30),
				in credit_card_number bigint)
begin

DECLARE RemainingSeats,IsPaymentDone,CheckFreeSeats,nrOfPassengers_Temp, nrOfPassengers_Temp_add,HaveContact , currentPassNUmber, currentResNumber,CurrentFlightNumber integer;
DECLARE is_paid integer;

select PassportNumber into currentPassNUmber
from Reservation
where ReservationNumber = reservation_nr;

select Flightnumber into CurrentFlightNumber
from Reservation
where ReservationNumber = reservation_nr;

select Seat into CheckFreeSeats from Flight where FlightNumber = CurrentFlightNumber;

select ReservationNumber into currentResNumber
from Reservation
where ReservationNumber = reservation_nr;

select count(*) into IsPaymentDone from Reservation where ReservationNumber = reservation_nr AND Payment = 1 limit 1;

set RemainingSeats = calculateFreeSeats(CurrentFlightNumber);

select count(*) into HaveContact from Contact where PassportNumber = currentPassNUmber;

IF (currentResNumber is NULL) THEN
	SELECT "The given reservation number does not exist" AS Message;

ELSEIF (IsPaymentDone > 0) THEN
	SELECT "The booking has already been payed and no further passengers can be added" AS Message;

ELSEIF (RemainingSeats < 1) THEN
	SELECT "There are not enough seats available on the flight anymore, deleting reservation" AS Message;

ELSEIF (HaveContact = 0) THEN
	SELECT "The reservation has no contact yet" AS Message;

Else		
	INSERT into CreditCard(CreditcardNumber,Owner) VALUES(credit_card_number,cardholder_name);

	INSERT into Ticket(TicketNumber,ReservationNumber,CreditcardNumber,AmountPaid,PassportNumber) 
	VALUES(NULL,reservation_nr,credit_card_number,calculatePrice(CurrentFlightNumber),currentPassNUmber);
	
	Select nrOfPassengers into nrOfPassengers_Temp from Reservation where ReservationNumber = reservation_nr;
	set nrOfPassengers_Temp = nrOfPassengers_Temp + 1;

	update Reservation
	set Payment = 1,nrOfPassengers= nrOfPassengers_Temp
	where ReservationNumber = reservation_nr;

	
END IF;

END;
//	 
delimiter ;
