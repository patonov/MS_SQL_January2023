--1.Database design

--drop database Pirates
go
--create database Pirates

use Pirates

create table Ships(
	Id int identity primary key,
	[Name] varchar(21) not null,
	Capacity int not null default 10 check (Capacity >= 10),
	Constructed date not null,
	Price decimal(18,2) not null
)

create table Berths(
	Number char(4) primary key,
	Category char(1) not null default 'B' check (Category in ('A', 'B')),
	ShipId int,
	CONSTRAINT FK_Berths_Ships FOREIGN KEY(ShipId) REFERENCES Ships(Id)
)

create table Plunders(
	Id int identity primary key,
	[Location] varchar(99) not null,
	Spoils varchar(10) not null check (Spoils in ('Gold', 'Silver', 'Diamonds')),
	[Value] decimal(18,2) not null,
	IsDone bit not null
)

create table Pirates(
	Id int identity primary key,
	Names varchar(40) not null,
	Pseudonym varchar(16),
	Birth date not null,
	ShipId int,
	BerthNumber char(4) unique,
	IsCaptain bit not null,
	NetWealth money not null,
	CONSTRAINT FK_Pirates_Ships FOREIGN KEY (ShipId) REFERENCES Ships(Id),
	CONSTRAINT FK_Pirates_Berths FOREIGN KEY (BerthNumber) REFERENCES Berths(Number)
)

create table PiratesPlunders(
	PirateId INT NOT NULL FOREIGN KEY REFERENCES Pirates(Id),
	PlunderId INT NOT NULL FOREIGN KEY REFERENCES Plunders(Id),
	CONSTRAINT PK_PiratesPlunders PRIMARY KEY(PirateId, PlunderId)
)

go

insert into Ships([Name], Capacity, Constructed, Price) values
('White head', 18, '01-01-1980', 2000111.34),
('Long sculls', 22, '01-01-1990', 3000411.54),
('Great destroyer', 20, '01-01-2000', 3900555.04),
('Skull and bones', 22, '01-01-1991', 3800111.34),
('White skull', 24, '01-01-2001', 5111000.91),
('Green sculls', 20, '01-01-1980', 2500222.24),
('Skull destroyer', 20, '01-01-1978', 1898121.49),
('Iron skull', 24, '01-01-1995', 3400022.56),
('Maritime bones', 20, '01-01-2005', 3100325.46),
('Iron bones', 22, '01-01-1992', 4320123.49)

