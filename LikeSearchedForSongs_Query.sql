SELECT 
	s.Id,
	s.[Name]
FROM Songs AS s
WHERE s.[Name] LIKE '%w%'
ORDER BY s.Id