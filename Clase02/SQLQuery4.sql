CREATE FUNCTION dbo.fn_catalogo ( ) 
RETURNS @tabla TABLE ( 
	codigo int identity(1,1) primary key not null, 
	nombre varchar(50) not null, 
	precio money not null 
	) 
AS 
BEGIN 
	INSERT INTO @tabla(nombre,precio) values('Televisor', 1500.00); 
	INSERT INTO @tabla(nombre,precio) values('Refrigeradora', 1450.00); 
	INSERT INTO @tabla(nombre,precio) values('Lavadora', 1350.00); 
	RETURN; 
END; 
GO 

SELECT * FROM dbo.fn_catalogo(); 
GO