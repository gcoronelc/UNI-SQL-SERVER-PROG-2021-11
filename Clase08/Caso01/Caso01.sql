/*
 * BASE DE DATOS: CASO01
*/

create database CASO01;
go

use CASO01;
go

create table articulo(
  idarticulo int not null identity(1,1),
  nombre varchar(100) not null,
  precio money not null,
  constraint pk_articulo primary key( idarticulo )
);
go

insert into articulo values( 'Pantalon', 100.00 );
insert into articulo values( 'Camisa', 130.00 );
insert into articulo values( 'Zapatillas futbol', 240.00 );
go


/*
 * Tabla de auditoria de cambio de precio
*/

create table ARTICULO_AUD_PRECIO(
	id int not null identity(1,1),
	accion varchar(20) not null,
	idarticulo int not null,
	precio_old money null,
	precio_new money null,
	fecha datetime not null,
	usuario varchar(150) not null,
	constraint PK_ARTICULO_AUD_PRECIO primary key (id)
);
go

/*
 * Trigger de auditoria de cambio de precio
*/

create trigger tg_articulo_aud_precio
on articulo
for insert, update, delete
as
begin
	DECLARE @login_name VARCHAR(128);

    SELECT  @login_name = login_name
    FROM    sys.dm_exec_sessions
    WHERE   session_id = @@SPID;

	IF NOT EXISTS ( SELECT 1 FROM Deleted )
	begin
		INSERT  INTO dbo.ARTICULO_AUD_PRECIO(accion,idarticulo,precio_new,fecha,usuario)
		SELECT 'INSERT', I.idarticulo, I.precio, GETDATE(), @login_name FROM Inserted I
		return;
	end;
	IF NOT EXISTS ( SELECT 1 FROM Inserted )
	begin
		INSERT  INTO dbo.ARTICULO_AUD_PRECIO(accion,idarticulo,precio_old,fecha,usuario)
		SELECT 'DELETE', D.idarticulo, D.precio, GETDATE(), @login_name FROM Deleted D
		return;
	end;
	if( UPDATE(precio) )
	begin
		INSERT  INTO dbo.ARTICULO_AUD_PRECIO(accion,idarticulo,precio_old,precio_new,fecha,usuario)
		SELECT 'UPDATE', D.idarticulo, D.precio, I.precio, GETDATE(), @login_name 
		FROM Inserted I 
		join Deleted D on I.idarticulo = D.idarticulo
	end;
end;
go


/*
 * Pruebas
*/

insert into articulo values( 'Polo deportivo', 80.00 );
go

select * from ARTICULO_AUD_PRECIO;
go

update articulo 
set nombre='Polo deportivo color blanco'
where idarticulo = 4;
go

select * from ARTICULO_AUD_PRECIO;
go

update articulo 
set precio=95.0
where idarticulo = 4;
go

select * from ARTICULO_AUD_PRECIO;
go

delete from articulo
where idarticulo = 4;

select * from ARTICULO_AUD_PRECIO;
go


update articulo 
set precio = precio * 1.20;
go

select * from ARTICULO_AUD_PRECIO;
go








