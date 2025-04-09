USE Airplanes226
GO

-- interogari ale bazei de date

-- 1. Interogare cu 'WHERE' care include mai mult de 2 tabele
-- Afișează toate zborurile operate de o anumită companie aeriană, împreună cu aeroportul de plecare și sosire.
-- Tabele implicate în interogare: Flight, Airline, FlightRoute, Airport
SELECT Flight.FlightNumber, DepartureAirport.Name AS Departure, ArrivalAirport.Name AS Arrival
FROM Flight 
JOIN Airline ON Flight.AirlineID = Airline.AirlineID 
JOIN FlightRoute ON Flight.RouteID = FlightRoute.RouteID 
JOIN Airport AS DepartureAirport ON FlightRoute.DepartureAirportID = DepartureAirport.AirportID 
JOIN Airport AS ArrivalAirport ON FlightRoute.ArrivalAirportID = ArrivalAirport.AirportID
WHERE Airline.Name = 'Lufthansa';

-- 2. Interogare cu 'WHERE', 'DISTINCT' care include mai mult de 2 tabele
-- Afișează toate destinațiile distincte (aeroporturi de sosire) ale zborurilor operate de o anumită companie aeriană.
-- Tabele implicate în interogare: Flight, FlightRoute, Airport
SELECT DISTINCT ArrivalAirport.Name 
FROM Flight 
JOIN FlightRoute ON Flight.RouteID = FlightRoute.RouteID 
JOIN Airport AS ArrivalAirport ON FlightRoute.ArrivalAirportID = ArrivalAirport.AirportID 
WHERE Flight.AirlineID = (SELECT AirlineID FROM Airline WHERE Name = 'Emirates');

-- 3. Interogare cu 'GROUP BY', 'HAVING' care include mai mult de 2 tabele
-- Afișează aeroporturile care gestionează zboruri cu distanțe totale de peste 10.000 km.
-- Tabele implicate în interogare: Airport, FlightRoute, Flight
SELECT Airport.Name, SUM(FlightRoute.Distance) AS TotalDistance 
FROM Airport 
JOIN FlightRoute ON Airport.AirportID = FlightRoute.DepartureAirportID 
JOIN Flight ON Flight.RouteID = FlightRoute.RouteID
GROUP BY Airport.Name 
HAVING SUM(FlightRoute.Distance) > 10000;

-- 4. Interogare cu 'WHERE' care include tabele ce se află într-o relație m-n
-- Afișează echipajul implicat într-un zbor, împreună cu detaliile zborului și compania aeriană.
-- Tabele implicate în interogare: Flight, FlightCrew, Crew, Airline
SELECT Flight.FlightNumber, Crew.Name, Crew.Position, Airline.Name AS Airline
FROM Flight 
JOIN FlightCrew ON Flight.FlightID = FlightCrew.FlightID 
JOIN Crew ON FlightCrew.CrewID = Crew.CrewID 
JOIN Airline ON Flight.AirlineID = Airline.AirlineID 
WHERE Flight.FlightNumber = 'UA333';

-- 5. Interogare cu 'GROUP BY', 'HAVING' care include mai mult de 2 tabele
-- Afișează companiile aeriene care operează mai mult de 2 de zboruri.
-- Tabele implicate în interogare: Flight, Airline, FlightRoute
SELECT Airline.Name, COUNT(Flight.FlightID) AS TotalFlights 
FROM Flight 
JOIN Airline ON Flight.AirlineID = Airline.AirlineID 
JOIN FlightRoute ON Flight.RouteID = FlightRoute.RouteID
GROUP BY Airline.Name 
HAVING COUNT(Flight.FlightID) > 2;

-- 6. Interogare cu 'WHERE' care include tabele ce se află într-o relație m-n
-- Afișează pasagerii și locurile lor pe un anumit zbor.
-- Tabele implicate în interogare: Passenger, FlightPassenger, Flight
SELECT Passenger.Name, FlightPassenger.SeatNumber 
FROM Passenger 
JOIN FlightPassenger ON Passenger.PassengerID = FlightPassenger.PassengerID 
JOIN Flight ON FlightPassenger.FlightID = Flight.FlightID 
WHERE Flight.FlightNumber = 'CX101';

-- 7. Interogare cu 'WHERE' care include mai mult de 2 tabele
-- Afișează toți pasagerii care au bagaje de peste 20 kg, împreună cu detaliile zborului lor.
-- Tabele implicate în interogare: Passenger, Luggage, Ticket, Flight
SELECT Passenger.Name, Luggage.Weight, Flight.FlightNumber 
FROM Passenger 
JOIN Luggage ON Passenger.PassengerID = Luggage.PassengerID 
JOIN Ticket ON Passenger.PassengerID = Ticket.PassengerID 
JOIN Flight ON Ticket.FlightID = Flight.FlightID 
WHERE Luggage.Weight > 20;

-- 8. Interogare cu 'WHERE'
-- Afișează toate avioanele produse de un anumit producător după anul 2010.
-- Tabelul implicat în interogare: Airplane
SELECT Model, YearManufactured 
FROM Airplane 
WHERE Manufacturer = 'Boeing' AND YearManufactured > 2010;

-- 9. Interogare cu 'GROUP BY'
-- Afișează numărul de pasageri pe fiecare clasă de zbor.
-- Tabelul implicat în interogare: Ticket
SELECT Class, COUNT(TicketID) AS PassengerCount 
FROM Ticket 
GROUP BY Class;

-- 10. Interogare cu 'DISTINCT'
-- Afișează toate tipurile distincte de avioane operate.
-- Tabelul implicat în interogare: Airplane
SELECT DISTINCT Type 
FROM Airplane;
