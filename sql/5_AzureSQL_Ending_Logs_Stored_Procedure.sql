-- Create Ending Logs procedure

drop PROCEDURE if EXISTS schclouddev.uspADFLogsEndingHierarchy;
GO

create procedure schclouddev.uspADFLogsEndingHierarchy
					@p_ParentID int,
					@p_Source VARCHAR(500) ,
					@p_Destination VARCHAR(500) ,
					@p_SourceType VARCHAR(500) ,
					@p_SinkType VARCHAR(500) ,
		  			@p_RowsCopied VARCHAR(500),
					@p_RowsRead int,  
					@p_NoOfParallelCopies int,
					@p_CopyDurationInSecs VARCHAR(500),
					@p_EffectiveIntegrationRunTime VARCHAR(500),
					@p_CopyActivityStartTime datetime,
					@p_CopyActivityEndTime datetime,
					@p_EndTime datetime,
					@p_Status VARCHAR(500),
					@p_ErrorMessage varchar(MAX) 
AS 
BEGIN
	UPDATE schclouddev.ADFLogs
			SET 
			 	Source = @p_Source, 
				Destination = @p_Destination, 
				SourceType = @p_SourceType, 
				SinkType = @p_SinkType, 
				RowsCopied = @p_RowsCopied,
				RowsRead = @p_RowsRead,
				NoOfParallelCopies = @p_NoOfParallelCopies, 
				CopyDurationInSecs = @p_CopyDurationInSecs, 
				EffectiveIntegrationRunTime = @p_EffectiveIntegrationRunTime,
				CopyActivityStartTime = @p_CopyActivityStartTime,
				CopyActivityEndTime = @p_CopyActivityEndTime,
				EndTime = @p_EndTime,
				[Status] = @p_Status,
				ErrorMessage = @p_ErrorMessage
			WHERE ID= @p_ParentID;
END
GO
