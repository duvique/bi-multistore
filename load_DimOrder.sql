CREATE OR ALTER PROC [stage].LoadDimOrder
as
begin
	insert into [stage].[DimOrder]
	(
		OrderId,
		OrderDate,
		ShipDate,
		ShipMode,
		Segment
	)
	select distinct
		m.[OrderId],
		convert(datetime, CONVERT(float,m.[OrderDate])),
		convert(datetime, CONVERT(float,m.[ShipDate])),
		m.[ShipMode],
		m.[Segment]
	from [stage].[MultiStore] m;

end;
GO

exec [stage].LoadDimOrder;

select * from [stage].[DimOrder];


