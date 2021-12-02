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

ALTER PROCEDURE USP_RESUMEN_ECONOMICO
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
	-- Columna PROYECTADO
	update @resumen 
	set proyectado = (select sum(mat_precio) 
			from matricula m
			where m.cur_id = t.cur_id)
	from @resumen t
	where cur_id in (select distinct cur_id from matricula);
	-- Columna RECAUDADO
	update @resumen 
	set recaudado = (select sum(pag_importe) 
			from pago p
			where p.cur_id = t.cur_id)
	from @resumen t
	where cur_id in (select distinct cur_id from pago);
	-- Columna FALTA_COBRAR
	update @resumen 
	set FALTA_COBRARR = PROYECTADO - RECAUDADO;
	-- Consulta final
	select * from @resumen;
END;
GO


exec USP_RESUMEN_ECONOMICO;
go



ALTER PROCEDURE USP_RESUMEN_ECONOMICO_V2
AS
BEGIN
WITH
V1 AS (
	SELECT CUR_ID, SUM(mat_precio) PROYECTADO
	FROM MATRICULA 
	GROUP BY CUR_ID ),
V2 AS (
	SELECT CUR_ID, SUM(pag_importe) RECAUDADO
	FROM PAGO 
	GROUP BY CUR_ID )
SELECT 
	C.cur_id CODIGO, C.cur_nombre NOMBRE, C.cur_matriculados MATRICULADOS,
	ISNULL(V1.PROYECTADO,0) PROYECTADO,
	ISNULL(V2.RECAUDADO,0) RECAUDADO,
	ISNULL(V1.PROYECTADO - ISNULL(V2.RECAUDADO,0),0) "FALTA COBRRAR"
FROM CURSO C
LEFT JOIN V1 ON C.cur_id = V1.cur_id 
LEFT JOIN V2 ON C.cur_id = V2.cur_id;
END;
GO

EXEC USP_RESUMEN_ECONOMICO_V2;
GO