insert into Berths(Number, Category, ShipId) values
('WH01', 'B', 1),
('WH02', 'B', 1),
('WH03', 'B', 1),
('WH04', 'B', 1),
('WH05', 'B', 1),
('WH06', 'B', 1),
('WH07', 'B', 1),
('WH08', 'B', 1),
('WH09', 'A', 1),
('WH10', 'A', 1),
('WH11', 'A', 1),
('WH12', 'B', 1),
('WH13', 'B', 1),
('WH14', 'B', 1),
('WH15', 'B', 1),
('WH16', 'B', 1),
('WH17', 'B', 1),
('WH18', 'B', 1),
('LS01', 'B', 2),
('LS02', 'B', 2),
('LS03', 'B', 2),
('LS04', 'B', 2),
('LS05', 'B', 2),
('LS06', 'B', 2),
('LS07', 'B', 2),
('LS08', 'A', 2),
('LS09', 'B', 2),
('LS10', 'B', 2),
('LS11', 'B', 2),
('LS12', 'B', 2),
('LS13', 'A', 2),
('LS14', 'A', 2),
('LS15', 'A', 2),
('LS16', 'B', 2),
('LS17', 'B', 2),
('LS18', 'B', 2),
('LS19', 'B', 2),
('LS20', 'B', 2),
('LS21', 'B', 2),
('LS22', 'B', 2),
('GD01', 'B', 3),
('GD02', 'B', 3),
('GD03', 'B', 3),
('GD04', 'B', 3),
('GD05', 'B', 3),
('GD06', 'B', 3),
('GD07', 'B', 3),
('GD08', 'A', 3),
('GD09', 'B', 3),
('GD10', 'A', 3),
('GD11', 'B', 3),
('GD12', 'B', 3),
('GD13', 'B', 3),
('GD14', 'B', 3),
('GD15', 'B', 3),
('GD16', 'B', 3),
('GD17', 'B', 3),
('GD18', 'A', 3),
('GD19', 'B', 3),
('GD20', 'A', 3),
('SB01', 'B', 4),
('SB02', 'B', 4),
('SB03', 'B', 4),
('SB04', 'B', 4),
('SB05', 'A', 4),
('SB06', 'A', 4),
('SB07', 'B', 4),
('SB08', 'B', 4),
('SB09', 'B', 4),
('SB10', 'B', 4),
('SB11', 'B', 4),
('SB12', 'B', 4),
('SB13', 'B', 4),
('SB14', 'B', 4),
('SB15', 'A', 4),
('SB16', 'A', 4),
('SB17', 'B', 4),
('SB18', 'B', 4),
('SB19', 'B', 4),
('SB20', 'B', 4),
('SB21', 'B', 4),
('SB22', 'B', 4),
('WS01', 'B', 5),
('WS02', 'B', 5),
('WS03', 'B', 5),
('WS04', 'A', 5),
('WS05', 'B', 5),
('WS06', 'B', 5),
('WS07', 'B', 5),
('WS08', 'B', 5),
('WS09', 'A', 5),
('WS10', 'A', 5),
('WS11', 'B', 5),
('WS12', 'B', 5),
('WS13', 'B', 5),
('WS14', 'A', 5),
('WS15', 'B', 5),
('WS16', 'B', 5),
('WS17', 'B', 5),
('WS18', 'B', 5),
('WS19', 'A', 5),
('WS20', 'A', 5),
('WS21', 'A', 5),
('WS22', 'B', 5),
('WS23', 'A', 5),
('WS24', 'B', 5),
('GS01', 'B', 6),
('GS02', 'B', 6),
('GS03', 'B', 6),
('GS04', 'B', 6),
('GS05', 'B', 6),
('GS06', 'B', 6),
('GS07', 'B', 6),
('GS08', 'A', 6),
('GS09', 'B', 6),
('GS10', 'B', 6),
('GS11', 'B', 6),
('GS12', 'B', 6),
('GS13', 'B', 6),
('GS14', 'B', 6),
('GS15', 'B', 6),
('GS16', 'B', 6),
('GS17', 'B', 6),
('GS18', 'A', 6),
('GS19', 'B', 6),
('GS20', 'B', 6),
('SD01', 'B', 7),
('SD02', 'B', 7),
('SD03', 'B', 7),
('SD04', 'B', 7),
('SD05', 'B', 7),
('SD06', 'B', 7),
('SD07', 'B', 7),
('SD08', 'A', 7),
('SD09', 'B', 7),
('SD10', 'B', 7),
('SD11', 'B', 7),
('SD12', 'B', 7),
('SD13', 'B', 7),
('SD14', 'B', 7),
('SD15', 'B', 7),
('SD16', 'B', 7),
('SD17', 'B', 7),
('SD18', 'A', 7),
('SD19', 'B', 7),
('SD20', 'B', 7),
('IS01', 'B', 8),
('IS02', 'B', 8),
('IS03', 'B', 8),
('IS04', 'B', 8),
('IS05', 'B', 8),
('IS06', 'B', 8),
('IS07', 'B', 8),
('IS08', 'A', 8),
('IS09', 'B', 8),
('IS10', 'B', 8),
('IS11', 'B', 8),
('IS12', 'B', 8),
('IS13', 'B', 8),
('IS14', 'B', 8),
('IS15', 'B', 8),
('IS16', 'B', 8),
('IS17', 'B', 8),
('IS18', 'A', 8),
('IS19', 'B', 8),
('IS20', 'B', 8),
('IS21', 'B', 8),
('IS22', 'B', 8),
('IS23', 'B', 8),
('IS24', 'B', 8),
('MB01', 'B', 9),
('MB02', 'B', 9),
('MB03', 'B', 9),
('MB04', 'A', 9),
('MB05', 'B', 9),
('MB06', 'A', 9),
('MB07', 'B', 9),
('MB08', 'B', 9),
('MB09', 'A', 9),
('MB10', 'B', 9),
('MB11', 'B', 9),
('MB12', 'B', 9),
('MB13', 'B', 9),
('MB14', 'A', 9),
('MB15', 'B', 9),
('MB16', 'A', 9),
('MB17', 'B', 9),
('MB18', 'B', 9),
('MB19', 'A', 9),
('MB20', 'B', 9),
('IB01', 'B', 10),
('IB02', 'B', 10),
('IB03', 'A', 10),
('IB04', 'B', 10),
('IB05', 'B', 10),
('IB06', 'B', 10),
('IB07', 'B', 10),
('IB08', 'B', 10),
('IB09', 'B', 10),
('IB10', 'B', 10),
('IB11', 'B', 10),
('IB12', 'B', 10),
('IB13', 'B', 10),
('IB14', 'B', 10),
('IB15', 'B', 10),
('IB16', 'B', 10),
('IB17', 'B', 10),
('IB18', 'B', 10),
('IB19', 'B', 10),
('IB20', 'B', 10),
('IB21', 'B', 10),
('IB22', 'B', 10)

