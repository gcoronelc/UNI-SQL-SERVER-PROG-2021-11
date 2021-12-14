
CREATE TRIGGER tr_ddl_database 
ON ALL SERVER 
FOR CREATE_DATABASE 
AS 
BEGIN 
	DECLARE @data XML, @sql varchar(2000); 
	set @data = EVENTDATA(); 
	set @sql = @data.value('(/EVENT_INSTANCE/TSQLCommand)[1]', 'varchar(2000)'); 
	PRINT 'Base de datos creada.' 
	PRINT CONCAT('Sentencia: ', @sql); 
END; 
GO

CREATE DATABASE ALGO;
GO


SELECT * FROM sys.server_triggers;
GO

ENABLE TRIGGER tr_ddl_database ON  ALL SERVER ;

DISABLE TRIGGER tr_ddl_database ON  ALL SERVER ;
