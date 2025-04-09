USE Airplanes226
GO

-- popularea bazei de date

-- 1. Popularea tabelului 'Airplane'
INSERT INTO Airplane (Model, Type, Manufacturer, YearManufactured) VALUES
('Boeing 737', 'Commercial', 'Boeing', 2015),
('Airbus A320', 'Commercial', 'Airbus', 2017),
('Cessna 172', 'Private', 'Cessna', 2010),
('Boeing 777', 'Commercial', 'Boeing', 2012),
('Airbus A380', 'Commercial', 'Airbus', 2018),
('Boeing 747', 'Commercial', 'Boeing', 2005),
('Airbus A330', 'Commercial', 'Airbus', 2014),
('Embraer E190', 'Commercial', 'Embraer', 2016),
('Bombardier CRJ900', 'Commercial', 'Bombardier', 2018),
('Piper PA-28', 'Private', 'Piper', 2012),
('Cessna Citation X', 'Private', 'Cessna', 2015),
('Boeing 767', 'Commercial', 'Boeing', 2010),
('Airbus A350', 'Commercial', 'Airbus', 2019),
('McDonnell Douglas MD-80', 'Commercial', 'McDonnell Douglas', 1999),
('F-16 Fighting Falcon', 'Military Fighter', 'Lockheed Martin', 2001);

-- 2. Popularea tabelului 'Airline'
INSERT INTO Airline (Name, Country) VALUES
('Delta Airlines', 'USA'),
('Lufthansa', 'Germany'),
('Emirates', 'UAE'),
('Qatar Airways', 'Qatar'),
('Ryanair', 'Ireland'),
('United Airlines', 'USA'),
('British Airways', 'UK'),
('Air France', 'France'),
('Turkish Airlines', 'Turkey'),
('Singapore Airlines', 'Singapore'),
('JetBlue Airways', 'USA'),
('Alaska Airlines', 'USA'),
('KLM', 'Netherlands'),
('Etihad Airways', 'UAE'),
('Cathay Pacific', 'Hong Kong');

-- 3. Popularea tabelului 'Airport'
INSERT INTO Airport (Name, City, Country) VALUES
('JFK International', 'New York', 'USA'),
('Heathrow', 'London', 'UK'),
('Dubai International', 'Dubai', 'UAE'),
('Frankfurt Airport', 'Frankfurt', 'Germany'),
('Charles de Gaulle', 'Paris', 'France'),
('Los Angeles International', 'Los Angeles', 'USA'),
('Toronto Pearson', 'Toronto', 'Canada'),
('Tokyo Haneda', 'Tokyo', 'Japan'),
('Singapore Changi', 'Singapore', 'Singapore'),
('Avram Iancu Cluj International', 'Cluj-Napoca', 'România'),
('Sydney Kingsford Smith', 'Sydney', 'Australia'),
('O’Hare International', 'Chicago', 'USA'),
('Amsterdam Schiphol', 'Amsterdam', 'Netherlands'),
('Zurich Airport', 'Zurich', 'Switzerland'),
('Istanbul Airport', 'Istanbul', 'Turkey');

-- 4. Popularea tabelului 'FlightRoute'
INSERT INTO FlightRoute (DepartureAirportID, ArrivalAirportID, Distance) VALUES
(1, 2, 5567),  -- JFK to Heathrow
(3, 1, 11000), -- Dubai to JFK
(2, 3, 5500),  -- Heathrow to Dubai
(4, 2, 600),   -- Frankfurt to Heathrow
(5, 4, 475),   -- Charles de Gaulle to Frankfurt
(1, 6, 3976),  -- JFK to LAX
(2, 7, 5368),  -- Heathrow to Toronto
(3, 8, 6800),  -- Dubai to Singapore
(6, 9, 3300),  -- LAX to Tokyo
(7, 10, 1900), -- Toronto to Cluj-Napoca
(8, 11, 10000), -- Tokyo to Sydney
(9, 12, 8000), -- Singapore to Chicago
(10, 13, 4000), -- Hong Kong to Amsterdam
(11, 14, 5000), -- Sydney to Zurich
(12, 15, 2000); -- Chicago to Istanbul

