-- crearea bazei de date despre Avioane
CREATE DATABASE Airplanes226
GO

-- utilizarea bazei de date ce tocmai a fost creată
USE Airplanes226
GO

-- crearea tabelelor
CREATE TABLE Airplane (
    AirplaneID INT PRIMARY KEY IDENTITY,
    Model VARCHAR(100),
    Type VARCHAR(100),
    Manufacturer VARCHAR(100),
    YearManufactured INT
);

CREATE TABLE Airline (
    AirlineID INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(100),
    Country NVARCHAR(100)
);

CREATE TABLE Airport (
    AirportID INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(100),
    City NVARCHAR(100),
    Country NVARCHAR(100)
);

CREATE TABLE FlightRoute (
    RouteID INT PRIMARY KEY IDENTITY,
    DepartureAirportID INT FOREIGN KEY REFERENCES Airport(AirportID),
    ArrivalAirportID INT FOREIGN KEY REFERENCES Airport(AirportID),
    Distance INT
);

CREATE TABLE Flight (
    FlightID INT PRIMARY KEY IDENTITY,
    AirlineID INT FOREIGN KEY REFERENCES Airline(AirlineID),
    AirplaneID INT FOREIGN KEY REFERENCES Airplane(AirplaneID),
    RouteID INT FOREIGN KEY REFERENCES FlightRoute(RouteID), -- adăugare câmp RouteID
    FlightNumber VARCHAR(20),
    DepartureTime DATETIME,
    ArrivalTime DATETIME
);

CREATE TABLE Crew (
    CrewID INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(100),
    Position NVARCHAR(50),
    LicenseNumber VARCHAR(50)
);

CREATE TABLE FlightCrew (
    FlightID INT FOREIGN KEY REFERENCES Flight(FlightID),
    CrewID INT FOREIGN KEY REFERENCES Crew(CrewID),
    PRIMARY KEY (FlightID, CrewID)
);

CREATE TABLE Passenger (
    PassengerID INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(100),
    PassportNumber VARCHAR(50)
);

CREATE TABLE FlightPassenger (
    FlightID INT FOREIGN KEY REFERENCES Flight(FlightID),
    PassengerID INT FOREIGN KEY REFERENCES Passenger(PassengerID),
    SeatNumber VARCHAR(10),
    PRIMARY KEY (FlightID, PassengerID)
);

CREATE TABLE Ticket (
    TicketID INT PRIMARY KEY IDENTITY,
    PassengerID INT FOREIGN KEY REFERENCES Passenger(PassengerID),
    FlightID INT FOREIGN KEY REFERENCES Flight(FlightID),
    Price DECIMAL(10, 2),
    Class VARCHAR(20)
);

CREATE TABLE Luggage (
    LuggageID INT PRIMARY KEY IDENTITY,
    PassengerID INT FOREIGN KEY REFERENCES Passenger(PassengerID),
    Weight DECIMAL(5, 2),
    LuggageType VARCHAR(50)
);

CREATE TABLE Maintenance (
    MaintenanceID INT PRIMARY KEY IDENTITY,
    AircraftID INT FOREIGN KEY REFERENCES Airplane(AirplaneID),
    MaintenanceDate DATETIME,
    Description NVARCHAR(200)
);
