


SELECT
	c.name "Table name",
	b.name "Index ",
	avg_fragmentation_in_percent "Frag (%)",
	page_count "Page count "
FROM
sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL, NULL, NULL ) AS a
JOIN sys.indexes AS b ON a.object_id = b.object_id AND a.index_id = b.index_id
JOIN sys.tables c ON b.object_id = c.object_id
ORDER BY 3 DESC;
GO

ALTER INDEX PK_Matricula ON Matricula REORGANIZE;
GO

