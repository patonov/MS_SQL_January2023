CREATE DATABASE PeopleDemo

USE PeopleDemo

CREATE TABLE Persons (
    Id INT NOT NULL IDENTITY,
    LastName VARCHAR(255) NOT NULL,
    FirstName VARCHAR(255),
    Age INT,
    Town VARCHAR(255),
    CONSTRAINT CHK_Person CHECK (Age >= 18 AND Town != 'Blagoevgrad')
);

INSERT INTO Persons VALUES
('Patonov', 'Nikolay', 37, 'Petrich'),
--('Penchev', 'Mitko', 17, 'Blagoevgrad'),
('Murdjo', 'Morad', 27, 'Haskovo')

ALTER TABLE Persons
DROP CONSTRAINT CHK_Person

INSERT INTO Persons VALUES
('Patonov', 'Nikolay', 37, 'Petrich'),
('Penchev', 'Mitko', 17, 'Blagoevgrad'),
('Murdjo', 'Morad', 27, 'Haskovo')