-- TRIGGER DE ELIMINACION


CREATE TRIGGER tg_delete_departamento
ON departamento
AFTER DELETE
AS
begin
	declare @nombre varchar(100);
	select @nombre = deleted.nombre from deleted;
	print 'Se elimino ' + @nombre;
end;
GO


SELECT * FROM DEPARTAMENTO;
GO

DELETE FROM DEPARTAMENTO WHERE iddepartamento=301;
GO







