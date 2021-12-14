-- TRIGGER DE INSERCI�N
/*

FOR | AFTER | INSTEAD OF

FOR | AFTER: Despu�s de la acci�N.
INSTEAD OF: Se aplica solo a vistas.

*/



ALTER TRIGGER tg_insert_departamento
ON departamento
AFTER INSERT
AS
begin
	declare @mensaje varchar(1000);
	select @mensaje = 'SE inserto el codigo ' + cast(inserted.iddepartamento as varchar(10)) 
	from inserted;
	print @mensaje;
end;
GO


insert into departamento values( 301, 'demo', 'U01');
go






