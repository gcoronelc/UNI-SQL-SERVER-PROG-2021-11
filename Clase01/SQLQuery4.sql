

create table persona(
	id int not null,
	nombre varchar(30)
);
go


insert into persona values(1,'Jose');
insert into persona values(10,'Karla');
insert into persona values(4,'Daniel');
go



insert into persona values(7,'Juana');
go

create NONCLUSTERED index idex01 on persona(id);
go

drop index persona.idex02;
go

create NONCLUSTERED index idex02 on persona(nombre);
go


create CLUSTERED index idex03 on persona(id);
go

drop index persona.idex01;
go

select * from persona;
go

insert into persona values(6,'Leonor');
go

insert into persona values(2,'Delia');
go


alter table persona
alter column id int not null;
go



alter table persona 
add constraint pk_persona
primary key (id);
go



select * from persona;
go

insert into persona values(6,'Hugo');
go

sp_help persona;
go