-- 5. Popularea tabelului 'Flight'
INSERT INTO Flight (AirlineID, AirplaneID, RouteID, FlightNumber, DepartureTime, ArrivalTime) VALUES
(1, 1, 1, 'DL123', '2024-10-15 08:00', '2024-10-15 16:00'),
(2, 2, 3, 'LH456', '2024-10-16 09:30', '2024-10-16 19:00'),
(3, 4, 2, 'EK789', '2024-10-17 22:00', '2024-10-18 07:00'),
(4, 3, 4, 'QR111', '2024-10-20 12:00', '2024-10-20 13:15'),
(5, 5, 5, 'FR222', '2024-10-22 14:30', '2024-10-22 15:45'),
(1, 6, 6, 'UA333', '2024-10-23 10:00', '2024-10-23 13:00'),
(2, 7, 7, 'BA444', '2024-10-24 15:30', '2024-10-24 21:00'),
(3, 8, 8, 'AF555', '2024-10-25 20:00', '2024-10-26 06:00'),
(4, 9, 9, 'TK666', '2024-10-26 11:00', '2024-10-26 16:30'),
(5, 10, 10, 'SQ777', '2024-10-27 19:30', '2024-10-28 07:30'),
(1, 11, 11, 'JL888', '2024-10-28 08:30', '2024-10-28 15:30'),
(2, 12, 12, 'LX999', '2024-10-29 09:00', '2024-10-29 14:00'),
(3, 13, 13, 'CX101', '2024-10-30 16:00', '2024-10-31 05:00'),
(4, 14, 14, 'NH102', '2024-10-31 17:30', '2024-11-01 03:30'),
(5, 15, 15, 'TG103', '2024-11-01 14:00', '2024-11-01 20:00');

-- 6. Popularea tabelului 'Crew'
INSERT INTO Crew (Name, Position, LicenseNumber) VALUES
('John Smith', 'Pilot', 'LIC12345'),
('Jane Doe', 'Co-pilot', 'LIC54321'),
('Robert Brown', 'Flight Attendant', 'LIC56789'),
('Emily Davis', 'Flight Attendant', 'LIC98765'),
('Michael Johnson', 'Pilot', 'LIC65432'),
('Sarah Wilson', 'Co-pilot', 'LIC23456'),
('David Lee', 'Flight Attendant', 'LIC34567'),
('Jessica White', 'Flight Attendant', 'LIC45678'),
('Daniel Garcia', 'Pilot', 'LIC67890'),
('Laura Martinez', 'Co-pilot', 'LIC78901'),
('James Miller', 'Flight Attendant', 'LIC89012'),
('Linda Taylor', 'Flight Attendant', 'LIC90123'),
('Paul Anderson', 'Pilot', 'LIC01234'),
('Nancy Thomas', 'Co-pilot', 'LIC12346'),
('Chris Jackson', 'Flight Attendant', 'LIC23457');

-- 7. Popularea tabelului 'FlightCrew'
INSERT INTO FlightCrew (FlightID, CrewID) VALUES
(1, 1), -- John Smith is the pilot for DL123
(1, 2), -- Jane Doe is the co-pilot for DL123
(1, 3), -- Robert Brown is the attendant for DL123
(2, 4), -- Emily Davis is the attendant for LH456
(3, 5), -- Michael Johnson is the pilot for EK789
(3, 6), -- Sarah Wilson is the co-pilot for EK789
(4, 7), -- David Lee is the attendant for QR111
(5, 8), -- Jessica White is the attendant for FR222
(6, 9), -- Daniel Garcia is the pilot for UA333
(6, 10), -- Laura Martinez is the co-pilot for UA333
(7, 11), -- James Miller is the attendant for BA444
(8, 12), -- Linda Taylor is the attendant for AF555
(9, 13), -- Paul Anderson is the pilot for TK666
(10, 14), -- Nancy Thomas is the co-pilot for SQ777
(11, 15), -- Chris Jackson is the attendant for JL888
(12, 1), -- John Smith is the pilot for LX999
(13, 2), -- Jane Doe is the co-pilot for CX101
(14, 3), -- Robert Brown is the attendant for NH102
(15, 4); -- Emily Davis is the attendant for TG103

-- 8. Popularea tabelului 'Passenger'
INSERT INTO Passenger (Name, PassportNumber) VALUES
('Alice Johnson', 'P123456789'),
('Bob Williams', 'P987654321'),
('Charlie Thompson', 'P111222333'),
('David Wright', 'P444555666'),
('Emma Turner', 'P777888999'),
('Frank Harris', 'P333222111'),
('Grace Hall', 'P888777666'),
('Henry Allen', 'P444555444'),
('Ivy Baker', 'P123321123'),
('Jack Carter', 'P777777777'),
('Katherine Scott', 'P456789123'),
('Lucas King', 'P987123456'),
('Mia Lopez', 'P222333444'),
('Nathan Young', 'P654321987'),
('Olivia Hill', 'P789456123');

