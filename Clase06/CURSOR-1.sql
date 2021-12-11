
DECLARE @cur_id int, @cur_nombre varchar(100), @cur_precio money;

DECLARE cur_cursos CURSOR 
FOR SELECT cur_id, cur_nombre, cur_precio FROM dbo.CURSO; 
SELECT CURSOR_STATUS('global','cur_cursos') AS 'Después de declarar';

OPEN cur_cursos;
SELECT CURSOR_STATUS('global','cur_cursos') AS 'Después de Abrir';

FETCH NEXT FROM cur_cursos INTO @cur_id, @cur_nombre, @cur_precio; 
PRINT CAST(@cur_id AS VARCHAR(5)) + ' - ' + @cur_nombre + ' - ' + CAST(@cur_precio AS VARCHAR(12)); 
SELECT CURSOR_STATUS('global','cur_cursos') AS 'Después de FETCH';

FETCH NEXT FROM cur_cursos INTO @cur_id, @cur_nombre, @cur_precio; 
PRINT CAST(@cur_id AS VARCHAR(5)) + ' - ' + @cur_nombre + ' - ' + CAST(@cur_precio AS VARCHAR(12)); 

CLOSE cur_cursos; 

DEALLOCATE cur_cursos;
GO

