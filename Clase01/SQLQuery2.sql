

CREATE CLUSTERED INDEX ind_01
ON alumno2(alu_id);
go

CREATE CLUSTERED INDEX ind_02
ON alumno2(alu_nombre);
go


drop index alumno2.ind_01;
go


sp_help alumno2;
go


alter table alumno2
add constraint pk_alumno2
primary key (alu_id);
go
