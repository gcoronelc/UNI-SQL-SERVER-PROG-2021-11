alter PROCEDURE DBO.uspNuevoCiclo
as
begin
	-- Variables
	declare @ciclo varchar(15), @anio int, @mes int;
	declare @fecha1 date, @fecha2 date;
	declare @cadena varchar(15);
	-- Leer el ultimo ciclo
	select @ciclo = max(idciclo) from ciclo;
	-- Obtener año y mes
	set @anio = cast(left(@ciclo,4) as int);
	set @mes = cast(right(@ciclo,2) as int);
	if(@mes<12) 
		set @mes = @mes + 1;
	else
	begin
		set @anio = @anio + 1;
		set @mes = 1;
	end;
	-- Preparar nuevo ciclo
	set @ciclo = cast(@anio as varchar(4)) + '-' + right('00'+cast(@mes as varchar(2)),2);
	-- Las fechas
	set @cadena = '01/' + right('00'+cast(@mes as varchar(2)),2) + '/' + cast(@anio as varchar(4));
	set @fecha1 = convert(date,@cadena,103);
	set @fecha2 = EOMONTH(@fecha1);
	-- Insertar nuevo ciclo
	insert into ciclo(IdCiclo, FecInicio, FecTermino) values(@ciclo,@fecha1,@fecha2)
end;
go


select * from ciclo order by 1 desc;
go


exec uspNuevoCiclo;
go

select getdate(), EOMONTH(getdate());
go


