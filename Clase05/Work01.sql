
select * from edutec.dbo.Matricula;
go

begin tran;
go

update edutec.dbo.Matricula
set Promedio = Promedio + 1;

select @@ROWCOUNT "FILAS ACTUALIZADAS";
GO

rollback tran;
go


select * from sys.messages;
go

begin
	insert into edutec.dbo.Curso
	values(100,'C','aaaaaaaaaa');
	select @@ERROR "Codigo de Error";
end;
go

select text 
from sys.messages 
where message_id = 547
and language_id = 3082;


RAISERROR ('Tengo un error, no e donde!!!.', -- Message text.  
               16, -- Severity.  
               1 -- State.  
               );  








go

