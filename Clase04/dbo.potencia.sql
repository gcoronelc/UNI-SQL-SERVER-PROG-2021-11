-- Robinson Santa Cruz Atahualpa20:14

CREATE FUNCTION dbo.potencia 
(
	@base int, @exponente int
)
RETURNS int
AS
BEGIN
	-- Variables
	DECLARE @repetir int;
	DECLARE @total int;
	-- Proceso
	set @repetir = 1;
	set @total = 1;
	while(@repetir<=@exponente)
	begin
		set @total = @total * @base;
		set @repetir = @repetir + 1;
	end;
	-- Reporte
	RETURN @total;
END
GO

SELECT dbo.potencia(3,4);
GO



-- MICHAEL EDUARDO ATOCCSA LOPEZ20:17
-- Con recursividad :

alter function dbo.fxFuncionPotenciaR
( @base int, @exponente int)
returns int
as
begin
	if(@exponente=0) return 1;
	if(@exponente = 1) return @base;
	return dbo.fxFuncionPotenciaR(@base, (@exponente-1))*@base;
end;
go

Select dbo.fxFuncionPotenciaR(3,0);
go
