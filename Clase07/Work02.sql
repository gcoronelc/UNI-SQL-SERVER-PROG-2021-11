

CREATE TRIGGER tr_seguridad 
ON DATABASE 
FOR DROP_TABLE, ALTER_TABLE 
AS 
BEGIN 
	RAISERROR('No se permite eliminar ni modificar tablas.',16,1); 
	ROLLBACK; 
END; 
GO


drop table algo;
go


create table algo(
  dato varchar(100)
);
go


ENABLE TRIGGER tr_seguridad ON  DATABASE;

DISABLE TRIGGER tr_seguridad ON  DATABASE;





