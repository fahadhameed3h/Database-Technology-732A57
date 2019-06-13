DROP VIEW IF EXISTS allFlights;

CREATE VIEW allFlights 
as SELECT 
	startDes.AirportName AS "departure_city_name", 
	endDes.AirportName AS "destination_city_name", 
	WS.DepartureTime AS "departure_time", 
	WS.Day AS "departure_day", 
	F.Week AS "departure_week", 
	WS.Year AS "departure_year", 
	F.Seat AS "nr_of_free_seats", 
	calculatePrice(F.FlightNumber) AS "current_price_per_seat" 
FROM Route as Rte
JOIN Destination as startDes ON startDes.Code = Rte.DestinationFrom 
JOIN Destination as endDes ON  endDes.Code = Rte.DestinationTO 
JOIN WeeklySchedule as WS ON Rte.RouteID = WS.WS_RouteID 
JOIN Flight F ON F.F_WeeklyScheduleID = WS.WeeklyScheduleID;


