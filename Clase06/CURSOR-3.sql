/*
Ejercicio 1
En la base de datos RH, crear un procedimiento que de cada 
departamento muestre el trabajador con menor salario y el 
trabajador con mayor tiempo de servicio. 
Se deben mostrar los empates.
*/


alter procedure usp_ejercicio1
as
begin
	-- Variables
	DECLARE @codigo int, @nombre varchar(100), @trabajador varchar(200);
	DECLARE @sueldo money;
	-- Cursor
	DECLARE cur_departamentos CURSOR FORWARD_ONLY STATIC
	FOR SELECT iddepartamento, nombre FROM dbo.departamento; 
	-- Abrir el cursor
	OPEN cur_departamentos;
	-- Bucle principal
	FETCH NEXT FROM cur_departamentos INTO @codigo, @nombre;
	WHILE(@@FETCH_STATUS=0)
	BEGIN
		PRINT CAST(@codigo AS VARCHAR(5)) + ' - ' + @nombre; 
		-- Sueldo mayor
		select top 1 @trabajador = concat(nombre,', ', apellido), @sueldo = sueldo 
		from empleado
		where iddepartamento = @codigo
		order by sueldo desc
		print '    MAYOR SALARIO: ' + @trabajador + ' -  '  + cast(@sueldo as varchar(12));
		-- Sueldo menor
		select top 1 @trabajador = concat(nombre,', ', apellido), @sueldo = sueldo 
		from empleado
		where iddepartamento = @codigo
		order by sueldo asc
		print '    MENOR SALARIO: ' + @trabajador + ' -  '  + cast(@sueldo as varchar(12));
		FETCH NEXT FROM cur_departamentos INTO @codigo, @nombre; 
		print '';
	END;
	-- Cerrar el cursor
	CLOSE cur_departamentos; 
	-- Liberar el cursos
	DEALLOCATE cur_departamentos;
end;
go

EXEC usp_ejercicio1;
go