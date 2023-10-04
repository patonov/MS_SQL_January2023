use Geography
go

delete Peaks from Peaks as p 
left join Mountains as m on p.MountainId = m.Id 
left join MountainsCountries as mc on mc.MountainId = m.Id
where mc.CountryCode = 'BG'