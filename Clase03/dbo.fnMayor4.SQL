/*
Desarrollar una función que retorne el mayor de 2 números.
*/

CREATE FUNCTION dbo.fnMayor4 ( @num1 int, @num2 int, @num3 int, @num4 int ) 
RETURNS int 
AS 
BEGIN 
	-- Variables
	DECLARE @mayor int;
	-- Proceso
	set @mayor = @num1; -- Arquimedes, punto de apoyo
	if(@num2 > @mayor) set @mayor = @num2;
	if(@num3 > @mayor) set @mayor = @num3;
	if(@num4 > @mayor) set @mayor = @num4;
	-- Reporte
	RETURN @mayor; 
END; 
GO

select dbo.fnMayor4( 790,675, 500, 500 ) Mayor;
go


