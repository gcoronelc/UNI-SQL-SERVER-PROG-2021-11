

CREATE PROCEDURE dbo.usp_suma ( @num1 int, @num2 int ) 
AS 
BEGIN 
	DECLARE @suma int; 
	SET @suma = @num1 + @num2; 
	SELECT @num1 NUM1, @num2 NUM2, @suma SUMA; 
END; 
GO 


EXEC dbo.usp_suma 54, 76; 
GO




