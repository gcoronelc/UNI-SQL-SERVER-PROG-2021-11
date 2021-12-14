

-- Creando la tabla

USE master;
GO 


CREATE TABLE DDLSecurityLog
( 
	DDLSecurityLog_ID int IDENTITY(1, 1) NOT NULL, 
	InsertionDate datetime NOT NULL 
		CONSTRAINT DF_ddl_log_InsertionDate
		DEFAULT ( GETDATE() ), 
	CurrentUser nvarchar(50) NOT NULL 
		CONSTRAINT DF_ddl_log_CurrentUser 
		DEFAULT ( CONVERT(nvarchar(50), USER_NAME(), 0 ) ), 
	LoginName nvarchar(50) NOT NULL 
		CONSTRAINT DF_DDLSecurityLog_LoginName  
		DEFAULT ( CONVERT(nvarchar(50), SUSER_SNAME(), ( 0 )) ), 
	Username nvarchar(50) NOT NULL 
		CONSTRAINT DF_DDLSecurityLog_Username  
		DEFAULT ( CONVERT(nvarchar(50), original_login(), ( 0 )) ), 
	EventType nvarchar(100) NULL, 
	objectName nvarchar(100) NULL, 
	objectType nvarchar(100) NULL, 
	DatabaseName nvarchar(100) NULL, 
	tsql nvarchar(MAX) NULL 
) ;
GO


-- Creando el trigger de seguridad para el servidor

USE master;
GO

IF EXISTS ( SELECT  * 
            FROM    sys.server_triggers 
            WHERE   name = 'trgLogServerSecurityEvents' )  
    DROP TRIGGER trgLogServerSecurityEvents ON ALL SERVER;
GO


CREATE TRIGGER trgLogServerSecurityEvents ON ALL SERVER 
    FOR CREATE_LOGIN, ALTER_LOGIN, DROP_LOGIN, GRANT_SERVER, DENY_SERVER, 
        REVOKE_SERVER, ALTER_AUTHORIZATION_SERVER 
AS 
BEGIN
	DECLARE @data XML 
	SET @data = EVENTDATA() 
	INSERT  INTO master..DDLSecurityLog 
	( 
		EventType, 
		ObjectName, 
		ObjectType, 
		DatabaseName,
		tsql
	) 
	VALUES 
	( 
		@data.value('(/EVENT_INSTANCE/EventType)[1]', 'nvarchar(100)'), 
		@data.value('(/EVENT_INSTANCE/ObjectName)[1]', 'nvarchar(100)'), 
		@data.value('(/EVENT_INSTANCE/ObjectType)[1]', 'nvarchar(100)'), 
		'Server', 
		@data.value('(/EVENT_INSTANCE/TSQLCommand)[1]', 'nvarchar(max)') 
	);  
END;
GO 

-- Trigger de seguridad en cada base de datos

USE RH;
go

CREATE TRIGGER trgLogDatabaseSecurityEvents 
ON DATABASE 
FOR DDL_DATABASE_SECURITY_EVENTS 
AS 
BEGIN
	DECLARE @data XML;
	SET @data = EVENTDATA();
	INSERT  INTO master..DDLSecurityLog 
	( 
		EventType, 
		ObjectName, 
		ObjectType, 
		DatabaseName, 
		tsql 
	) 
    VALUES   
	( 
		@data.value('(/EVENT_INSTANCE/EventType)[1]', 'nvarchar(100)'), 
		@data.value('(/EVENT_INSTANCE/ObjectName)[1]', 'nvarchar(100)'), 
		@data.value('(/EVENT_INSTANCE/ObjectType)[1]', 'nvarchar(100)'), 
		@data.value('(/EVENT_INSTANCE/DatabaseName)[1]', 'nvarchar(max)'), 
		@data.value('(/EVENT_INSTANCE/TSQLCommand)[1]', 'nvarchar(max)') 
	);
END; 
GO 

-- Forzando el disparo de los triggers

USE master;
GO 

CREATE LOGIN intruso 
	WITH 
		PASSWORD= N'123456', 
		DEFAULT_DATABASE = RH;
GO 

EXEC master..sp_addsrvrolemember 
	@loginame = N'intruso', 
	@rolename = N'sysadmin';
GO 



USE RH; 
GO 

CREATE USER intruso FOR LOGIN intruso 
GO





DROP USER intruso 
GO 


-- Consultando el log

SELECT  * FROM    master..DDLSecurityLog;
go

