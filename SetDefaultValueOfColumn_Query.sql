ALTER TABLE Persons 
ADD CONSTRAINT Df_Muncho
DEFAULT 'Muncho' FOR FirstName

INSERT INTO Persons(LastName, Age, Town) VALUES
('Mitev', 12, 'Petrovo')