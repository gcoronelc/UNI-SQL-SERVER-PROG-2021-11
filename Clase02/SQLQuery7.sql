USE EDUCA; 
GO 

CREATE PROCEDURE dbo.usp_lista_cursos 
AS 
BEGIN 
	SET NOCOUNT ON; 
	SELECT * FROM dbo.curso; 
END; 
GO 

EXEC dbo.usp_lista_cursos; 
GO



