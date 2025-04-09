USE Airplanes226
GO

-- Airplane: o cheie primara
-- Airline: o cheie primara
-- Airport: o cheie primara
-- FlightCrew: o cheie primara compusa
-- Maintenance: o cheie primara si una straina

CREATE OR ALTER FUNCTION is_valid_id (@id INT)
RETURNS INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Airplane WHERE AirplaneID = @id) 
        RETURN 1
    RETURN 0
END
GO

CREATE OR ALTER FUNCTION is_not_null (@value NVARCHAR(100))
RETURNS INT
AS
BEGIN
    IF @value IS NOT NULL
    BEGIN
        RETURN 1
    END
    RETURN 0
END
GO

CREATE OR ALTER FUNCTION is_not_null_int (@value INT)
RETURNS INT
AS
BEGIN
    IF @value IS NOT NULL
    BEGIN
        RETURN 1
    END
    RETURN 0
END
GO

CREATE OR ALTER FUNCTION is_valid_airplane(@id_airplane INT)
    RETURNS INT
AS
BEGIN
    IF EXISTS (SELECT * FROM Airplane WHERE @id_airplane = Airplane.AirplaneID)
    BEGIN
        RETURN 1
    END
    RETURN 0
END
GO

CREATE OR ALTER FUNCTION is_valid_airline(@airline_id INT)
    RETURNS INT
AS
BEGIN
    IF EXISTS (SELECT * FROM Airline WHERE AirlineID = @airline_id)
    BEGIN
        RETURN 1
    END
    RETURN 0
END
GO

CREATE OR ALTER FUNCTION is_valid_airport(@airport_id INT)
    RETURNS INT
AS
BEGIN
    IF EXISTS (SELECT * FROM Airport WHERE AirportID = @airport_id)
    BEGIN
        RETURN 1
    END
    RETURN 0
END
GO

CREATE OR ALTER FUNCTION is_valid_flight_crew(@flight_id INT, @crew_id INT)
    RETURNS INT
AS
BEGIN
    IF EXISTS (SELECT * FROM Flight WHERE FlightID = @flight_id)
       AND EXISTS (SELECT * FROM Crew WHERE CrewID = @crew_id)
    BEGIN
        RETURN 1
    END
    RETURN 0
END
GO

CREATE OR ALTER FUNCTION is_valid_maintenance(@aircraft_id INT)
    RETURNS INT
AS
BEGIN
    IF EXISTS (SELECT * FROM Airplane WHERE AirplaneID = @aircraft_id)
    BEGIN
        RETURN 1
    END
    RETURN 0
END
GO

-- Proceduri pentru Airplane
CREATE OR ALTER PROCEDURE airplane_inserare_crud
    @model VARCHAR(100),
    @type VARCHAR(100),
    @manufacturer VARCHAR(100),
    @year_manufactured INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Condiții
    IF dbo.is_not_null(@model) = 1 AND dbo.is_not_null(@type) = 1 AND dbo.is_not_null(@manufacturer) = 1 AND dbo.is_not_null_int(@year_manufactured) = 1
    BEGIN
        INSERT INTO Airplane (Model, Type, Manufacturer, YearManufactured)
        VALUES (@model, @type, @manufacturer, @year_manufactured);
    END
    ELSE
    BEGIN
        RAISERROR('Datele nu sunt valide.', 16, 1);
    END
END
GO

SELECT * FROM Airplane

EXEC airplane_inserare_crud 'Boeing 737', 'Jet', 'Boeing', 2019;
GO

CREATE OR ALTER PROCEDURE airplane_update_crud
    @id INT,
    @model VARCHAR(100),
    @type VARCHAR(100),
    @manufacturer VARCHAR(100),
    @year_manufactured INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Condiții
    IF dbo.is_valid_airplane(@id) = 1 AND dbo.is_not_null(@model) = 1 AND dbo.is_not_null(@type) = 1 AND dbo.is_not_null(@manufacturer) = 1 AND dbo.is_not_null_int(@year_manufactured) = 1
    BEGIN
        UPDATE Airplane
        SET Model = @model, 
            Type = @type, 
            Manufacturer = @manufacturer, 
            YearManufactured = @year_manufactured
        WHERE AirplaneID = @id;
    END
    ELSE
    BEGIN
        RAISERROR('Datele nu sunt valide.', 16, 1);
    END
