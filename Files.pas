unit Files;
interface
uses CRT, Types, Sysutils;
procedure LoadFiles;
procedure creafile(var F: FILE; FName: String; RecLen: word);
procedure abrefile(var F: File; FName: String; RecLen: word);
procedure cierrafile(var F: File; FName: String);
procedure LeeReg(var F:File; Pos: Cardinal; var Buffer);
procedure GuardaReg(var F: File; Pos: Cardinal; var Buffer);	
implementation
const
	nameFile = 'C:\Agenda\agenda'; { Ruta de los archivos .txt y .dat }
	
procedure LoadFiles;
var
	AgendaTxt: text;
	Line: string;
	contacto: Tcontacto;
begin
	{$I-}
	assign(Fagenda,nameFile+'.dat'); { Archivo de Tcontacto }
	reset(Fagenda,SIZEOF(Rcontact));
	{$I+}
	if IOResult <> 0 then { Nos fijamos si el archivo .dat existe }
	begin { Si no existe }
		{ Creamos y cargamos el .dat }
		FillChar(Fagenda, SizeOf(Fagenda), 0);
		assign(Fagenda,nameFile+'.dat');
		Rewrite(Fagenda,SIZEOF(Rcontact));
		assign(AgendaTxt, nameFile+'.txt'); { Texto Plano en donde se encuentran almacenados los contactos }
		reset(AgendaTxt);
		while Line <> '' do { Recorremos hasta fin de archivo }
		begin
			readln(AgendaTxt , Line); { Leemos la linea }
			if Line <> '' then
			begin
			{ Campos de contacto } 
			contacto.nombre:= copy(Line, 16, 20);
			contacto.telefono:= StrToInt(ClrNum(copy(Line, 2, 13))); { Transformamos el Str a Int  }
			contacto.domicilio:= copy(Line, 37, 20);
			contacto.estado:= true; { Por defecto el estado es True }
			GuardaReg(Fagenda, FILESIZE(Fagenda), contacto); { Guardamos el contacto leido en el archivo .dat }
			end;
		end;
		//Close(Fagenda);
	end
	else { Si existe }
	begin
		LeeReg(Fagenda, 0, contacto); { Cargamos los datos que se encuentran en el archivo .dat }
	end;
end;

procedure creafile(var F: FILE; FName: String; RecLen: word);
begin
	{$I-};
	Close(F);
	{$I+};
	FillChar(F, SizeOf(F), 0);
	assign(F,FName);
	Rewrite(F,RecLen);
	Close(F);
end;

procedure abrefile(var F: File; FName: String; RecLen: word);
begin
	{$I-};
	assign (F,FName);
	reset (F,RecLen);
	{$I+};
	if (IOResult <> 0) then
		rewrite (F,RecLen);
end;

procedure cierrafile(var F: File; FName: String);
begin
	Close(F);
	if IORESULT<>0 then
		write('error: no se pudo cerrar '+FName);
end;

procedure LeeReg(var F:File; Pos: Cardinal; var Buffer);
var
	Blocksread : word;
begin
	Seek(F,Pos);
	{$I-}
	BlockRead(F, Buffer,1,Blocksread);
	{$I+}
	{if Blocksread = 0 then
	write('error: no se pudo leer registro');}
end;

procedure GuardaReg(var F: File; Pos: Cardinal; var Buffer);
var
	Blockswrite: word;
begin
	Seek(F, Pos);
	BlockWrite(F, Buffer,1, Blockswrite);
	if Blockswrite = 0 then
		write('error: no se pudo guardar registro');
end;
end.