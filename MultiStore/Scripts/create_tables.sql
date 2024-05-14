USE [multistore_dw];

CREATE TABLE [stage].[MultiStore](
	[RowId] int not null,
	[OrderId] nvarchar(max) not null,
	[OrderDate] nvarchar(max) not null,
	[ShipDate] nvarchar(max) not null,
	[ShipMode] nvarchar(max) not null,
	[CustomerId] nvarchar(max) not null,
	[CustomerName] nvarchar(max) not null,
	[CustomerAge] int not null,
	[CustomerBirthday] nvarchar(max) not null,
	[CustomerState] nvarchar(max) not null,
	[Segment] nvarchar(max) not null,
	[Country] nvarchar(max) not null,
	[City] nvarchar(max) not null,
	[State] nvarchar(max) not null,
	[RegionalManagerId] nvarchar(max) not null,
	[RegionalManager] nvarchar(max) not null,
	[PostalCode] nvarchar(max),
	[Region] nvarchar(max) not null,
	[ProductId] nvarchar(max) not null,
	[Category] nvarchar(max) not null,
	[SubCategory] nvarchar(max) not null,
	[ProductName] nvarchar(max) not null,
	[Sales] decimal(10,2) not null,
	[Quantity] int not null,
	[Discount] decimal(10,2) not null,
	[Profit] decimal(10,2) not null,
);
