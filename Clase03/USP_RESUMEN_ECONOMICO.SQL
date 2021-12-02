/*
Desarrolle un procedimiento que reporte por cada curso la cantidad de 
alumnos matriculados, el importe recaudado y el importe que falta cobrar.
Base de Datos EDUCA.

CODIGO    NOMBRE         MATRICULADOS    PROYECTADO    RECAUDADO     FALTA COBRAR
--------------------------------------------------------------------------------------
.........
.........
.........
--------------------------------------------------------------------------------------
*/

CREATE PROCEDURE USP_RESUMEN_ECONOMICO
AS
BEGIN
	-- Definir la tabla
	DECLARE @RESUMEN AS TABLE 
	(
		CUR_ID INT NOT NULL PRIMARY KEY,
		NOMBRE VARCHAR(100) NOT NULL,
		MATRICULADOS INT NOT NULL,
		PROYECTADO MONEY NOT NULL,
		RECAUDADO MONEY NOT NULL,
		FALTA_COBRARR MONEY NOT NULL
	);
	-- Llenar los 3 primeros campos
	insert into @resumen 
	select cur_id, cur_nombre, cur_matriculados, 0, 0, 0 
	from curso;
	

	-- Consulta final
	select * from @resumen;
END;
GO


exec USP_RESUMEN_ECONOMICO;
go



