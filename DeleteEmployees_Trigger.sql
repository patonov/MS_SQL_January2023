create table Deleted_Employees(
    EmployeeId int identity primary key,
    FirstName varchar(50),
    LastName varchar(50),
    MiddleName varchar(50),
    JobTitle varchar(50),
    DepartmentId int,
    Salary money
)
go

create OR alter trigger tr_OnDeletedEmployee
on Employees for delete
as
    insert into Deleted_Employees
    select d.FirstName, d.LastName, d.MiddleName, d.JobTitle, d.DepartmentId, d.Salary
    from deleted as d

go

delete from Employees where EmployeeID = 1

select * from Deleted_Employees