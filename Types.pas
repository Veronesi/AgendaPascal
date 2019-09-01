Unit Types;
interface
Type
	Ttree=^Tnode;
	Tnode=record
		key:string[20];
		position:longint;
		slt,srt:ttree
	end;
	Tcontacto=record
		nombre:string[20];
		telefono:cardinal;
		domicilio:string[20];
		estado:boolean
	end;
	Tfile = file of Tcontacto;
Var
	Rcontact:Tcontacto;
	Fagenda:Tfile;
	A_tel,A_nom,A_dom:Ttree;
	Cruta:string;
implementation
end.