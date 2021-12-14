-- TRIGGER DE UPDATE


CREATE TRIGGER tg_update_empleado
ON empleado
AFTER UPDATE
AS
begin
	if(update(sueldo) or update(comision))
	begin
		print 'No se permite modificar el sueldo o comision de un empleado.';
		ROLLBACK;
	end;
end;
GO


SELECT * FROM EMPLEADO;
GO

UPDATE empleado SET sueldo = 5000 WHERE idempleado='E0006';
GO