END
GO

EXEC airplane_update_crud 1, 'Airbus A320', 'Jet', 'Airbus', 2016;
GO

CREATE OR ALTER PROCEDURE airplane_select_crud
    @id INT,
    @id_airplane INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Condiții
    IF @id = 1
    BEGIN
        -- Select după ID
        SELECT * FROM Airplane WHERE AirplaneID = @id_airplane;
    END
    ELSE
    BEGIN
        -- Select toate
        SELECT * FROM Airplane;
    END
END
GO

EXEC airplane_select_crud 0, 100;
GO

CREATE OR ALTER PROCEDURE airplane_delete_crud
    @id INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Condiții
    IF dbo.is_valid_airplane(@id) = 1
    BEGIN
        -- Ștergere
        DELETE FROM Airplane WHERE AirplaneID = @id;
    END
    ELSE
    BEGIN
        RAISERROR('Datele nu sunt valide.', 16, 1);
    END
END
GO

EXEC airplane_delete_crud 18;
GO


-- Proceduri pentru Airline
CREATE OR ALTER PROCEDURE airline_inserare_crud
    @name NVARCHAR(100),
    @country NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    -- Condiții
    IF dbo.is_not_null(@name) = 1 AND dbo.is_not_null(@country) = 1
    BEGIN
        -- Inserare
        INSERT INTO Airline (Name, Country)
        VALUES (@name, @country);
    END
    ELSE
    BEGIN
        RAISERROR('Datele nu sunt valide.', 16, 1);
    END
END
GO

EXEC airline_inserare_crud 'sgdif', 'Romania';
GO

CREATE OR ALTER PROCEDURE airline_update_crud
    @id INT,
    @name NVARCHAR(100),
    @country NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    -- Condiții
    IF dbo.is_valid_airline(@id) = 1 AND dbo.is_not_null(@name) = 1 AND dbo.is_not_null(@country) = 1
    BEGIN
        -- Update
        UPDATE Airline
        SET Name = @name, 
            Country = @country
        WHERE AirlineID = @id;
    END
    ELSE
    BEGIN
        RAISERROR('Datele nu sunt valide.', 16, 1);
    END
END
GO

EXEC airline_update_crud 1, 'Delta Airlines', 'USA';
GO

CREATE OR ALTER PROCEDURE airline_select_crud
    @id INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Condiții
    IF @id = 0
    BEGIN
        -- Select toate companiile aeriene
        SELECT * FROM Airline;
    END
    ELSE
    BEGIN
        -- Select după AirlineID
        IF dbo.is_valid_airline(@id) = 1
        BEGIN
            SELECT * FROM Airline WHERE AirlineID = @id;
        END
        ELSE
        BEGIN
            RAISERROR('AirlineID nu este valid.', 16, 1);
        END
    END
END
GO

EXEC airline_select_crud 0;
GO

CREATE OR ALTER PROCEDURE airline_delete_crud
    @id INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Condiții
    IF dbo.is_valid_airline(@id) = 1
    BEGIN
        -- Ștergere
        DELETE FROM Airline
        WHERE AirlineID = @id;
    END
    ELSE
    BEGIN
        RAISERROR('AirlineID nu este valid.', 16, 1);
    END
END
GO

EXEC airline_delete_crud 19;
GO


-- Proceduri pentru Airport
CREATE OR ALTER PROCEDURE airport_inserare_crud
    @name NVARCHAR(100),
    @city NVARCHAR(100),
    @country NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    -- Condiții
    IF dbo.is_not_null(@name) = 1 AND dbo.is_not_null(@city) = 1 AND dbo.is_not_null(@country) = 1
    BEGIN
        -- Inserare
        INSERT INTO Airport (Name, City, Country)
        VALUES (@name, @city, @country);
    END
    ELSE
    BEGIN
        RAISERROR('Datele nu sunt valide.', 16, 1);
    END
