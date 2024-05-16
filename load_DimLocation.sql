CREATE OR ALTER PROC [stage].LoadDimLocation
as
begin
	insert into [stage].[DimLocation]
	(
		[Country],
		[State],
		[City],
		[PostalCode]
	)


	select distinct
		m.[Country],
		m.[State],
		m.[City],
		m.[PostalCode]
	from [stage].[MultiStore] m;
end;
GO

exec [stage].LoadDimLocation;
