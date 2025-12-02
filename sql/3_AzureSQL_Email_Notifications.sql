-- Create Procedure for email Notification

drop PROCEDURE if exists schclouddev.uspSendEmailNotification;
go

CREATE PROCEDURE schclouddev.uspSendEmailNotification
                    @p_Status VARCHAR(500),
                    @p_ADFName VARCHAR(500), 
                    @p_PipelineName VARCHAR(500),
                    @p_RunID VARCHAR(500),
                    @p_StartTime DATETIME,
                    @p_EndTime DATETIME
AS
BEGIN
    
    DECLARE @statusColor NVARCHAR(10);
    DECLARE @to NVARCHAR(max);
    DECLARE @subject NVARCHAR(500);
    DECLARE @body NVARCHAR(max);

    SET @to = (SELECT STRING_AGG(email,';') from schclouddev.EmailReceipients);
    
    IF @p_Status = 'Start'
    BEGIN
        SET @subject = 'Data Migration Started - ' + @p_PipelineName;
    END
    ELSE IF @p_Status = 'Success'
    BEGIN
        SET @statusColor = 'green';
        SET @subject = N'✅ Data Migration Succeeded - ' + @p_PipelineName;
    END 
    ELSE IF @p_Status ='Failed'
    BEGIN
        SET @statusColor = 'red';
        SET @subject = N'❌ Data Migration Failed - ' + @p_PipelineName;
    END

    

    IF @p_Status = 'Start'
    BEGIN
        SET @body = N'<html><body>' +
                    N'<p>Data Migration Started for Onpremise to Cloud Migration.</p>' + 
                    N'</body></html>';

    END 
    ELSE
    BEGIN
        SET @p_StartTime = (SELECT StartTime FROM schclouddev.ADFLogs where RunID = @p_RunID);
        SET @body = N'<html><head><style> table{font-family:Arial, sans-serif; border-collapse: collapse; width: 100%;}' +
                    N'th, td{border: 1px solid #dddddd; text-align: left; padding: 8px;}'+
                    N'th{background-color: #f2f2f2;}</style></head>'+
                    N'<body><h3>ADF Pipeline Execution Summary</h3>' +
                    N'<table>' +
                    N'<tr>' +
                    N'<th>ADF Name</th>' +
                    N'<th>Pipeline Name</th>' +
                    N'<th>Run ID</th>' +
                    N'<th>Status</th>' +
                    N'<th>Start Time</th>' +
                    N'<th>End Time</th>' +
                    N'</tr>' +
                    N'<tr>' +
                    N'<td>' + @p_ADFName + N'</td>' +
                    N'<td>' + @p_PipelineName + N'</td>' +
                    N'<td>' + @p_RunID + N'</td>' +
                    N'<td><span style=''color:' + @statusColor + N';''><strong>' + @p_Status + N'</strong></span></td>' +
                    N'<td>'+CONVERT(NVARCHAR(19), @p_StartTime, 120) + N'</td>' +
                    N'<td>'+CONVERT(NVARCHAR(19), @p_EndTime, 120) + N'</td>' +
                    N'</tr>' +
                    N'</table>' +                
                    N'</body></html>';
    END
    
    SELECT @to as [to], @subject as [subject], @body as body;

END
GO

/*
DECLARE @RC int;
DECLARE @p_Status varchar(500);
DECLARE @p_ADFName varchar(500);
DECLARE @p_PipelineName varchar(500);
DECLARE @p_RunID varchar(500);
DECLARE @p_StartTime datetime;
DECLARE @p_EndTime datetime;

-- ✔️ Assign parameter values here
SET @p_Status        = 'Success';
SET @p_ADFName       = 'ADF Onprem To Cloud';
SET @p_PipelineName  = 'Master Pipeline';
SET @p_RunID         = '7843bfhds87bn24jh8wr9sfbf';
SET @p_StartTime     = GETDATE();
SET @p_EndTime       = GETDATE();

EXECUTE @RC = [schclouddev].[uspSendEmailNotification] 
     @p_Status,
     @p_ADFName,
     @p_PipelineName,
     @p_RunID,
     @p_StartTime,
     @p_EndTime;
GO
*/