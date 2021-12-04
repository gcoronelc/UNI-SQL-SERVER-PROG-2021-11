
CREATE FUNCTION dbo.fnPromedio
(
	@nota1 int, @nota2 int, @nota3 int, @nota4 int
)
RETURNS int
AS
BEGIN
	-- Variables
	DECLARE @promedio int, @menor int;
	-- Proceso
	set @menor = @nota1;
	if(@menor>@nota2) set @menor = @nota2;
	if(@menor>@nota3) set @menor = @nota3;
	if(@menor>@nota4) set @menor = @nota4;
	set @promedio = (@nota1 + @nota2 + @nota3 + @nota4 - @menor) / 3;
	-- Reporte
	RETURN @promedio;

END
GO


select dbo.fnPromedio(12,15,16,18) promedio;
go



