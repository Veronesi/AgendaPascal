unit Main;
interface
procedure MainMenu;
function ClrNum(str:string):string;
function verifNum(str:string):boolean;
implementation
uses CRT, sysutils ,Graphics, Files, Types, Trees;
{ Constantes }
const
	Titulo = 'MI AGENDA';
var
	Key  : Char;
	MenuSelect : byte;

procedure MainMenu;
begin
	LoadFiles; { Cargar el archivo AGEBDA,TXT o AGENDA.DAT }
	loadTrees; { Cargar los contactos en arboles:  A_tel, A_nom, A_dom }
	GraphicMainMenu; { Dibujamos el menu principal }
end;

function ClrNum(str:string):string; { Limpiar un string y que queden solo numeros }
var i:cardinal;  sl:string;
begin
	fillchar(sl,length(sl),#0);
	for i:=1 to length(str) do
		if str[i] in ['0'..'9'] then sl:=sl+str[i]; { Si el caracter es un numero }
	if sl <> '' then
		ClrNum:= sl { String lipio }
	else
		ClrNum:= '0'; { Si no habia ningun numero devolvemos por defecto 0 }
end;

function verifNum(str:string):boolean;
var i:cardinal;
	sl:string;
begin
	fillchar(sl,length(sl),#0);
	for i:=1 to length(str) do
		if str[i] in ['0'..'9'] then
			sl:=sl+str[i];
	if (length(sl) = length(str)) and (str <> '') then
		verifNum:= false
	else
	verifNum:= true;
end;
end.