USE RH; 
GO 

CREATE FUNCTION dbo.fn_empleados ( @p_dpto int ) 
RETURNS TABLE 
AS 
	RETURN 
		SELECT idempleado, apellido, nombre 
		FROM dbo.empleado 
		WHERE iddepartamento = @p_dpto; 
GO 

SELECT * FROM dbo.fn_empleados(103); 
GO

