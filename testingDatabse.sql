USE Airplanes226
GO

-- Crearea view-urilor -----------------------------------------------------
CREATE OR ALTER VIEW VAirplane AS
SELECT Model, Manufacturer, YearManufactured
FROM Airplane;
GO

CREATE OR ALTER VIEW VPassenger AS
SELECT FP.SeatNumber, F.ArrivalTime, F.DepartureTime
FROM FlightPassenger FP
JOIN Flight F ON F.FlightID = FP.FlightID
GO

CREATE OR ALTER VIEW VFlightPassengerCount AS
SELECT F.FlightNumber, COUNT(*) AS PassengerCount
FROM Flight F
JOIN FlightPassenger FP ON F.FlightID = FP.FlightID
GROUP BY F.FlightNumber;
GO

-- Procedura principală de testare -----------------------------------------
-- Procedura principală pentru testare
CREATE OR ALTER PROCEDURE run_test
@idTest INT
AS
BEGIN
    DECLARE @testRunId INT;

    -- Inițializăm testul
    INSERT INTO TestRuns (Description) VALUES ('TestCurent');
    SELECT @testRunId = TestRunID FROM TestRuns WHERE Description = 'TestCurent';

    PRINT 'The TestRunID is: ' + CAST(@testRunId AS VARCHAR);

    DECLARE @startTime DATETIME;
    DECLARE @endTime DATETIME;

    SET @startTime = GETDATE();

    -- Rulează testele pentru tabele și view-uri
    EXEC Test_Tables @idTest, @testRunId;
    EXEC Test_Views @idTest, @testRunId;

    SET @endTime = GETDATE();

    -- Var pentru actualizare
    DECLARE @testName NVARCHAR(50);
    SELECT @testName = Name FROM Tests WHERE TestID = @idTest; -- Înlocuit TestName cu Name

    UPDATE TestRuns
    SET Description = @testName, StartAt = @startTime, EndAt = @endTime
    WHERE TestRunID = @testRunId;

    PRINT CHAR(10) + '---> TEST COMPLETAT CU SUCCES ÎN ' +
        CONVERT(VARCHAR(10), DATEDIFF(MILLISECOND, @startTime, @endTime)) + ' milisecunde. <---';
END;
GO

-- Procedura pentru testarea tabelelor --------------------------------------
CREATE OR ALTER PROCEDURE Test_Tables
@idTest INT,
@testRunId INT
AS
BEGIN
    DECLARE @RowCount INT;
    SELECT @RowCount = COUNT(*)
    FROM TestTables TT
    JOIN Tables T ON TT.TableID = T.TableID
    WHERE TT.TestID = @idTest;

    DECLARE @NumeTabel NVARCHAR(50);
    DECLARE @idTabel INT;
    DECLARE @NoOfRows INT;

    WHILE @RowCount > 0
    BEGIN
        SELECT @NumeTabel = T.Name, 
			   @idTabel = T.TableID, 
			   @NoOfRows = TT.NoOfRows
        FROM TestTables TT
        JOIN Tables T ON TT.TableID = T.TableID
        WHERE TT.TestID = @idTest
        ORDER BY TT.TableID DESC OFFSET @RowCount - 1 ROWS FETCH NEXT 1 ROWS ONLY;

        DECLARE @sql NVARCHAR(100) = N'EXEC testareTabel' + @NumeTabel + ' ' + CONVERT(VARCHAR(4), @NoOfRows);

        DECLARE @startTime DATETIME = GETDATE();
        EXEC sp_executesql @sql;
        DECLARE @endTime DATETIME = GETDATE();

        INSERT INTO TestRunTables (TestRunID, TableID, StartAt, EndAt)
        VALUES (@testRunId, @idTabel, @startTime, @endTime);

        SET @RowCount -= 1;
    END;
END;
GO

