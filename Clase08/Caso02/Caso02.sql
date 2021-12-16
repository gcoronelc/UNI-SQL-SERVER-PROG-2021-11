/*
 * En este caso, el objetivo es tambien auditar el PRECIO
 * de la tabla ARTICULO.
*/

/*
 * BASE DE DATOS: CASO02
*/

create database CASO02;
go

use CASO02;
go

create table articulo(
	idarticulo int not null identity(1,1),
	nombre varchar(100) not null,
	precio money not null,
	fecha_aud datetime not null,
	usuario_aud varchar(150) not null,
	constraint pk_articulo primary key( idarticulo )
);
go

insert into articulo values( 'Pantalon', 100.00, '20210510', 'user01' );
insert into articulo values( 'Camisa', 130.00, '20210602', 'user01' );
insert into articulo values( 'Zapatillas futbol', 240.00, '20210625', 'user01' );
go

select * from articulo;
go


/*
 * Tabla de auditoria de cambio de precio
*/

create table ARTICULO_AUD_PRECIO(
	id int not null identity(1,1),
	fecha_reg datetime not null,
	accion varchar(20) not null,
	idarticulo int not null,
	precio_old money null,
	precio_new money null,
	loginid varchar(150) not null,
	fecha_aud datetime not null,
	usuario_aud varchar(100) not null,
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
		INSERT  INTO dbo.ARTICULO_AUD_PRECIO(fecha_reg,accion,idarticulo,precio_new,loginid,fecha_aud,usuario_aud)
		SELECT GETDATE(),'INSERT',I.idarticulo,I.precio,@login_name,I.fecha_aud,I.usuario_aud FROM Inserted I
		return;
	end;
	IF NOT EXISTS ( SELECT 1 FROM Inserted )
	begin
		INSERT  INTO dbo.ARTICULO_AUD_PRECIO(fecha_reg,accion,idarticulo,precio_old,loginid,fecha_aud,usuario_aud)
		SELECT GETDATE(),'DELETE',D.idarticulo,D.precio,@login_name,GETDATE(),@login_name FROM Deleted D
		return;
	end;
	if( UPDATE(precio) )
	begin
		INSERT  INTO dbo.ARTICULO_AUD_PRECIO(fecha_reg,accion,idarticulo,precio_old,precio_new,loginid,fecha_aud,usuario_aud)
		SELECT GETDATE(),'UPDATE',D.idarticulo,D.precio,I.precio,@login_name,I.fecha_aud,I.usuario_aud
		FROM Inserted I 
		join Deleted D on I.idarticulo = D.idarticulo
	end;
end;
go


/*
 * Prueba: INSERT
*/

insert into articulo values( 'Polo deportivo', 80.00, '20210910', 'user02' );
go

select * from articulo;
select * from ARTICULO_AUD_PRECIO;
go


/*
 * Prueba: UPDATE
*/

update articulo 
set nombre='Polo deportivo color blanco', fecha_aud='20211105', usuario_aud='user06'
where idarticulo = 4;
go

select * from articulo;
select * from ARTICULO_AUD_PRECIO;
go

update articulo 
set precio=95.0, fecha_aud='20211108', usuario_aud='user07'
where idarticulo = 4;
go

select * from articulo;
select * from ARTICULO_AUD_PRECIO;
go


/*
 * Prueba: DELETE
*/

delete from articulo
where idarticulo = 4;

select * from articulo;
select * from ARTICULO_AUD_PRECIO;
go


/*
 * Actualización masiva
*/

update articulo 
set precio = precio * 1.20, fecha_aud=GETDATE(), usuario_aud='user09';
go

select * from articulo;
select * from ARTICULO_AUD_PRECIO;
go










