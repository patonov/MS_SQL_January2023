USE Airport

ALTER TABLE Aircraft
ALTER COLUMN Model VARCHAR(100)

EXEC sp_rename 'Aircraft.Brand', 'Marka', 'COLUMN'