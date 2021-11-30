USE EDUCA; 
GO 



 
BEGIN 
  DECLARE @precio money; 
  EXEC dbo.usp_precio 3, @precio OUT; 
  PRINT CONCAT( 'PRECIO: ', @precio ); 
END; 
GO

