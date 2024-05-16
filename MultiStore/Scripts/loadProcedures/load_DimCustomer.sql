CREATE OR ALTER PROC [stage].LoadDimCustomer
as
begin
	insert into [stage].[DimCustomer]
	(
		CustomerName,
		CustomerAge,
		CustomerBirthday,
		CustomerState
	)
	select distinct
		m.[CustomerName],
		m.[CustomerAge],
		m.[CustomerBirthday],
		m.[CustomerState]
	from [stage].[MultiStore] m;

end;
GO

exec [stage].LoadDimCustomer;
