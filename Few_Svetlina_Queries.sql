select 
	[Name]
	,[Quantity]
	,[BoxCapacity]	
	,[PalletCapacity]
	, ceiling(ceiling(cast(Quantity as float) / BoxCapacity) / PalletCapacity) as [Number of pallets] 
from Products

select 
	InvoiceId,	
	Total,
	datepart(QUARTER, InvoiceDate) as Qarter,
	Month(InvoiceDate) as [Month],
	Year(InvoiceDate) as [Year],
	Day(InvoiceDate) as [Day]
from Invoices