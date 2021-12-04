-- MICHAEL EDUARDO ATOCCSA LOPEZ21:09
-- Avance:

Alter function dbo.fxPromedio4
(	@nota1 int,
	@nota2 int,
	@nota3 int,
	@nota4 int
)
returns float
as
begin
	declare @menor int
	declare @sum int 
	declare @prom float
	set @sum = @nota1 + @nota2 + @nota3 + @nota4
	set @menor = @nota1
	if (@menor > @nota2) set @menor = @nota2
	if (@menor > @nota3) set @menor = @nota3
	if (@menor > @nota4) set @menor = @nota4
	set @prom = (@sum * 1.0 - @menor)/3
	return @prom
end
go



select dbo.fxPromedio4(1,15,16,18)
go