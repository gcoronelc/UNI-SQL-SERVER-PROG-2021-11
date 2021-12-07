
BEGIN
	BEGIN TRY 
		DECLARE @TOTAL INT; 
		SET @TOTAL = 20; 
		SELECT @TOTAL/0 'TOTAL';
	END TRY 
	BEGIN CATCH 
		SELECT 
			ERROR_NUMBER() AS Numero_de_Error, 
			ERROR_SEVERITY() AS Gravedad_del_Error, 
			ERROR_STATE() AS Estado_del_Error, 
			ERROR_PROCEDURE() AS Procedimiento_del_Error, 
			ERROR_LINE() AS Linea_de_Error, 
			ERROR_MESSAGE() AS Mensaje_de_Error; 
	END CATCH; 
END;
GO


BEGIN TRY 
	SELECT * FROM TablaNoExiste; 
	PRINT 'La sentencia anterior tiene error.';
END TRY 
BEGIN CATCH 
	SELECT 
		'SE ENCONTRO UN ERROR' "HAY ERROR",
		ERROR_NUMBER() AS ErrorNumber, ERROR_MESSAGE() AS ErrorMessage; 
END CATCH; 
GO

-- ----------------------------------------------------------

CREATE PROCEDURE usp_ProcEjemplo 
AS
BEGIN
	SELECT * FROM TablaNoExiste; 
END;
GO

BEGIN TRY 
	EXECUTE usp_ProcEjemplo;
END TRY
BEGIN CATCH 
	SELECT 
		'SE ENCONTRO UN ERROR' "HAY ERROR",
		ERROR_NUMBER() AS ErrorNumber, ERROR_MESSAGE() AS ErrorMessage; 
END CATCH; 
GO




BEGIN
	BEGIN TRY 
		-- Variables
		DECLARE @NUM1 INT, @NUM2 INT, @RPTA INT; 
		-- Datos
		SET @NUM1 = 20; 
		SET @NUM2 = 0;
		-- Validación
		IF(@NUM2=0)
			THROW 51000, 'No se puede dividir entre cero.', 1;
		-- Proceso
		SET @RPTA = @NUM1 / @NUM2;
		-- Reporte
		SELECT @RPTA 'TOTAL';
	END TRY 
	BEGIN CATCH 
		SELECT 
			ERROR_NUMBER() AS Numero_de_Error, 
			ERROR_SEVERITY() AS Gravedad_del_Error, 
			ERROR_STATE() AS Estado_del_Error, 
			ERROR_PROCEDURE() AS Procedimiento_del_Error, 
			ERROR_LINE() AS Linea_de_Error, 
			ERROR_MESSAGE() AS Mensaje_de_Error; 
	END CATCH; 
END;
GO


BEGIN
	BEGIN TRY 
		-- Variables
		DECLARE @NUM1 INT, @NUM2 INT, @RPTA INT; 
		-- Datos
		SET @NUM1 = 20; 
		SET @NUM2 = 0;
		-- Validación
		IF(@NUM2=0)
			THROW 51000, 'No se puede dividir entre cero.', 1;
		-- Proceso
		SET @RPTA = @NUM1 / @NUM2;
		-- Reporte
		SELECT @RPTA 'TOTAL';
	END TRY 
	BEGIN CATCH 
		throw;
	END CATCH; 
END;
GO