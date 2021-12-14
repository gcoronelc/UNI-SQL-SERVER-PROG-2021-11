
create table #tabla1(
  dato varchar(100)
);
go

drop table #tabla1;
go

insert into #tabla1 values('Hola todos');
go

select * from #tabla1;
go

create procedure usp_demo
as
begin
	create table #tabla1(
	  dato varchar(100)
	);
	insert into #tabla1 values('Feliz navidad');
	select * from #tabla1;
end;
go

exec usp_demo;
go


create table ##mensajes(
  dato varchar(100)
);
go

insert into ##mensajes values('Programar es divertido.');
go







