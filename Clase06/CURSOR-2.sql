
DECLARE @cur_id int, @cur_nombre varchar(100), @cur_precio money;

DECLARE cur_cursos CURSOR 
FOR SELECT cur_id, cur_nombre, cur_precio FROM dbo.CURSO; 

OPEN cur_cursos;
 
FETCH NEXT FROM cur_cursos INTO @cur_id, @cur_nombre, @cur_precio; 
PRINT CAST(@cur_id AS VARCHAR(5)) + ' - ' + @cur_nombre + ' - ' + CAST(@cur_precio AS VARCHAR(12)); 

WHILE(@@FETCH_STATUS=0)
BEGIN
	FETCH NEXT FROM cur_cursos INTO @cur_id, @cur_nombre, @cur_precio; 
	PRINT CAST(@cur_id AS VARCHAR(5)) + ' - ' + @cur_nombre + ' - ' + CAST(@cur_precio AS VARCHAR(12)); 
END;

CLOSE cur_cursos; 

DEALLOCATE cur_cursos;
GO

