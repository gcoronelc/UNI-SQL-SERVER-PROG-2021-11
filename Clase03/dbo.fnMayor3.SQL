/*
Desarrollar una función que retorne el mayor de 2 números.
*/

CREATE FUNCTION dbo.fnMayor3 ( @num1 int, @num2 int, @num3 int ) 
RETURNS int 
AS 
BEGIN 
	-- Variables
	DECLARE @mayor int;
	-- Proceso
	set @mayor = @num1; -- Arquimedes, punto de apoyo
	if(@num2 > @mayor) set @mayor = @num2;
	if(@num3 > @mayor) set @mayor = @num3;
	-- Reporte
	RETURN @mayor; 
END; 
GO

select dbo.fnMayor3( 790,675, 500 ) Mayor;
go


