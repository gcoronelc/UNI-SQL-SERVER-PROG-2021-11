/*
Ejercicio 3
En la base de datos RH, crear un procedimiento que de cada departamento muestre lo siguiente:
▪ La cantidad de empleados
▪ Planilla sin comisión
▪ Planilla con comisión
*/


alter procedure usp_repo_planilla
as
begin
	-- Tabla temporal
	CREATE TABLE #Planilla ( 
		id int NOT NULL IDENTITY(1,1) PRIMARY KEY, 
		codigo int not null,
		nombre varchar(150) NULL, 
		empleados int not null,
		planilla1 numeric(12,2) null,
		planilla2 numeric(12,2) null,
		porcentaje numeric(12,2) null
	);
	-- Declaraciones
	declare @cont int, @valorMaximo int, @codDpto int;
	declare @cantEmps int, @planilla1 numeric(12,2), @planilla2 numeric(12,2);
	declare @importeTotal numeric(12,2);
	-- Llenar primeros datos en lataba
	insert into #Planilla(codigo,nombre,empleados,planilla1,planilla2,porcentaje)
	select iddepartamento, nombre,0,0,0,0 from departamento;
	-- Completar la tabla
	select @valorMaximo = max(id) from #Planilla;
	set @cont = 1;
	while(@cont<=@valorMaximo)
	begin
		select @codDpto=codigo from #Planilla where id=@cont;
		select @cantEmps=COUNT(1), @planilla1=SUM(sueldo),
			   @planilla2=SUM(sueldo + isnull(comision,0))
		from empleado 
		where iddepartamento = @codDpto;
		update #Planilla
		set empleados=@cantEmps, planilla1=isnull(@planilla1,0), planilla2=isnull(@planilla2,0)
		where id=@cont;
		select @importeTotal=sum(planilla2) from #Planilla;
		update #Planilla set porcentaje = planilla2*100/@importeTotal;
		set @cont=@cont+1;
	end;
	-- Consulta final
	select * from #Planilla;
end;
go


EXEC usp_repo_planilla;
GO

select * from #Planilla;