END
GO

EXEC airport_inserare_crud 'Baneasa', 'Bucharest', 'Romania';
GO

CREATE OR ALTER PROCEDURE airport_update_crud
    @id INT,
    @name NVARCHAR(100),
    @city NVARCHAR(100),
    @country NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    -- Condiții
    IF dbo.is_valid_airport(@id) = 1 AND dbo.is_not_null(@name) = 1 AND dbo.is_not_null(@city) = 1 AND dbo.is_not_null(@country) = 1
    BEGIN
        -- Update
        UPDATE Airport
        SET Name = @name, 
            City = @city, 
            Country = @country
        WHERE AirportID = @id;
    END
    ELSE
    BEGIN
        RAISERROR('Datele nu sunt valide.', 16, 1);
    END
END
GO

EXEC airport_update_crud 1, 'JFK International', 'New York', 'USA';
GO

CREATE OR ALTER PROCEDURE airport_select_crud
    @id INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Condiții
    IF @id = 0
    BEGIN
        -- Select toate aeroporturile
        SELECT * FROM Airport;
    END
    ELSE
    BEGIN
        -- Select după AirportID
        IF dbo.is_valid_airport(@id) = 1
        BEGIN
            SELECT * FROM Airport WHERE AirportID = @id;
        END
        ELSE
        BEGIN
            RAISERROR('AirportID nu este valid.', 16, 1);
        END
    END
END
GO

EXEC airport_select_crud 0;
GO

CREATE OR ALTER PROCEDURE airport_delete_crud
    @id INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Condiții
    IF dbo.is_valid_airport(@id) = 1
    BEGIN
        -- Ștergere
        DELETE FROM Airport
        WHERE AirportID = @id;
    END
    ELSE
    BEGIN
        RAISERROR('AirportID nu este valid.', 16, 1);
    END
END
GO

EXEC airport_delete_crud 19;
GO


-- Proceduri pentru FlightCrew
CREATE OR ALTER PROCEDURE flight_crew_inserare_crud
    @flight_id INT,
    @crew_id INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Condiții
    IF dbo.is_valid_id(@flight_id) = 1 AND dbo.is_valid_id(@crew_id) = 1
    BEGIN
        -- Inserare
        INSERT INTO FlightCrew (FlightID, CrewID)
        VALUES (@flight_id, @crew_id);
    END
    ELSE
    BEGIN
        RAISERROR('Datele nu sunt valide.', 16, 1);
    END
END
GO

EXEC flight_crew_inserare_crud 6, 8;
GO

CREATE OR ALTER PROCEDURE flight_crew_update_crud
    @flight_id INT,
    @crew_id INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Condiții
    IF dbo.is_valid_id(@flight_id) = 1 AND dbo.is_valid_id(@crew_id) = 1
    BEGIN
        -- Actualizare
        UPDATE FlightCrew
        SET FlightID = @flight_id, CrewID = @crew_id
        WHERE FlightID = @flight_id AND CrewID = @crew_id;
    END
    ELSE
    BEGIN
        RAISERROR('Datele nu sunt valide.', 16, 1);
    END
END
GO

EXEC flight_crew_update_crud 1, 2;
GO

CREATE OR ALTER PROCEDURE flight_crew_select_crud
    @flight_id INT,
    @crew_id INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Condiții
    IF @flight_id = 0 AND @crew_id = 0
    BEGIN
        -- Select toate înregistrările FlightCrew
        SELECT * FROM FlightCrew;
    END
    ELSE IF @flight_id != 0 AND @crew_id = 0
    BEGIN
        -- Select toate înregistrările pentru un anumit FlightID
        SELECT * FROM FlightCrew WHERE FlightID = @flight_id;
    END
    ELSE IF @flight_id = 0 AND @crew_id != 0
    BEGIN
        -- Select toate înregistrările pentru un anumit CrewID
        SELECT * FROM FlightCrew WHERE CrewID = @crew_id;
    END
    ELSE
    BEGIN
        -- Select un singur FlightCrew după FlightID și CrewID
        SELECT * FROM FlightCrew WHERE FlightID = @flight_id AND CrewID = @crew_id;
    END
