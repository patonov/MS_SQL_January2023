CREATE NONCLUSTERED INDEX IX_Addresses_AddressID   
ON Addresses(AddressID);   

IF EXISTS (SELECT [name] FROM sys.indexes  
WHERE [name] = N'IX_Addresses_AddressID')
DROP INDEX IX_Addresses_AddressID ON Addresses; 