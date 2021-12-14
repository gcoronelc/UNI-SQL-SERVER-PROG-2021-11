
CREATE DATABASE AuditDB; 
GO

USE AuditDB; 
GO


CREATE TABLE dbo.DDLEvents ( 
	EventDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, 
	EventType NVARCHAR(64), 
	EventDDL NVARCHAR(MAX), 
	EventXML XML, 
	DatabaseName NVARCHAR(255), 
	SchemaName NVARCHAR(255), 
	ObjectName NVARCHAR(255), 
	HostName VARCHAR(64), 
	IPAddress VARCHAR(32), 
	ProgramName NVARCHAR(255), 
	LoginName NVARCHAR(255) 
);
GO


USE EDUTEC; 
GO

CREATE TRIGGER DDL_Change_Log 
ON DATABASE 
FOR CREATE_PROCEDURE, ALTER_PROCEDURE, DROP_PROCEDURE, CREATE_TABLE, 
	ALTER_TABLE, DROP_TABLE, CREATE_FUNCTION, ALTER_FUNCTION, DROP_FUNCTION
AS 
BEGIN 
	SET NOCOUNT ON; 
	DECLARE @EventData XML = EVENTDATA(), 
			@ip VARCHAR(32) = ( SELECT client_net_address 
				FROM sys.dm_exec_connections WHERE session_id = @@SPID ); 
	INSERT AuditDB.dbo.DDLEvents ( EventType, EventDDL, EventXML, DatabaseName, 
		SchemaName, ObjectName, HostName, IPAddress, ProgramName, LoginName ) 
	SELECT @EventData.value('(/EVENT_INSTANCE/EventType)[1]', 'NVARCHAR(100)'), 
	@EventData.value('(/EVENT_INSTANCE/TSQLCommand)[1]', 'NVARCHAR(MAX)'), 
	@EventData, DB_NAME(), 
	@EventData.value('(/EVENT_INSTANCE/SchemaName)[1]', 'NVARCHAR(255)'), 
	@EventData.value('(/EVENT_INSTANCE/ObjectName)[1]', 'NVARCHAR(255)'), 
	HOST_NAME(), 
	@ip, 
	PROGRAM_NAME(), 
	SUSER_SNAME(); 
END; 
GO


CREATE PROC dbo.usp_GetDBVersion 
AS 
BEGIN
	SELECT @@version AS VErsion;
END;
GO

drop procedure usp_GetDBVersion;
go


SELECT * FROM AuditDB.dbo.DDLEvents; 
GO








