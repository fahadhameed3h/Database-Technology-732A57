drop trigger if exists ticketnumber;

DELIMITER //
CREATE TRIGGER ticketnumber
AFTER Update ON Reservation FOR EACH ROW
BEGIN
	declare ticket_number bigint;

	SET ticket_number = rand();

	update Ticket set TicketNumber = ticket_number
	WHERE ReservationNumber = NEW.ReservationNumber;

END;
//

DELIMITER ;


