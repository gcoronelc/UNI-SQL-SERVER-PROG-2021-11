/*
Desarrollar una función que retorne el mayor de 2 números.
*/

CREATE FUNCTION dbo.fnMayor2 ( @num1 int, @num2 int ) 
RETURNS int 
AS 
BEGIN 
	-- Variables
	DECLARE @mayor int;
	-- Proceso
	set @mayor = @num1; -- Arquimedes, punto de apoyo
	if(@num2 > @mayor) set @mayor = @num2;
	-- Reporte
	RETURN @mayor; 
END; 
GO

select dbo.fnMayor2( 120,45 ) Mayor;
go