-- 9. Popularea tabelului 'FlightPassenger'
INSERT INTO FlightPassenger (FlightID, PassengerID, SeatNumber) VALUES
(1, 1, '12A'),  -- Alice Johnson on DL123
(1, 2, '12B'),  -- Bob Williams on DL123
(2, 3, '14C'),  -- Charlie Thompson on LH456
(3, 4, '1A'),   -- David Wright on EK789
(3, 5, '1B'),   -- Emma Turner on EK789
(4, 6, '20D'),  -- Frank Harris on QR111
(5, 7, '30A'),  -- Grace Hall on FR222
(6, 8, '18C'),  -- Henry Allen on UA333
(7, 9, '15B'),  -- Ivy Baker on BA444
(8, 10, '5A'),  -- Jack Carter on AF555
(9, 11, '2C'),  -- Katherine Scott on TK666
(10, 12, '1A'), -- Lucas King on SQ777
(11, 13, '8D'), -- Mia Lopez on JL888
(12, 14, '19B'), -- Nathan Young on LX999
(13, 15, '3E'), -- Olivia Hill on CX101
(14, 1, '9A'),  -- Alice Johnson on NH102
(15, 2, '10B');  -- Bob Williams on TG103

-- 10. Popularea tabelului 'Ticket'
INSERT INTO Ticket (PassengerID, FlightID, Price, Class) VALUES
(1, 1, 500.00, 'Economy'),  -- Alice Johnson's ticket
(2, 1, 500.00, 'Economy'),  -- Bob Williams's ticket
(3, 2, 800.00, 'Business'), -- Charlie Thompson's ticket
(4, 3, 1200.00, 'First Class'), -- David Wright's ticket
(5, 3, 1200.00, 'First Class'), -- Emma Turner's ticket
(6, 4, 600.00, 'Economy'), -- Frank Harris's ticket
(7, 5, 300.00, 'Economy'), -- Grace Hall's ticket
(8, 6, 700.00, 'Business'), -- Henry Allen's ticket
(9, 7, 400.00, 'Economy'), -- Ivy Baker's ticket
(10, 8, 900.00, 'Business'), -- Jack Carter's ticket
(11, 9, 1100.00, 'First Class'), -- Katherine Scott's ticket
(12, 10, 750.00, 'Economy'), -- Lucas King's ticket
(13, 11, 950.00, 'Business'), -- Mia Lopez's ticket
(14, 12, 500.00, 'Economy'), -- Nathan Young's ticket
(15, 13, 800.00, 'Business'), -- Olivia Hill's ticket
(1, 14, 600.00, 'Economy'), -- Alice Johnson's ticket
(2, 15, 400.00, 'Economy'); -- Bob Williams's ticket

-- 11. Popularea tabelului 'Luggage'
INSERT INTO Luggage (PassengerID, Weight, LuggageType) VALUES
(1, 22.5, 'Checked'), -- Alice Johnson
(2, 15.0, 'Checked'), -- Bob Williams
(3, 10.0, 'Hand Luggage'), -- Charlie Thompson
(4, 25.0, 'Checked'), -- David Wright
(5, 12.0, 'Hand Luggage'), -- Emma Turner
(6, 18.0, 'Checked'), -- Frank Harris
(7, 8.0, 'Hand Luggage'), -- Grace Hall
(8, 20.0, 'Checked'), -- Henry Allen
(9, 15.0, 'Hand Luggage'), -- Ivy Baker
(10, 24.0, 'Checked'), -- Jack Carter
(11, 17.0, 'Hand Luggage'), -- Katherine Scott
(12, 30.0, 'Checked'), -- Lucas King
(13, 5.0, 'Hand Luggage'), -- Mia Lopez
(14, 21.0, 'Checked'), -- Nathan Young
(15, 14.0, 'Hand Luggage'); -- Olivia Hill

-- 12. Popularea tabelului 'Maintenance'
INSERT INTO Maintenance (AircraftID, MaintenanceDate, Description) VALUES
(1, '2024-09-10', 'Engine inspection and software update'),
(2, '2024-09-15', 'Landing gear replacement'),
(3, '2024-08-20', 'Routine check'),
(4, '2024-10-01', 'Cabin reconfiguration'),
(5, '2024-09-25', 'Fuel system inspection'),
(6, '2024-09-05', 'Routine check and cleaning'),
(7, '2024-08-15', 'Air conditioning repair'),
(8, '2024-09-20', 'Tire replacement'),
(9, '2024-10-05', 'Routine maintenance'),
(10, '2024-10-10', 'Engine overhaul'),
(11, '2024-09-30', 'Software update'),
(12, '2024-08-10', 'Electrical system inspection'),
(13, '2024-09-12', 'Wing inspection'),
(14, '2024-10-03', 'Routine check and painting'),
(15, '2024-09-28', 'Cabin pressure check');
