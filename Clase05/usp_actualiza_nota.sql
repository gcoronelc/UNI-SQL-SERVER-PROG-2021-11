/*
Actualizar la nota de un estudiante
*/

select * from MATRICULA;
go

alter procedure usp_actualiza_nota
( @curso int, @alumno int, @nota int )
as
begin
	declare @NError int, @NRowCount int
	begin tran;
	update matricula set mat_nota = @nota 
	where cur_id = @curso and alu_id = @alumno;
	select @NError = @@ERROR, @NRowCount = @@ROWCOUNT;
	if(@NError<>0)
	begin
		rollback tran;
		RAISERROR ('Error en el proceso, intentelo mas tarde',16,1); 
		return;
	end;
	if(@NRowCount<>1)
	begin
		rollback tran;
		RAISERROR ('Datos incorrectos, intentelo mas tarde',16,1); 
		return;
	end;
	commit tran;
	print 'Proceso ejecutado correctamente.';
end;
go


exec usp_actualiza_nota 1,3,15;
go