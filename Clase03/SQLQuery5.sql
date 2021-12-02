
create procedure dbo.uspCase(@nota int)
as
begin
	-- VARIABLES
	DECLARE @CONDICION VARCHAR(20);
	-- PROCESO
	set @CONDICION = case
			when (@NOTA>=12) then'APROBADO'
			else 'DESAPROBADO'
		end;
	-- REPORTE
	PRINT CONCAT('CONDICION: ', @CONDICION);
end;
go


exec dbo.uspCase 10 ;
go