-- Procedura pentru testarea view-urilor ------------------------------------
CREATE OR ALTER PROCEDURE Test_Views
@idTest INT,
@testRunId INT
AS
BEGIN
    DECLARE @RowCount INT;
    SELECT @RowCount = COUNT(*)
    FROM TestViews TV
    JOIN Views V ON TV.ViewID = V.ViewID
    WHERE TV.TestID = @idTest;

    DECLARE @NumeView NVARCHAR(50);
    DECLARE @idView INT;

    WHILE @RowCount > 0
    BEGIN
        SELECT @NumeView = V.Name, 
		       @idView = V.ViewID
        FROM TestViews TV
        JOIN Views V ON TV.ViewID = V.ViewID
        WHERE TV.TestID = @idTest
        ORDER BY TV.ViewID DESC OFFSET @RowCount - 1 ROWS FETCH NEXT 1 ROWS ONLY;

        DECLARE @sql NVARCHAR(100) = N'SELECT * FROM ' + @NumeView;

        DECLARE @startTime DATETIME = GETDATE();
        EXEC sp_executesql @sql;
        DECLARE @endTime DATETIME = GETDATE();

        INSERT INTO TestRunViews (TestRunID, ViewID, StartAt, EndAt)
        VALUES (@testRunId, @idView, @startTime, @endTime);

        SET @RowCount -= 1;
    END;
END;
GO

-- Proceduri specifice pentru tabele ----------------------------------------
CREATE OR ALTER PROCEDURE testareTabelAirplane
@nrRows INT
AS
BEGIN
    DECLARE @i INT = 1;

    DELETE FROM Airplane;

    WHILE @i <= @nrRows
    BEGIN
        INSERT INTO Airplane (Model, Type, Manufacturer, YearManufactured)
        VALUES ('Model' + CAST(@i AS NVARCHAR(10)), 'TypeA', 'ManufacturerA', 2023);
        SET @i = @i + 1;
    END


    PRINT 'S-au inserat si sters ' + CONVERT(VARCHAR(10), @nrRows) + ' randuri in tabelul Airplane';
END;
GO

CREATE OR ALTER PROCEDURE testareTabelPassenger
@nrRows INT
AS
BEGIN
    DECLARE @i INT = 1;

    DELETE FROM Passenger

    WHILE @i <= @nrRows
    BEGIN
        INSERT INTO Passenger (Name, PassportNumber)
        VALUES ('Passenger' + CAST(@i AS NVARCHAR(10)), 'P' + CAST(@i AS NVARCHAR(10)));
        SET @i = @i + 1;
    END

    PRINT 'S-au inserat si sters ' + CONVERT(VARCHAR(10), @nrRows) + ' randuri in tabelul Passenger';
END;
GO

CREATE OR ALTER PROCEDURE testareTabelFlight
@nrRows INT
AS
BEGIN
    DECLARE @i INT = 1;

	DELETE FROM FlightPassenger;
    DELETE FROM Flight;

    WHILE @i <= @nrRows
    BEGIN
        INSERT INTO Flight (FlightNumber, DepartureTime, ArrivalTime)
        VALUES ('FL' + CAST(@i AS NVARCHAR(10)), GETDATE(), DATEADD(HOUR, 2, GETDATE()));
        SET @i = @i + 1;
		DECLARE @idFlight INT = (SELECT TOP 1 FlightID FROM Flight ORDER BY FlightID desc)

		INSERT INTO FlightPassenger
		VALUES (@idFlight,1,1)	
	END

    PRINT 'S-au inserat si sters ' + CONVERT(VARCHAR(10), @nrRows) + ' randuri in tabelul Flight';
END;
GO

EXEC run_test @idTest = 8;
GO

-- Vizualizare rezultate -----------------------------------------------------
SELECT * FROM TestRuns;
SELECT * FROM TestRunTables;
SELECT * FROM TestRunViews;
GO

DELETE FROM TestRunViews;
DELETE FROM TestRunTables;
DELETE FROM TestRuns;
GO