insert into Plunders([Location], Spoils, [Value], IsDone) values
('Iceland', 'Silver', 234999.99, 1),
('Madagascar', 'Gold', 432444.44, 1),
('Great Reef', 'Diamonds', 1000000.01, 0),
('Morocco', 'Gold', 502345.09, 1),
('Sicily', 'Gold', 1010010.55, 0),
('Zimbabwe', 'Diamonds', 2000121.88, 1)

insert into Pirates(Names, Pseudonym, Birth, ShipId, BerthNumber, IsCaptain, NetWealth) values
('Peter Johanan', 'One-eye', '12-12-1971', 1, 'WH09', 1, 1222333.44),
('Yung Gyong', 'The Great', '01-08-1979', 1, 'WH10', 0, 470190.01),
('Robert Barro', 'The Young', '04-07-1972', 1, 'WH01', 0, 100000.01),
('Andres Inotai', 'Calculator', '08-11-1980', 1, 'WH02', 0, 133555.02),
('Ivan Calvine', 'The cool', '10-17-1976', 1, 'WH04', 0, 93556.07),
('Mihai Gyorgy', 'Hungar', '02-02-1973', 2, 'LS13', 1, 3445533.55),
('Gabor Atila', 'Nador', '02-03-1982', 2, 'LS11', 0, 100197.01),
('Arany Yanos', 'The Bloody', '03-03-1978', 2, 'LS09', 0, 200200.02),
('Josef Atila', 'The Man', '09-13-1977', 2, 'LS14', 0, 55500.29),
('Isztvan Seczany', 'The Pecs', '05-19-1978', 2, 'LS19', 0, 366556.77),
('Dimitar Yanev', 'Tapaka', '01-01-1982', 3, 'GD04', 1, 15533.55),
('Pesho Mihov', 'Bichkiyata', '02-11-1983', 3, 'GD06', 0, 30187.01),
('Simo Gerov', 'Tikvata', '03-04-1983', 3, 'GD18', 0, 20440.05),
('Misho Vankov', 'Buhala', '11-26-1977', 3, 'GD16', 0, 35300.29),
('Valeri Petkov', 'Jenskoto', '06-29-1983', 3, 'GD07', 0, 61556.97),
('Saki Pantelias', 'Malaka', '03-01-1975', 4, 'SB05', 1, 1225533.25),
('Iani Karamanis', 'The Monkey', '05-02-1981', 4, 'SB06', 0, 1130117.01),
('Pano Konyaris', 'Wooden head', '09-05-1984', 4, 'SB11', 0, 920420.05),
('Kotsaki Mihailidis', 'The Crete', '09-16-1979', 4, 'SB15', 0, 439301.29),
('Olimpo Galaxias', 'Mangola', '07-16-1982', 4, 'SB19', 0, 761556.97),
('Helmut Hahns', 'Der Doof', '10-02-1978', 5, 'WS18', 1, 2915533.15),
('Wilhelm Wundt', 'Der Wunder', '08-22-1982', 5, 'WS10', 0, 993081.06),
('Jakob Munster', 'Der Affe', '02-13-1981', 5, 'WS02', 0, 720440.07),
('Hahns Zimmerman', 'Frankfurter', '03-08-1979', 5, 'WS06', 0, 835300.29),
('Franz Kirchgaesner', 'Der Schweiz', '06-15-1983', 5, 'WS09', 0, 661556.97),
('Mustafa Yozal', 'Karaca', '11-01-1976', 6, 'GS08', 1, 515133.19),
('Yusuf Farukcan', 'Kiyurd', '04-03-1983', 6, 'GS01', 0, 113082.16),
('Mehmed Yashar', 'Izmirli', '11-23-1982', 6, 'GS02', 0, 200470.87),
('Hasan Gyonus', 'Muftiye', '07-17-1979', 6, 'GS10', 0, 353011.11),
('Faruk Bekir', 'Karagyuzel', '05-06-1985', 6, 'GS17', 0, 201556.50),
('Fadal Ali', 'Bakara', '09-12-1973', 7, 'SD10', 1, 915139.99),
('Imran Al Bani', 'Al Omani', '12-09-1979', 7, 'SD02', 0, 611084.46),
('Usama Al Hadar', 'Bauab', '07-05-1981', 7, 'SD04', 0, 330470.27),
('Rahman Kadir', 'Al Kalb', '08-01-1982', 7, 'SD06', 0, 353011.11),
('Salih Al Hamadi', 'Sohayba', '08-16-1983', 7, 'SD14', 0, 133556.51),
('Bai Liu', 'Zhang', '12-01-1979', 8, 'IS08', 1, 15139.15),
('Zhan Laoshi', 'Shezi', '09-09-1976', 8, 'IS01', 0, 11094.61),
('Lao She', 'Zhuzi', '04-21-1981', 8, 'IS02', 0, 13040.33),
('He Jiu', 'Pijiojia', '01-23-1982', 8, 'IS14', 0, 9012.74),
('Tuzi Genyan', 'Wuweizi', '12-16-1983', 8, 'IS16', 0, 10051.62),
('Yovan Petreski', 'Maketo', '12-26-1990', 9, 'MB06', 1, 22539.00),
('Igor Dzhambazov', 'Maimuno', '10-19-1988', 9, 'MB02', 0, 19994.42),
('Mitre Miloshoski', 'Nozharo', '03-11-1991', 9, 'MB04', 0, 18041.99),
('Vlatko Ristevski', 'Komitata', '01-16-1989', 9, 'MB10', 0, 29092.79),
('Traiche Vladovski', 'Bugarino', '12-26-1986', 9, 'MB11', 0, 49252.20),
('Goran Miletich', 'Tikvesh', '03-11-1988', 10, 'IB03', 1, 45550.10),
('Novak Jakovich', 'Jugo', '07-14-1978', 10, 'IB06', 0, 39390.20),
('Miodrag Perishich', 'Kolar', '08-18-1991', 10, 'IB07', 0, 27045.90),
('Mile Karadashich', 'Hrvat', '12-22-1976', 10, 'IB13', 0, 29092.79),
('Tako Mladich', 'Mladjo', '02-26-1992', 9, 'MB18', 0, 42253.23)

