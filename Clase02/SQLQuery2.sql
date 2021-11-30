CREATE FUNCTION dbo.fnSuma ( @num1 int, @num2 int ) 
RETURNS int 
AS 
BEGIN 
	-- Variables
	DECLARE @suma int; 
	-- Proceso
	SET @suma = @num1 + @num2; 
	-- Reporte
	RETURN @suma; 
END; 
GO


SELECT dbo.fnSuma( 24, 56 ) as suma; 
GO

select ROUND(6.56783,2) dato;
go




