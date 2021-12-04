
ALTER FUNCTION dbo.fnFactorial2
(
	@numero int
)
RETURNS int
AS
BEGIN
	if(@numero=0) return 1
	return dbo.fnFactorial2(@numero-1) * @numero;
END
GO


select dbo.fnFactorial2(5);
go