insert into PiratesPlunders(PirateId, PlunderId) values
(1, 1),
(1, 2),
(1, 4),
(1, 5),
(2, 1),
(2, 2),
(2, 4),
(2, 5),
(3, 2),
(3, 4),
(4, 1),
(4, 2),
(4, 5),
(5, 1),
(5, 2),
(6, 4),
(6, 5),
(7, 4),
(7, 5),
(8, 1),
(8, 2),
(9, 5),
(10, 1),
(10, 2),
(10, 4),
(11, 4),
(11, 5),
(13, 1),
(15, 2),
(15, 4),
(17, 2),
(19, 5),
(22, 1),
(22, 2),
(22, 5),
(26, 4),
(26, 5),
(29, 2),
(29, 4),
(31, 5),
(32, 1),
(32, 2),
(37, 4),
(37, 5),
(40, 1),
(41, 2),
(42, 2),
(42, 4),
(42, 5),
(43, 2),
(43, 4),
(44, 5),
(47, 1),
(47, 2),
(48, 4),
(49, 5),
(50, 1),
(50, 2),
(50, 5)

--2. Insert

insert into Ships([Name], Capacity, Constructed, Price) values
('New Skull Hope', 20, '01-01-2000', 10000000.00),
('Bones with Arthritis', 24, '01-01-2004', 5000000.00)

insert into Berths(Number, Category, ShipId) values
('NS01', 'B', 11),
('NS02', 'B', 11),
('BA01', 'B', 12),
('BA02', 'B', 12)

insert into Plunders([Location], Spoils, [Value], IsDone) values
('Adatepe', 'Gold', 7500000.01, 0),
('Chelopech', 'Gold', 14000000.01, 0)

