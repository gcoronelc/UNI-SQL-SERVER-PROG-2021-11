USE RH; 
GO 

CREATE FUNCTION dbo.fn_planilla ( ) 
RETURNS @planilla TABLE ( 
	codigo int primary key not null, 
	nombre varchar(50) not null, 
	plan_actual money not null, 
	plan_proyectada money not null 
) AS 
BEGIN 
	INSERT INTO @planilla 
	SELECT 
		d.iddepartamento as codido, 
		d.nombre as nombre, 
		SUM(e.sueldo) as "planilla actual", 
		cast(SUM(e.sueldo * 1.15) as money) as "planilla proyectada" 
	FROM dbo.departamento as d 
	JOIN dbo.empleado as e ON d.iddepartamento = e.iddepartamento 
	GROUP BY d.iddepartamento, d.nombre; 
	RETURN; 
END; 
GO 

SELECT * FROM dbo.fn_planilla ( ) 
GO

