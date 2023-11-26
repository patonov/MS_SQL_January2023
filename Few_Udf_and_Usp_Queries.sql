create or alter procedure usp_AssignProject(@emloyeeId int, @projectID int) 
as
begin
declare @employee int = (select EmployeeID from Employees where EmployeeID = @emloyeeId)
declare @project int = (select ProjectID from Projects where ProjectID = @projectID)
declare @countProjects int = (select count(*) from EmployeesProjects where EmployeeID = @emloyeeId)
if (@countProjects) > 3
	throw 50001, 'The employee has too many projects!', 1
	insert into EmployeesProjects(EmployeeID, ProjectID) values (@emloyeeId, @projectID)
end

go

exec usp_AssignProject 1, 4

go

exec sp_depends 'usp_AssignProject'
drop proc usp_AssignProject
go

CREATE or alter FUNCTION udf_EmployeeListByDepartment(@DepName nvarchar(20))
RETURNS @result TABLE(
    FirstName nvarchar(50) NOT NULL,
    LastName nvarchar(50) NOT NULL,
    DepartmentName nvarchar(20) NOT NULL) 
AS
BEGIN
    INSERT INTO @result SELECT e.FirstName, e.LastName, d.[Name]
        FROM Employees AS e 
        LEFT JOIN Departments AS d ON d.DepartmentID = e.DepartmentID
	WHERE d.Name = @DepName
    RETURN
END
go
select * from dbo.udf_EmployeeListByDepartment('Production')
go

