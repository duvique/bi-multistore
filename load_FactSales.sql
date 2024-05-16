CREATE OR ALTER PROC [stage].LoadFactSales
as
begin
	insert into [stage].[FactSales]
	(
		[OrderId],
		[ProductId],
		[RegionalManagerId],
		[CustomerId],
		[LocationId],
		[Sales],
		[Quantity],
		[Discount],
		[Profit] 
	)
	select
		dimOrder.Id,
		dimProduct.Id,
		dimRegManager.Id,
		dimCustomer.Id,
		dimLoc.Id,
		m.Sales,
		m.Quantity,
		m.Discount,
		m.Profit	
	from [stage].[MultiStore] m
		join [stage].[DimLocation] dimLoc on 
		(
			m.City = dimLoc.City and
			m.[State] = dimLoc.[State] and
			m.Country = dimLoc.Country and
			m.PostalCode = dimLoc.PostalCode or (dimLoc.PostalCode is null and m.PostalCode is null)
		)
		join [stage].[DimRegionalManager] dimRegManager on 
		(
			m.RegionalManagerId = dimRegManager.RegionalManagerId and
			m.RegionalManager = dimRegManager.RegionalManager and
			m.Region = dimRegManager.Region
		)	
		join [stage].[DimProduct] dimProduct on
		(
			m.ProductId   =	dimProduct.ProductId   and
			m.ProductName =	dimProduct.ProductName and
			m.Category    =	dimProduct.Category	   and
			m.SubCategory = dimProduct.SubCategory
		)			
		join [stage].[DimOrder] dimOrder on
		(
			m.OrderId	= dimOrder.OrderId and
			convert(datetime, CONVERT(float, m.OrderDate)) = dimOrder.OrderDate and
			convert(datetime, CONVERT(float, m.ShipDate)) = dimOrder.ShipDate and
			m.ShipMode  = dimOrder.ShipMode and
			m.Segment	= dimOrder.Segment
		)
		join [stage].[DimCustomer] dimCustomer on
		(
			m.CustomerName	= dimCustomer.CustomerName and
			m.CustomerAge	= dimCustomer.CustomerAge and
			m.CustomerBirthday	= dimCustomer.CustomerBirthday and
			m.CustomerState	= dimCustomer.CustomerState
		);
end;
GO

exec [stage].LoadFactSales;

select * from [stage].[FactSales]