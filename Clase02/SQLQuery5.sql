alter FUNCTION dbo.fnResumen ( ) 
RETURNS @tabla TABLE ( 
	cur_id int primary key not null, 
	cur_nombre varchar(100) not null, 
	cur_matriculados int not null, 
	comprometido money not null,
	porcentaje   numeric(8,2) not null,
	cobrado money not null,
	falta_cobrar money not null
) 
AS 
BEGIN 
	declare @sumaTotal numeric(10,2);
	-- Datos iniciales
	insert into @tabla 
	select cur_id, cur_nombre, cur_matriculados,0,0,0,0 from curso;
	-- Columna comprometido
	update @tabla
	set comprometido = (select sum(mat_precio) from MATRICULA m
			where m.cur_id = t.cur_id)
	from @tabla t
	where cur_id in (select cur_id from MATRICULA);
	-- Columna cobrado
	update @tabla
	set cobrado = (select sum(pag_importe) from PAGO p
			where p.cur_id = t.cur_id)
	from @tabla t
	where cur_id in (select cur_id from PAGO);
	-- Falta cobrar
	update @tabla set falta_cobrar = comprometido - cobrado;
	-- Porcentaje
	select @sumaTotal = sum(comprometido) from @tabla;
	update @tabla set porcentaje = round(comprometido * 100 / @sumaTotal,2);
	RETURN; 
END; 
GO 

SELECT * FROM dbo.fnResumen(); 
GO