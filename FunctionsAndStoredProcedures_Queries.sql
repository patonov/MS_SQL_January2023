CREATE PROCEDURE usp_GetEmployeesSalaryAbove35000
AS
BEGIN
	SELECT e.FirstName, e.LastName FROM Employees AS e WHERE e.Salary > 35000
END

EXEC usp_GetEmployeesSalaryAbove35000

GO

CREATE OR ALTER PROCEDURE usp_GetEmployeesSalaryAboveNumber @Salary DECIMAL(18,4)
AS
BEGIN
	SELECT e.FirstName, e.LastName FROM Employees AS e WHERE e.Salary >= @Salary
END

EXEC usp_GetEmployeesSalaryAboveNumber 20000.00

GO

CREATE OR ALTER PROCEDURE usp_GetTownsStartingWith @LetterToStart VARCHAR(20)
AS
BEGIN
	DECLARE @Length INT
	SET @Length = LEN(@LetterToStart)

	SELECT t.[Name] FROM Towns AS t WHERE LEFT(t.[Name], @Length) IN (@LetterToStart)
END

GO

EXEC usp_GetTownsStartingWith ber

GO 

CREATE PROCEDURE usp_GetEmployeesFromTown @TownName VARCHAR(30)
AS
BEGIN
	SELECT e.FirstName, e.LastName FROM Employees AS e
	JOIN Addresses AS a ON e.AddressID = a.AddressID
	JOIN Towns AS t ON a.TownID = t.TownID
	WHERE t.[Name] = @TownName
END

EXEC usp_GetEmployeesFromTown Berlin

GO

CREATE FUNCTION ufn_GetSalaryLevel(@salary DECIMAL(18,4))
RETURNS VARCHAR(20)
AS
BEGIN
	DECLARE @Result VARCHAR(20)
	
		IF @Salary < 30000 
		BEGIN
		SET @Result = 'Low'
		END
		ELSE IF @Salary BETWEEN 30000 and 50000
		BEGIN
		SET @Result = 'Average'
		END
		ELSE IF @Salary > 50000 
		BEGIN
		SET @Result = 'High'
		END
	
	RETURN @Result
END

GO

SELECT *, dbo.ufn_GetSalaryLevel(e.Salary) AS SalaryLevel FROM Employees AS e

GO

CREATE PROCEDURE usp_EmployeesBySalaryLevel @Level VARCHAR(10)
AS
BEGIN
	SELECT e.FirstName, e.LastName FROM Employees AS e WHERE dbo.ufn_GetSalaryLevel(e.Salary) = @Level
END

EXEC usp_EmployeesBySalaryLevel 'Low'

GO

CREATE FUNCTION ufn_IsWordComprised(@setOfLetters VARCHAR(MAX), @word VARCHAR(MAX))
RETURNS BIT
AS
BEGIN
	DECLARE @let int = 1;
    DECLARE @exist bit = 1;
    
	WHILE LEN(@word) >= @let AND @exist > 0
    BEGIN
      DECLARE @charindex INT; 
      DECLARE @letter CHAR(1);
      SET @letter = SUBSTRING(@word, @let, 1)
      SET @charindex = CHARINDEX(@letter, @setOfLetters, 0)
      SET @exist =
        CASE
            WHEN  @charindex > 0 THEN 1
            ELSE 0
        END
      SET @let += 1;
    END

    RETURN @exist
END

GO

SELECT *, dbo.ufn_IsWordComprised('berlin', t.[Name]) FROM Towns AS t

GO

ALTER TABLE Departments ALTER COLUMN ManagerId INT NULL 

GO

CREATE OR ALTER PROCEDURE usp_DeleteEmployeesFromDepartment (@departmentId INT)
AS
BEGIN
	DECLARE @EmpIDsToBeDeleted TABLE(
	Id INT
	)

	INSERT INTO @EmpIDsToBeDeleted
	SELECT e.EmployeeID
	FROM Employees AS e
	WHERE e.DepartmentID = @departmentId

	ALTER TABLE Departments
	ALTER COLUMN ManagerID int NULL

	DELETE FROM EmployeesProjects
	WHERE EmployeeID IN (SELECT Id FROM @EmpIDsToBeDeleted)

	UPDATE Employees
	SET ManagerID = NULL
	WHERE ManagerID IN (SELECT Id FROM @EmpIDsToBeDeleted)

	UPDATE Departments
	SET ManagerID = NULL
	WHERE ManagerID IN (SELECT Id FROM @EmpIDsToBeDeleted)

	DELETE FROM Employees
	WHERE EmployeeID IN (SELECT Id FROM @EmpIDsToBeDeleted)

	DELETE FROM Departments
	WHERE DepartmentID = @departmentId 

	SELECT COUNT(*) AS [Employees Count] FROM Employees AS e
	JOIN Departments AS d
	ON d.DepartmentID = e.DepartmentID
	WHERE e.DepartmentID = @departmentId
END

GO

EXEC usp_DeleteEmployeesFromDepartment 2

GO