insert into Pirates(Names, Pseudonym, Birth, ShipId, BerthNumber, IsCaptain, NetWealth) values
('Gosho Piratov', null, '01-01-1980', 11, 'NS01', 0, 100000.00),
('Sando Mobidikov', null, '02-02-1979', 11, 'NS02', 0, 100000.00),
('Ahoy Kapitanov', null, '03-03-1971', 12, 'BA01', 0, 75000.00),
('Moro Moryakov', null, '04-04-1981', 12, 'BA02', 0, 75000.00)

--3. Update

update Plunders
set IsDone = 1 where [Location] = 'Great Reef'

update Pirates
set Pseudonym = SUBSTRING(Pseudonym, 5, LEN(Pseudonym) - 4) where left(Pseudonym, 3) = 'The'

--4. Delete

delete from Pirates where year(Birth) > '1990' and IsCaptain = 0

--5. Pirates and Net Wealth

select Names, Birth, NetWealth from Pirates order by NetWealth desc, Birth asc

--6. Pirates by Ships
select 
	p.Names as [Pirate's Names], 
	p.BerthNumber as [Berth Number], 
	sh.[Name] as [Ship's Name] 
from Pirates as p 
join Ships as sh on p.ShipId = sh.Id 
order by p.ShipId asc, p.Names asc

--7. Pirates without Plunder

select 
	p.Id, 
	p.Names as [Pirate's Names], 
	sh.[Name] as [Ship's Name]
from Pirates as p
left join PiratesPlunders as pp on p.Id = pp.PirateId
join Ships as sh on sh.Id = p.ShipId
where pp.PlunderId is null
order by p.Id

--8. First 5 youngest captains
select top 5 
	p.Names as [Pirate's Names],
	sh.[Name] as [Ship's Name],
	p.BerthNumber as [Berth's Number], 
	b.Category as [Berth Class] 
from Pirates as p
join Ships as sh on sh.Id = p.ShipId
join Berths as b on b.Number = p.BerthNumber
where p.IsCaptain = 1
order by p.Birth desc

--9. Richest Pirate on a Ship
select 
interim.[Pirate's Names], 
interim.[Ship's Name], 
interim.[Pirate's Net Wealth],
	case
		when interim.[Is the Pirate a Captain] = 1 then 'Captain'
		when interim.[Is the Pirate a Captain] <> 1 then 'On-board personnel'
	end as [Job Title]
from
(select 
	p.Names as [Pirate's Names], 
	sh.[Name] as [Ship's Name],
	p.NetWealth [Pirate's Net Wealth],
	p.isCaptain as [Is the Pirate a Captain],
	rank() over(partition by p.ShipId order by p.NetWealth desc) as WealthRank
from Pirates as p
join Ships as sh on p.ShipId = sh.Id) as interim
where WealthRank = 1

--10. Plunder with Most Participants

select top 1 
pp.PlunderId,
pl.[Location],
count(pp.PirateId) as [Participating Pirates] 
from Pirates as p 
join PiratesPlunders as pp on p.Id = pp.PirateId
join Plunders as pl on pl.Id = pp.PlunderId
group by pp.PlunderId, pl.[Location]
order by count(pp.PirateId) desc

--11. Free Berths on a Ship
go
create or alter function udf_FreeBerthsOnShip(@shipId int)
returns int
as
begin
	declare @berths int = (select count(*) from Berths group by ShipId having ShipId = @shipId);
	declare @piratesOn int = (select count(*) from Pirates group by ShipId having ShipId = @shipId);

	return @berths - @piratesOn;
end

go
SELECT dbo.udf_FreeBerthsOnShip(2)
go

--12. Search for Plunder Participants
create or alter procedure usp_SearchParticipantsInPlunder (@location varchar(20))
as
begin
	
	declare @blick int = (select count(*) from Plunders where [Location] = @location)

	if(@blick = 0)
	begin
		RAISERROR ('No plunder done in this location.', 16, 1);
		return;
	end

	select 
		p.Names [Pirate's Names] 
	from Pirates p 
	join PiratesPlunders pp on pp.PirateId = p.Id 
	join Plunders pl on pp.PlunderId = pl.Id 
	where pl.[Location] = @location
	order by p.Names
end

go
exec usp_SearchParticipantsInPlunder 'Albania'
exec usp_SearchParticipantsInPlunder 'Madagascar'