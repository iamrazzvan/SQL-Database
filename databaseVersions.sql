-- Utilizarea bazei de date
USE Airplanes226;
GO

-- Proceduri pentru modificarea structurii bazei de date

-- 1. Modificarea tipului coloanei Price din Ticket
CREATE OR ALTER PROCEDURE USP_V1
AS
BEGIN
    ALTER TABLE Ticket
    ALTER COLUMN Price FLOAT;
END;
GO

CREATE OR ALTER PROCEDURE USP_UNDO_V1
AS
BEGIN
    ALTER TABLE Ticket
    ALTER COLUMN Price DECIMAL(10, 2);
END;
GO

--------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 2. Adăugarea unei constrângeri de valoare implicită pentru Class în Ticket
CREATE OR ALTER PROCEDURE USP_V2
AS
BEGIN
    ALTER TABLE Ticket
    ADD CONSTRAINT DF_Ticket_Class DEFAULT 'Economy' FOR Class;
END;
GO

CREATE OR ALTER PROCEDURE USP_UNDO_V2
AS
BEGIN
    DECLARE @ConstraintName NVARCHAR(128);

    SELECT @ConstraintName = name
    FROM sys.default_constraints
    WHERE parent_object_id = OBJECT_ID('Ticket') 
      AND col_name(parent_object_id, parent_column_id) = 'Class';

    IF @ConstraintName IS NOT NULL
    BEGIN
        EXEC('ALTER TABLE Ticket DROP CONSTRAINT ' + @ConstraintName);
    END
END;
GO

--------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 3. Crearea și ștergerea tabelei AirplaneMaintenanceHistory
CREATE OR ALTER PROCEDURE USP_V3
AS
BEGIN
    CREATE TABLE AirplaneMaintenanceHistory (
        HistoryID INT PRIMARY KEY IDENTITY,
        AirplaneID INT FOREIGN KEY REFERENCES Airplane(AirplaneID),
        MaintenanceDate DATETIME,
        Description NVARCHAR(200)
    );
END;
GO

CREATE OR ALTER PROCEDURE USP_UNDO_V3
AS
BEGIN
    DROP TABLE AirplaneMaintenanceHistory;
END;
GO

--------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 4. Adăugarea și ștergerea coloanei SeatType în FlightPassenger
CREATE OR ALTER PROCEDURE USP_V4
AS
BEGIN
    ALTER TABLE FlightPassenger
    ADD SeatType VARCHAR(20);
END;
GO

CREATE OR ALTER PROCEDURE USP_UNDO_V4
AS
BEGIN
    ALTER TABLE FlightPassenger
    DROP COLUMN SeatType;
END;
GO

--------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 5. Crearea și ștergerea unei chei străine între Ticket și TicketType
CREATE OR ALTER PROCEDURE USP_V5
AS
BEGIN
    ALTER TABLE Ticket
    ADD TicketTypeID INT;
    ALTER TABLE Ticket
    ADD CONSTRAINT FK_Ticket_TicketType FOREIGN KEY (TicketTypeID) REFERENCES TicketType(TicketTypeID);
END;
GO

CREATE OR ALTER PROCEDURE USP_UNDO_V5
AS
BEGIN
    ALTER TABLE Ticket
    DROP CONSTRAINT FK_Ticket_TicketType;
    ALTER TABLE Ticket
    DROP COLUMN TicketTypeID;
END;
GO

--------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Testarea procedurilor individuale
EXEC USP_V1;
EXEC USP_UNDO_V1;
EXEC USP_V2;
EXEC USP_UNDO_V2;
EXEC USP_V3;
EXEC USP_UNDO_V3;
EXEC USP_V4;
EXEC USP_UNDO_V4;
EXEC USP_V5;
EXEC USP_UNDO_V5;
GO

--------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Crearea tabelului pentru versiuni
CREATE TABLE VERSIUNI (
    NR INT PRIMARY KEY,
    ACTIVE BIT
);
GO

-- Inserăm versiunile în tabelul VERSIUNI
INSERT INTO VERSIUNI (NR, ACTIVE) VALUES
(0, 1),
(1, 0),
(2, 0),
(3, 0),
(4, 0),
(5, 0);
GO

--------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Procedura de actualizare la o anumită versiune
CREATE OR ALTER PROCEDURE USP_UPDATE
@VERSIUNE INT
AS
BEGIN

    -- Verificăm dacă versiunea există
    IF NOT EXISTS (SELECT 1 FROM VERSIUNI WHERE NR = @VERSIUNE)
    BEGIN
        PRINT('Nu exista versiunea ' + CONVERT(VARCHAR(5), @VERSIUNE));
        RETURN 1;
    END

    -- Extragem versiunea curentă
    DECLARE @CURENTA INT;
    SELECT @CURENTA = NR FROM VERSIUNI WHERE ACTIVE = 1;

    IF @CURENTA = @VERSIUNE
    BEGIN
        PRINT('Suntem deja la versiunea ' + CONVERT(VARCHAR(5), @CURENTA));
        RETURN 2;
    END

    DECLARE @sql NVARCHAR(MAX);

    -- Actualizarea propriu-zisă
    WHILE @CURENTA != @VERSIUNE
    BEGIN
        -- Cazul de downgrade (revenire la versiuni anterioare)
        IF @CURENTA > @VERSIUNE
        BEGIN
            SET @sql = 'EXEC USP_UNDO_V' + CONVERT(VARCHAR(5), @CURENTA);
            EXEC sp_executesql @sql;

            UPDATE VERSIUNI SET ACTIVE = 0 WHERE NR = @CURENTA;
            SET @CURENTA = @CURENTA - 1;
        END

        -- Cazul de upgrade
        IF @CURENTA < @VERSIUNE
        BEGIN
            SET @sql = 'EXEC USP_V' + CONVERT(VARCHAR(5), @CURENTA + 1);
            EXEC sp_executesql @sql;

            UPDATE VERSIUNI SET ACTIVE = 0 WHERE NR = @CURENTA;
            SET @CURENTA = @CURENTA + 1;
        END

        -- Actualizăm versiunea curentă
        UPDATE VERSIUNI SET ACTIVE = 1 WHERE NR = @CURENTA;
    END

    PRINT('Actualizarea a fost facuta cu succes');
END;
GO

-- Testarea procedurii de update
EXEC USP_UPDATE @VERSIUNE = 0

-- Verificăm tabela VERSIUNI pentru a vedea versiunea curentă
SELECT * FROM VERSIUNI;
GO
	