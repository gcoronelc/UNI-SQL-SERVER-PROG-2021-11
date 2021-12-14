-- TRIGGER DE UPDATE


CREATE TRIGGER tg_update_departamento
ON departamento
AFTER UPDATE
AS
begin
	declare @nombre_old varchar(100), @nombre_new varchar(100);
	select @nombre_new = inserted.nombre from inserted;
	select @nombre_old = deleted.nombre from deleted;
	print @nombre_old + ' => ' + @nombre_new;
end;
GO


SELECT * FROM DEPARTAMENTO;
GO

UPDATE DEPARTAMENTO
SET NOMBRE = 'PROBLEMA'
WHERE iddepartamento=301;
GO







