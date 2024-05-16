CREATE OR ALTER PROC [stage].LoadDimProduct
as
begin
	insert into [stage].[DimProduct]
	(
		ProductId,
		ProductName,
		Category,
		SubCategory
	)
	select distinct
		m.ProductId,
		m.ProductName,
		m.Category,
		m.SubCategory
	from [stage].[MultiStore] m;

end;
GO

exec [stage].LoadDimProduct;
