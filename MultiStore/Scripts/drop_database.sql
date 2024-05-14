USE [master];

IF DB_ID('multistore_dw') is not null
	ALTER DATABASE [multistore_dw] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE;

DROP DATABASE IF EXISTS [multistore_dw];

DROP SCHEMA IF EXISTS [stage];
