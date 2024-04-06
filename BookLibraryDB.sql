create database BookLibrary

use BookLibrary

create table Book(
	Id int identity primary key,
	Title nvarchar(50) not null,
	[Description] nvarchar(250) not null,
	Author nvarchar(50) not null
)