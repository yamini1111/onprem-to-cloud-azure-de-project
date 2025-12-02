----------------------------------------------------------------
-- Create schema schclouddev
----------------------------------------------------------------
CREATE schema schclouddev
go;


----------------------------------------------------------------
-- Switch to the target database
----------------------------------------------------------------
USE [azsql-dev-db];
GO


----------------------------------------------------------------
-- Create table tablelist
----------------------------------------------------------------
drop table if exists schclouddev.tablelist;
CREATE TABLE schclouddev.tablelist
(
  sno int,
  sourceSchema VARCHAR(30),
  sourceTableName VARCHAR(30),
  LoadType VARCHAR(30),
  Status int
);


SELECT * FROM schclouddev.tablelist;


----------------------------------------------------------------
-- Create Watermark table
----------------------------------------------------------------
drop table if exists schclouddev.watermarktable;
CREATE TABLE schclouddev.watermarktable 
(
	id int,
	tablename varchar(30),
	watermarkDateTime datetime
);

insert into schclouddev.watermarktable (id, tablename, watermarkDateTime) values
(1, 'Orders', dateadd(day,-60,getdate())),
(2, 'Reviews', dateadd(day,-60,getdate())),
(3, 'ShippingDetails', dateadd(day,-60,getdate())),
(4, 'Payments', dateadd(day,-60,getdate())),
(5, 'Promotions', dateadd(day,-60,getdate())),
(6, 'Returns', dateadd(day,-60,getdate()));

--TRUNCATE TABLE schclouddev.watermarktable;
SELECT * from schclouddev.watermarktable;


----------------------------------------------------------------
-- Create ADF Logs table
----------------------------------------------------------------
drop table if exists schclouddev.ADFLogs;

create table schclouddev.ADFLogs
(
	ID int identity(1,1),
	Parentid int NULL,
	TriggerType  VARCHAR(500) NULL,
	TriggerId VARCHAR(500) NULL, 
	TriggerName VARCHAR(500) NULL,
	TriggerTime VARCHAR(500) NULL,
	ADFName varchar(500) NULL,
	RunID varchar(500) NULL,
	PipelineName Varchar(500) NULL,
	Status VARCHAR(500) NULL,
	Source VARCHAR(500) NULL,
	Destination VARCHAR(500) NULL,
	SourceType VARCHAR(500) NULL,
	SinkType VARCHAR(500) NUll,
	RowsCopied VARCHAR(500) NULL,
	RowsRead int NULL,  
	NoOfParallelCopies int NULL,
	CopyDurationInSecs VARCHAR(500) NULL,
	EffectiveIntegrationRunTime VARCHAR(500) NULL,
	CopyActivityStartTime datetime NULL,
	CopyActivityEndTime datetime NULL,
	StartTime datetime NULL,
	EndTime datetime NULL,
	ErrorMessage varchar(MAX) NULL	
);

--truncate table schclouddev.ADFLogs;
--select * from schclouddev.ADFLogs where status = 'Failed';
GO


----------------------------------------------------------------
-- Create Email Recipients table
----------------------------------------------------------------
CREATE TABLE schclouddev.EmailReceipients(
    email varchar(500) PRIMARY KEY,
    addedOn DATETIME DEFAULT GETDATE()
);
SELECT * from schclouddev.EmailReceipients;

--INSERT INTO schclouddev.EmailReceipients(email)
--VALUES ('yamini.karri@outlook.com'),
--('srinuazde@outlook.com');

SELECT STRING_AGG(email,';') as [to] from schclouddev.EmailReceipients;
go