END
GO

EXEC flight_crew_select_crud 0, 0;
GO

CREATE OR ALTER PROCEDURE flight_crew_delete_crud
    @flight_id INT,
    @crew_id INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Condiții
    IF dbo.is_valid_id(@flight_id) = 1 AND dbo.is_valid_id(@crew_id) = 1
    BEGIN
        -- Ștergere
        DELETE FROM FlightCrew
        WHERE FlightID = @flight_id AND CrewID = @crew_id;
    END
    ELSE
    BEGIN
        RAISERROR('Datele nu sunt valide.', 16, 1);
    END
END
GO

EXEC flight_crew_delete_crud 6, 8;
GO


-- Proceduri pentru Maintenance
CREATE OR ALTER PROCEDURE maintenance_inserare_crud
    @aircraft_id INT,
    @maintenance_date DATETIME,
    @description NVARCHAR(200)
AS
BEGIN
    SET NOCOUNT ON;

    -- Condiții
    IF dbo.is_valid_id(@aircraft_id) = 1 AND dbo.is_not_null(@description) = 1
    BEGIN
        -- Inserare
        INSERT INTO Maintenance (AircraftID, MaintenanceDate, Description)
        VALUES (@aircraft_id, @maintenance_date, @description);
    END
    ELSE
    BEGIN
        RAISERROR('Datele nu sunt valide.', 16, 1);
    END
END
GO

EXEC maintenance_inserare_crud 1, '2024-12-12', 'Revizie tehnică completă';
GO

CREATE OR ALTER PROCEDURE maintenance_update_crud
    @id INT,
    @aircraft_id INT,
    @maintenance_date DATETIME,
    @description NVARCHAR(200)
AS
BEGIN
    SET NOCOUNT ON;

    -- Condiții
    IF dbo.is_valid_id(@id) = 1 AND dbo.is_valid_id(@aircraft_id) = 1 AND dbo.is_not_null(@description) = 1
    BEGIN
        -- Update
        UPDATE Maintenance
        SET AircraftID = @aircraft_id,
            MaintenanceDate = @maintenance_date,
            Description = @description
        WHERE MaintenanceID = @id;
    END
    ELSE
    BEGIN
        RAISERROR('Datele nu sunt valide.', 16, 1);
    END
END
GO

EXEC maintenance_update_crud 1, 2, '2024-12-15', 'Înlocuire motor';
GO

CREATE OR ALTER PROCEDURE maintenance_select_crud
    @id INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Condiții
    IF @id = 1
    BEGIN
        -- Select după ID
        SELECT * FROM Maintenance WHERE MaintenanceID = @id;
    END
    ELSE
    BEGIN
        -- Select toate înregistrările
        SELECT * FROM Maintenance;
    END
END
GO

EXEC maintenance_select_crud 0;
GO

CREATE OR ALTER PROCEDURE maintenance_delete_crud
    @id INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Condiții
    IF dbo.is_valid_id(@id) = 1
    BEGIN
        -- Delete
        DELETE FROM Maintenance
        WHERE MaintenanceID = @id;
    END
    ELSE
    BEGIN
        RAISERROR('Datele nu sunt valide.', 16, 1);
    END
END
GO

EXEC maintenance_delete_crud 1;
GO


CREATE OR ALTER VIEW vw_airport
AS
    SELECT Name, City, Country FROM Airport
    WHERE Country = 'Germany'
GO

SELECT * FROM vw_airport ORDER BY Name;
GO

CREATE NONCLUSTERED INDEX index_airport_country_city
ON Airport (Name, City, Country);
GO

CREATE OR ALTER VIEW vw_airline
AS
    SELECT AL.Name AS AirlineName, AL.Country AS Country
    FROM Airline AL
    WHERE AL.Country = 'USA'
GO

SELECT * FROM vw_airline ORDER BY AirlineName;
GO

CREATE NONCLUSTERED INDEX index_airline_country
ON Airline (Name, Country);
GO