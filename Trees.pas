unit Trees;
interface
	uses CRT, Types, Files, sysutils;
	procedure loadTrees();  
	procedure insertTree(var root:Ttree; key:string; position:longint);
	procedure replace(var p, temp: Ttree);
	procedure deleteInTree(var root:Ttree; Kx: string; x: string);
	procedure newTree(var root:Ttree);
implementation

procedure loadTrees();
var position: longint;
begin
	{ Creamos los arboles si no existen }
	if A_tel = nil then
		newTree(A_tel);
	if A_nom = nil then
		newTree(A_nom);
	if A_dom = nil then
		newTree(A_dom);
	for position := 0 to (filesize(Fagenda))-1 do { Recorremos todos los contactos }
	begin
		LeeReg(Fagenda,position,Rcontact); { Leemos el position-esimo contacto }
		{ Insertamos los campos del contacto en cada arbol }
		insertTree(A_tel,IntToStr(Rcontact.telefono),position);
		insertTree(A_nom,Rcontact.nombre,position);
		insertTree(A_dom,Rcontact.domicilio,position);
	end;
end;

procedure insertTree(var root:Ttree; key:string; position:longint);
var i : Ttree;
begin
	if root = nil then { Si el arbol esta vacio }
	begin
		new(i); { Arbol auxiliar }
		i^.key := key;
		i^.position := position;
		i^.slt := nil;
		i^.srt := nil;
		root   := i;
	end
	else
		if key < root^.key then { Ver para que lado tenemos que movernos }
			insertTree(root^.slt, key, position) { Izquierda }
		else
			insertTree(root^.srt, key, position); { Derecha }
end;

procedure replace(var p, temp: Ttree); {encuentra el hijo mayor del SAI y reemplaza por raiz}
begin
	if p^.srt <> nil then
		replace(p^.srt, temp)
	else
	begin
		temp^.key := p^.key;
		temp := p;
		p := p^.slt;
	end;
end;  

procedure deleteInTree(var root:Ttree; Kx: string; x: string);
var i : Ttree;
begin
	if root = nil then
		x := #0
	else
	begin
		if Kx = root^.key then
		begin
			i := root;
			if root^.slt = nil then
				root := root^.srt
			else
				replace(root^.slt, i);
			dispose(i);
    	end else
    	begin
			if Kx < root^.key then
				deleteInTree(root^.slt, Kx, x)
			else
				deleteInTree(root^.srt, Kx, x);
		end;
	end;
end;

procedure newTree(var root:Ttree);
begin
	root := nil;
end;
end.
