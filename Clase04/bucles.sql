
begin
	declare @cont int;
	set @cont = 1;
	while (@cont<=10)
	begin
		print 'Alianza Campe�n';
		set @cont = @cont + 1
	end;
	print 'Chau';
end;
go



begin
	declare @cont int;
	set @cont = 0;
	while (1=1)
	begin
		set @cont = @cont + 1;
		if(@cont=4) continue;
		print cast(@cont as varchar) + '.- Alianza Campe�n';
		if( @cont=10) break;
	end;
	print 'Chau';
end;
go



begin
	declare @cont int;
	set @cont = 0;
	while (1=1)
	begin
		set @cont = @cont + 1;
		if(@cont=4) continue;
		print cast(@cont as varchar) + '.- Alianza Campe�n';
		if( @cont=10) GOTO FIN;
	end;
	FIN:
	print 'Chau';
end;
go

