-- Create Starting Logs procedure

drop procedure if EXISTS schclouddev.uspADFLogsStartingHierarchy;
go

create procedure schclouddev.uspADFLogsStartingHierarchy
				@p_TriggerType  VARCHAR(500) ,
				@p_TriggerId VARCHAR(500) , 
				@p_TriggerName VARCHAR(500),
				@p_TriggerTime VARCHAR(500),
				@p_ADFName varchar(500) ,
				@p_RunID varchar(500) ,
				@p_PipelineName Varchar(500) ,
				@p_StartTime datetime , 
				@p_ParentID int
AS 
BEGIN
	INSERT INTO schclouddev.ADFLogs(TriggerType, TriggerId, TriggerName, TriggerTime, ADFName, PipelineName, 
							RunID, StartTime, ParentID)
				VALUES(@p_TriggerType, @p_TriggerId, @p_TriggerName, @p_TriggerTime, @p_ADFName, @p_PipelineName, 
						@p_RunID, @p_StartTime, @p_parentid)
	SELECT SCOPE_IDENTITY() as ID;
END
GO
