CREATE OR ALTER PROC [stage].LoadDimRegionalManager
as
begin
	insert into [stage].[DimRegionalManager]
	(
		RegionalManagerId,
		RegionalManager,
		Region
	)
	select distinct
		m.[RegionalManagerId],
		m.[RegionalManager],
		m.[Region]

	from [stage].[MultiStore] m;

end;
GO

exec [stage].LoadDimRegionalManager;

