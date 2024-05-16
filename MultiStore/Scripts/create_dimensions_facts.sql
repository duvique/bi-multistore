USE [multistore_dw];

CREATE TABLE [stage].[DimLocation](
	[Id] int identity(1,1) PRIMARY KEY,
	[Country] nvarchar(max) not null,
	[State] nvarchar(max) not null,
	[City] nvarchar(max) not null,
	[PostalCode] nvarchar(max),
);

CREATE TABLE [stage].[DimRegionalManager](
	[Id] int identity(1,1) PRIMARY KEY,
	[RegionalManagerId] nvarchar(max) not null,
	[RegionalManager] nvarchar(max) not null,
	[Region] nvarchar(max) not null

);

CREATE TABLE [stage].[DimProduct](
	[Id] int identity(1,1) PRIMARY KEY,
	[ProductId] nvarchar(max) not null,
	[ProductName] nvarchar(max) not null,
	[Category] nvarchar(max) not null,
	[SubCategory] nvarchar(max) not null,
);

CREATE TABLE [stage].[DimOrder](
	[Id] int identity(1,1) PRIMARY KEY,
	[OrderId] nvarchar(max) not null,
	[OrderDate] datetime not null,
	[ShipDate] datetime not null,
	[ShipMode] nvarchar(max) not null,
	[Segment] nvarchar(max) not null,
);

CREATE TABLE [stage].[DimCustomer](
	[Id] int identity(1,1) PRIMARY KEY,
	[CustomerName] nvarchar(max) not null,
	[CustomerAge] int not null,
	[CustomerBirthday] nvarchar(5) not null,
	[CustomerState] nvarchar(max) not null,
);

CREATE TABLE [stage].[FactSales](
	[OrderId] int not null,
	[ProductId] int not null,
	[RegionalManagerId] int not null,
	[CustomerId] int not null,
	[LocationId] int not null,

	[Sales] decimal(10,2) not null,
	[Quantity] int not null,
	[Discount] decimal(10,2) not null,
	[Profit] decimal(10,2) not null,

	CONSTRAINT FK_Fact_Order FOREIGN KEY ([OrderId]) REFERENCES [stage].[DimOrder](Id),
	CONSTRAINT FK_Fact_Product FOREIGN KEY ([ProductId]) REFERENCES [stage].[DimProduct](Id),
	CONSTRAINT FK_Fact_RegionalManager FOREIGN KEY ([RegionalManagerId]) REFERENCES [stage].[DimRegionalManager](Id),
	CONSTRAINT FK_Fact_Customer FOREIGN KEY ([CustomerId]) REFERENCES [stage].[DimCustomer](Id),
	CONSTRAINT FK_Fact_Location FOREIGN KEY ([LocationId]) REFERENCES [stage].[DimLocation](Id),
);
CREATE CLUSTERED INDEX Idx_Fk_Fact_Order ON [stage].[FactSales] ([OrderId]);

select * from [stage].[FactSales]