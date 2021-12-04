
CREATE PROCEDURE dbo.uspMcdMcm
(
	@num1 int, @num2 int,
	@mcd int OUT, @mcm int OUT
)
as
begin
	-- Variables
	declare @num1_aux int, @num2_aux int;
	-- Proceso
	set @num1_aux = @num1;
	set @num2_aux = @num2;
	while( @num1 <> @num2 )
	begin
		if(@num1 > @num2) set @num1 = @num1 - @num2;
		else set @num2 = @num2 - @num1;
	end;
	set @mcd = @num1;
	set @mcm = @num1_aux * @num2_aux / @mcd;
end;
go


declare @mcd int, @mcm int;
exec uspMcdMcm 15, 20, @mcd out, @mcm out;
print 'MCD: ' + CAST(@mcd as varchar);
print 'MCM: ' + CAST(@mcm as varchar);
go

