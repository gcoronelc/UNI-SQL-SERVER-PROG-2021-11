
CREATE FUNCTION dbo.fnFactorial 
(
	@numero int
)
RETURNS int
AS
BEGIN
	-- Variables
	DECLARE @factorial int;
	-- Proceso
	set @factorial = 1;
	while(@numero>1)
	begin
		set @factorial = @factorial * @numero;
		set @numero = @numero - 1;
	end;
	-- Reporte
	RETURN @factorial;
END
GO


select dbo.fnFactorial (5);
go


