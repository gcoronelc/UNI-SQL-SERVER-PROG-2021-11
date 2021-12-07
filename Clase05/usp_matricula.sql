/*
Se necesita un procedimiento para registrar una nueva matricula, 
las condiciones son las siguientes:
1. Se debe verificar que el curso programado exista y se encuentre vigente.
2. Se debe verificar que el alumno exista.
3. Se debe verificar que el alumno no se encuentre matriculado.
4. Se debe verificar que existan vacantes disponibles.
5. La matrícula se registra en la tabla MATRICULA.
6. Se deben actualizar las columnas vacantes y matriculados en la tabla CURSOPROGRAMADO.
*/


create procedure usp_matricula
(@CursoProg int, @Alumno char(5))
as
begin
BEGIN TRY
	-- Variables
	declare @contador int ;
	-- Inicio de Tx
	begin tran;
	-- Se debe verificar que el curso programado exista y se encuentre activo
	select @contador = count(1) from CursoProgramado
	where IdCursoProg = @CursoProg and Activo = 1;
	if(@contador!=1)
		THROW 51000, 'El curso no existe o no esta activo.', 1;
	-- Se debe verificar que el curso programado se encuentre vigente

	-- Se debe verificar que el alumno exista.
	select @contador=count(1) from Alumno where IdAlumno=@Alumno;
	if(@contador!=1)
		THROW 51000, 'El alumno no existe.', 1;
	--  Se debe verificar que el alumno no se encuentre matriculado.
	select @contador=count(1) from Matricula
	where IdCursoProg=@CursoProg and IdAlumno=@Alumno;
	if(@contador>0)
		THROW 51000, 'El alumno se encuentra matriculado.', 1;
	-- Se debe verificar que existan vacantes disponibles.
	select @contador=Vacantes from CursoProgramado where IdCursoProg=@CursoProg;
	if(@contador<1)
		THROW 51000, 'No hay vacantes disponibles.', 1;
	-- La matrícula se registra en la tabla MATRICULA.
	insert into matricula(idcursoprog,idalumno,fecmatricula)
	values(@CursoProg,@Alumno,GetDate());
	-- Se deben actualizar las columnas vacantes y matriculados en la tabla CURSOPROGRAMADO.
	update CursoProgramado 
	set Vacantes=Vacantes-1, Matriculados=Matriculados+1
	where IdCursoProg=@CursoProg;
	-- Fin de Tx
	commit tran;
	print 'Proceso ejecutado correctamente';
END TRY 
BEGIN CATCH
	if(@@TRANCOUNT>0)
		rollback;
	SELECT 
		ERROR_NUMBER() AS Numero_de_Error, 
		ERROR_SEVERITY() AS Gravedad_del_Error, 
		ERROR_STATE() AS Estado_del_Error, 
		ERROR_PROCEDURE() AS Procedimiento_del_Error, 
		ERROR_LINE() AS Linea_de_Error, 
		ERROR_MESSAGE() AS Mensaje_de_Error; 
END CATCH;
end;
go

select * from CursoProgramado
where Vacantes<=2;
go

select * from Matricula
where FecMatricula > '20211201'
order by FecMatricula desc;
go

usp_matricula 50, 'A0019';
go

