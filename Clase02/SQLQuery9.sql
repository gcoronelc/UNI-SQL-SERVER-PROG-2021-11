USE EDUCA; 
GO 


ALTER PROCEDURE [dbo].[usp_precio] ( @p_idcurso int, @p_precio money OUT ) 
AS 
BEGIN 
  SELECT @p_precio = cur_precio 
  FROM dbo.CURSO 
  WHERE cur_id = @p_idcurso; 
END;
 
BEGIN 
  DECLARE @precio money; 
  EXEC dbo.usp_precio 3, @precio OUT; 
  PRINT CONCAT( 'PRECIO: ', @precio ); 
END; 
GO