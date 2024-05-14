USE [multistore_dw];

CREATE TABLE [stage].[dim_Customer](
	[CustomerId] nvarchar(max) not null PRIMARY KEY,
	[CustomerName] nvarchar(max) not null,
	[CustomerAge] int not null,
	[CustomerBirthday] nvarchar(max) not null,
	[CustomerState] nvarchar(max) not null,
);

CREATE TABLE [stage].[dim_Location](
	[LocationId] int identity(1,1) PRIMARY KEY,
	[Country] nvarchar(max) not null,
	[City] nvarchar(max) not null,
	[State] nvarchar(max) not null,
);