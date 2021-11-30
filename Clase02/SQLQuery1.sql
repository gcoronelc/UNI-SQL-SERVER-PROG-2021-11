BEGIN 

	-- Variables
	DECLARE @NUM1 INT, @NUM2 INT, @SUMA INT; 
	
	-- Datos
	SET @NUM1 = CAST( RAND() * 100 AS INT ); 
	SET @NUM2 = CAST( RAND() * 100 AS INT ); 
	
	-- Proceso
	SET @SUMA = @NUM1 + @NUM2; 
	
	-- Reporte
	PRINT CONCAT( 'NUM1 = ', @NUM1 ); 
	PRINT CONCAT( 'NUM2 = ', @NUM2 ); 
	PRINT CONCAT( 'SUMA = ', @SUMA ); 
	
END; 
GO