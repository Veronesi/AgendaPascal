unit Graphics;
interface
	procedure GraphicMainMenu;
	procedure GraphicSeeContact;
	procedure GraphicOrderBy(d:string);
	procedure GraphicAskBy(d:string);
	procedure GraphicAddContact;
	procedure GraphicDelContact;
	procedure GraphicListDelTree(asked:string);
	procedure border(x1,y1,x2,y2:byte);
	procedure centerText(y: byte; str: string);
	procedure FocusMenu(e:byte);
	procedure unFocusMenu(e:byte);
	procedure print(x,y: byte; str: string);
	procedure clrTable;
	procedure clrBx;
	procedure clrTable2;
	procedure BarTable(h:byte);
	procedure BarTable2(h:byte);
	procedure FocusMenu2(e:byte);
	procedure unFocusMenu2(e:byte); 
	procedure select(i:byte);
	procedure deSelect(i:byte);
implementation
	uses CRT, Files, Trees, Types, Main;
procedure GraphicMainMenu;
begin
 	MenuSelect := 1; { Menu por Defecto: 1 }
	textcolor(15); { blanco }
	clrscr; { Limpiar pantalla }
	border(1,1,79,24); { Bordes de la pantalla }
	centerText(2,#205+Titulo+#205); { Titulo centrado }
	{ Graficamos los Menues }
	border(2,4,78,8);
	centerText(6,'Ver contactos');

	border(2,9,78,13);
	centerText(11,'Agregar Contacto');

	border(2,14,78,18);
	centerText(16,'Modificar Contacto');

	border(2,19,78,23);
	centerText(21,'Salir');

	FocusMenu(MenuSelect); { Selecionamos el elemento por Defecto }
	repeat
		Key:= Readkey; { Leemos el teclado }
		case Key of
		#0 :
		Begin
			Key:= ReadKey;
			Case Key Of
				#72 : { Arriba } 
				begin
					if MenuSelect > 1 then
					begin
						unFocusMenu(MenuSelect); { Quitamos el foco al anterior }
						MenuSelect:= MenuSelect-1;
						FocusMenu(MenuSelect); { Hacemos foco en el nuevo menu }
					end;
				end;
				#80 : { Abajo } 
				begin
					if MenuSelect < 4 then
					begin
					unFocusMenu(MenuSelect); { Quitamos el foco al anterior }
					MenuSelect:= MenuSelect+1;
					FocusMenu(MenuSelect); { Hacemos foco en el nuevo menu }
					end;
				end;
			// #75 : WriteLn('Left'); { Izquierda }
			// #77 : WriteLn('Right'); { Derecha }
			End;
		End;
		#13 : case MenuSelect Of { Enter }
			1: GraphicSeeContact; { Graficamos el menu para ver los contactos [Listar todos o algunos] }
			2: GraphicAddContact;
			3: GraphicDelContact;
			4: Key := #27; { Forzamos el cambio de Key a escape }
		end;
	end;
	until Key = #27 { Escale salir }
end;

procedure GraphicSeeContact;
begin
 	MenuSelect := 1; { Menu por Defecto: 1 }
	textcolor(15); { Blanco }
	clrscr; { Limpiar pantalla }
	border(1,1,79,24); { Bordes de la pantalla }
	centerText(2,#205+'Ver contactos'+#205); { Titulo centrado }
	{ Graficamos los Menues }
	border(2,4,78,6);
	centerText(5,'Ordenar por Nombre');

	border(2,7,78,9);
	centerText(8,'Ordenar por Telefono');

	border(2,10,78,12);
	centerText(11,'Ordenar por Direccion');

	border(2,13,78,15);
	centerText(14,'Buscar por Nombre');

	border(2,16,78,18);
	centerText(17,'Buscar por Telefono');

	border(2,19,78,21);
	centerText(20,'Buscar por Direccion');

	border(2,22,78,24);
	centerText(23,'Atras');					

	FocusMenu2(MenuSelect); { Selecionamos el elemento por Defecto }
	repeat
		Key:= Readkey; { Leemos el teclado }
		case Key of
		#0 :
		Begin
			Key:= ReadKey;
			Case Key Of
				#72 : { Arriba } 
				begin
					if MenuSelect > 1 then
					begin
						unFocusMenu2(MenuSelect); { Quitamos el foco al anterior }
						MenuSelect:= MenuSelect-1;
						FocusMenu2(MenuSelect); { Hacemos foco en el nuevo menu }
					end;
				end;
				#80 : { Abajo } 
				begin
					if MenuSelect < 7 then
					begin
					unFocusMenu2(MenuSelect); { Quitamos el foco al anterior }
					MenuSelect:= MenuSelect+1;
					FocusMenu2(MenuSelect); { Hacemos foco en el nuevo menu }
					end;
				end;
			// #75 : WriteLn('Left'); { Izquierda }
			// #77 : WriteLn('Right'); { Derecha }
			End;
		End;
		#13 : case MenuSelect Of { Enter }
			{ Listar todos }
			1: GraphicOrderBy('Nombre');
			2: GraphicOrderBy('Telefono');
			3: GraphicOrderBy('Direccion');
			{ Listar algunos contactos especificos }
			4: GraphicAskBy('Nombre');
			5: GraphicAskBy('Telefono');
			6: GraphicAskBy('Direccion');
			7: Key := #27; { Forzamos el cambio de Key a escape }
		end;
	end;
	until Key = #27; { Escale salir }
	GraphicMainMenu; { Volvemos al menu inicial }
end;

procedure GraphicOrderBy(d:string);
var i: byte;
begin
	textcolor(15); { Blanco }
	clrscr; { Limpiar pantalla }
	border(1,1,79,24); { Bordes de la pantalla }
	centerText(2,#205+'Contactos por '+d+#205); { Titulo centrado }
	{ Texto Siguiente }
	textcolor(10);
	gotoxy(56,2);
	write('[Enter Para Seguir]');
	{ Texto Salir }
	gotoxy(7,2);
	textcolor(12);
	write('[Esc Para Salir]');
	{ Borde superior de la tabla de los contactos }
	textcolor(15);
	gotoxy(4,3);
	write(#218+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#194+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#194+#196+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#191);
	{ Thead }
	gotoxy(56,2);
	textbackground(4); { Rojo }
	gotoxy(4,4);
	write(#179+'		Telefono	   '+#179+'		 Nombre		'+#179+'	   Direccion	   '+#179);
 
	textbackground(0); { Negro }
	{ Ver de que manera se ordenaran los contactos }
	if d = 'Nombre' then GraphicListTree(A_nom);
	if d = 'Telefono' then GraphicListTree(A_tel);
	if d = 'Direccion' then GraphicListTree(A_dom);
	readkey; { #FANAES# }
	GraphicSeeContact; { Volvemos al menu anterior }
end;

procedure GraphicListTree(kTree:Ttree);
var i: cardinal;
	rk: char;
	procedure listRegister(kTree: Ttree);
	begin
		if rk <> #27 then { Si se apreto escape }
		begin
			if i < 9 then { Nos fijamos si ya llenamos la tabla }
			begin
				LeeReg(Fagenda,KTree^.position,Rcontact); { Leemos el contacto }
				BarTable(5+i*2);

				gotoxy(4,6+i*2);
				write(#179+'					   '+#179+'					   '+#179+'					   '+#179); { Limpiamos la fila }
				{ Telefono }
				gotoxy(6,6+i*2);
				write(Rcontact.telefono);
				{ Nombre }
				gotoxy(30,6+i*2);
				write(Rcontact.nombre);
				{ Domicilio }
				gotoxy(54,6+i*2);
				write(Rcontact.domicilio);
				i:= i + 1;
			end
			else
			{ Si la tabla esta llena }
			begin
				rk := readkey; { Leemos para saber si quiere seguir listando o no }
				if rk = #13 then
				begin
					i := 0;
					clrTable; { Limpiamos la pantalla }
				end;
			end;
			if i = 8 then { Graficamos el borde inferior de la tabla }
			begin
				gotoxy(4,23);
				write(#192+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#193+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#193+#196+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#217);
			end;
		end;
	end;
	procedure listT(kTree: Ttree);
	begin
	if (KTree <> nil) and (rk <> #27) then
	begin
		listT(KTree^.slt); { Sub-arbol Izquierdo }
		listRegister(KTree); { Nodo actual }
		listT(KTree^.srt); { Sub-arbol Derecho }
	end;
end;
begin
	i := 0; { Inicializamos la posicion a 0 }
	ListT(KTree);
end;

procedure GraphicAskBy(d:string);
var asked: string;
begin
	textcolor(15); { Blanco }
	clrscr; { Limpiar pantalla }
	border(1,1,79,24); { Bordes de la pantalla }
	{ Titulo }
	gotoxy(27,2);
	write(d+':'); { Titulo centrado }
	{ Seguir }
	textcolor(10);
	gotoxy(56,2);
	write('[Enter Para Seguir]');
	{ Salir }
	gotoxy(7,2);
	textcolor(12);
	write('[Esc Para Salir]');
	{ Leer con que va a matchear }
	textcolor(15);
	gotoxy(29+length(d),2);
	readln(asked);
	{ Borde superior de la tabla }
	gotoxy(4,3);
	write(#218+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#194+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#194+#196+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#191);
	gotoxy(56,2);
	textbackground(4); { Rojo }
	gotoxy(4,4);
	write(#179+'		Telefono	   '+#179+'		 Nombre		'+#179+'	   Direccion	   '+#179);
	textbackground(0); { Negro }
	{ Ver de que manera se ordenaran los contactos }
	if d = 'Nombre' then GraphicListAskTree(A_nom,upcase(asked));
	if d = 'Telefono' then GraphicListAskTree(A_tel,asked);
	if d = 'Direccion' then GraphicListAskTree(A_dom,upcase(asked));
	readkey; { #FANAES# }
	GraphicSeeContact; { Volvemos al menu anterior }
end;

procedure GraphicListAskTree(kTree:Ttree;asked:string);
var i,j: cardinal;
	rk: char;
	procedure listRegister(kTree: Ttree; asked:string);
	begin
		if rk <> #27 then { Nos fijamos si se presiono Esc. }
		begin
			if i < 9 then { Nos fijamos si ya llenamos la tabla de contactos }
			begin { Si queda por rellenar }
				LeeReg(Fagenda,KTree^.position,Rcontact); { Leemos el position-esimo contacto }
				if (pos(asked, Ktree^.key) = 1) and (Rcontact.estado = True) then { Verificamos que matchea con el campo ingresado y que el contacto esta dado de alta }
				begin
					{ Dibujamos los bordes de la fila }
					BarTable(5+i*2);
					gotoxy(4,6+i*2);
					write(#179+'                       '+#179+'                       '+#179+'                       '+#179);
					{ Telefono }
					gotoxy(6,6+i*2);
					write(Rcontact.telefono);
					{ Nombre }
					gotoxy(30,6+i*2);
					write(Rcontact.nombre);
					{ Domicilio }
					gotoxy(54,6+i*2);
					write(Rcontact.domicilio);
					i:= i + 1; { Aumentamos el contador de contacto }
				end;
			end
			else { Si la tabla esta llena }
			begin
				rk := readkey; { Leemos el teclado }
				if rk = #13 then { Nos fijamos si quiere seguir }
				begin
					i := 0; { movemos el indicador de filas hacia arriba }
					clrTable; { Limpiamos la tabla }
				end;
			end;
			if i = 8 then { Si ya completamos la tabla dibujamos el borde inferior de la misma }
			begin
				gotoxy(4,23);
				write(#192+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#193+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#193+#196+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#217);
			end;
		end;
	end;
	procedure listT(kTree: Ttree; asked:string);
	begin
		if (KTree <> nil) and (rk <> #27) then { Nos fijamos que el arbol no este vacio ni que se apreto Esc. }
		begin
			listT(KTree^.slt, asked); { Sub-arbol Izquierdo }
			listRegister(KTree, asked); { Nodo actual }
			listT(KTree^.srt, asked); { Sub-arbol Derecho }
		end;
	end;
begin
	i := 0; { Inicializamos la posicion a 0 }
	j := 0;
	while j < 9 do
	begin
		BarTable(5+j*2);
		gotoxy(4,6+j*2);
		write(#179+'                       '+#179+'                       '+#179+'                       '+#179);
		j:= j + 1;
	end;
	gotoxy(4,23);
	write(#192+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#193+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#193+#196+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#217);
	listT(KTree, asked);
end;

procedure GraphicAddContact;
var nombre, domicilio, telefono: string;
	rk: char;
	contacto: Tcontacto;
begin
	{ Inicializamos los campos con una cadena vacia }
	nombre := '';
	domicilio := '';
	telefono := '';
	textcolor(15); {  Blanco }
	clrscr; { Limpiamos la pantalla }
	border(1,1,79,24); { Bordes de la pantalla }
	centerText(2,#205+'Agregar contacto'+#205); { Titulo centrado }
	{ Nombre }
	border(2,4,78,8);
	centerText(6,'Nombre: ');
	while nombre = '' do { Corroboramos que no deje el campo vacio }
	begin
		gotoxy(44,6);
		readln(nombre);
	end;
	{ Telefono }
	border(2,9,78,13);
	centerText(11,'Telefono: ');
	while verifNum(telefono) do { Corroboramos que ingrese una cadena numerica }
	begin
		gotoxy(45,11);
		write('               ');
		gotoxy(45,11);
		readln(telefono);
	end;
	{ Direccion }
	border(2,14,78,18);
	centerText(16,'Direccion: ');
	while domicilio = '' do { Corroboramos que no deje el campo vacio }
	begin
		gotoxy(46,16);
		readln(domicilio);
	end;
	{ Boton enviar }
	focusmenu(4);
	textbackground(4); { Rojo }
	centerText(21,'Enviar');
	textbackground(0);
	rk := readkey;
	if rk = #13 then { Verificamos si desea enviarlo }
	begin
		{ Guardamos los campos }
		contacto.nombre:= upcase(nombre);
		contacto.telefono:= StrToInt(telefono);
		contacto.domicilio:= upcase(domicilio);
		contacto.estado:= true; { Por defecto el estado es True }
		GuardaReg(Fagenda, FILESIZE(Fagenda), contacto); { Guardamos el contacto en .dat }
		{ Insertamos el nuevo contacto en los arboles }
		insertTree(A_tel,telefono,(filesize(Fagenda))-1);
		insertTree(A_nom,upcase(nombre),(filesize(Fagenda))-1);
		insertTree(A_dom,upcase(domicilio),(filesize(Fagenda))-1);
	end;
	GraphicMainMenu; { Volvemos al menu principal }
end;

procedure GraphicDelContact;
var asked: string;
begin
	textcolor(15); { Blanco }
	clrscr; { Limpiamos la pantalla }
	border(1,1,79,24); { Bordes de la pantalla }
	gotoxy(21,2);
	write('Nombre: '); { Titulo centrado }
	gotoxy(49,2);
	write('ID: '); { Titulo centrado }
	{ Seguir }
	gotoxy(58,2);
	textcolor(10);
	write('[Enter Para Seguir]');
	{ Salir }
	gotoxy(4,2);
	textcolor(12);
	write('[Esc Para Salir]');
	{ Borde superior de la tabla }
	textcolor(15);
	gotoxy(4,3);
	write(#218+#196+#196+#196+#196#196+#196+#196+#196+#194+#196+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#196+#194+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#194+#196+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#191);
	{ THEAD }
	textbackground(4); { Rojo }
	gotoxy(4,4);
	write(#179+'   ID   '+#179+'   Telefono    '+#179+'        Nombre        '+#179+'       Direccion       '+#179);
	textbackground(0); { Negro }
	gotoxy(29,2); 
	readln(asked);  
	GraphicListDelTree(upcase(asked)); 
	GraphicMainMenu; { Volvemos al menu principal }
end;

procedure GraphicListDelTree(asked:string);
var i,j: cardinal;
	rk: string;
	procedure EditContact(pos:longint);
	var rk : char;
		i: byte;
		nombre,domicilio,telefono : string;
		estado: boolean;
		contacto: Tcontacto;
	begin
		clrBx; { Limpiamos }
		centerText(2,#205+'Editar Contacto'+#205); { Titulo centrado }
		{ Mover }
		textcolor(10); { Verde }
		gotoxy(54,2);
		write('[Mover con las felchas]');
		{ Salir }
		gotoxy(4,2);
		textcolor(12); { Rojo }
		write('[Esc Para Salir]');
		{ Borde superior de la tabla }
		textcolor(15); { Blanco }
		gotoxy(4,4);
		write(#218+#196+#196+#196+#196#196+#196+#196+#196+#196+#196+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#196+#194+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#196+#196+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#191);
		{ THEAD }
		textbackground(4); { Rojo }
		gotoxy(4,5);
		write(#179+'         Nombre         '+#179);
		gotoxy(4,7);
		write(#179+'        Telefono        '+#179);
		gotoxy(4,9);
		write(#179+'        Direccion       '+#179);
		gotoxy(4,11);
		write(#179+'         Estado         '+#179);
		gotoxy(4,13);
		write(#179+'                                Guardar                                '+#179);
		{ Dibujamos la tabla }
		textbackground(0); { Negro }
		gotoxy(76,5);
		write(#179);
		gotoxy(76,7);
		write(#179);
		gotoxy(76,9);
		write(#179);
		gotoxy(76,11);
		write(#179);
		gotoxy(4,6);
		write(#195+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#197+#196+#196+#196++#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#180);
		gotoxy(4,8);
		write(#195+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#197+#196+#196+#196++#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#180);
		gotoxy(4,10);
		write(#195+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#197+#196+#196+#196++#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#180);
		gotoxy(4,12);
		write(#195+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196++#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#180);
		gotoxy(4,14);
		write(#192+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#196+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#196+#196+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#217);
		{ Leemos el pos-esimo contacto }
		LeeReg(Fagenda,pos,Rcontact);
		nombre := Rcontact.nombre;
		domicilio := Rcontact.domicilio;
		telefono := intToStr(Rcontact.telefono);
		estado := Rcontact.estado;
		{ Nombre }
		gotoxy(31,5);
		write(Rcontact.nombre);
		{ Telefono }
		gotoxy(31,7);
		write(Rcontact.telefono);
		{ Domicilio }
		gotoxy(31,9);
		write(Rcontact.domicilio);
		if Rcontact.estado = False then { Nos fijamos en que estadp esta }
		begin { Inactivo }
			textbackground(4); { Rojo }
			gotoxy(31,11);
			write('      Inactivo      ');
			textbackground(0); { Negro }
			gotoxy(53,11);
			write('       Activo       ');
		end
		else
		begin { Activo }
			textbackground(10); { Verde }
			gotoxy(53,11);
			write('       Activo       ');
			textbackground(0);
			gotoxy(31,11);
			write('      Inactivo      ');
		end;
		i := 0; { Por defecto tiene el foco el primer campo }
		select(i);
		repeat
			rk := readkey;
			case rk of
			#0 :
			Begin
				rk:= ReadKey;
				Case rk Of
				#72 : {Arriba} 
				begin
					if i > 0 then
					begin
						deSelect(i); { Quitamos el foco al anterior }
						i:= i-1;
						select(i); { Hacemos foco en el nuevo menu }
					end;
				end;
				#80 : {Abajo} 
				begin
					if i < 4 then
					begin
						deSelect(i); { Quitamos el foco al anterior }
						i:= i+1;
						select(i); { Hacemos foco en el nuevo menu }
					end;
				end;
			// #75 : WriteLn('Left'); {Izquierda}
			// #77 : WriteLn('Right'); {Derecha}
			End;
			End; { #FANAES# es el end del case of ? }
			#13 : { Enter }
			begin
				if i = 0 then { Nombre }
				begin
					gotoxy(31,5);
					write('                                ');
					gotoxy(31,5);
					readln(nombre);
				end;
				if i = 1 then { Telefono }
				begin
					gotoxy(31,7);
					write('                                ');
					gotoxy(31,7);
					readln(telefono);
				end;
				if i = 2 then { Domicilio } 
				begin
					gotoxy(31,9);
					write('                                ');
					gotoxy(31,9);
					readln(domicilio);
				end;
				if i = 3 then { Estado }
				begin
					while rk <> #27 do
					begin
						rk := readkey;
						if rk <> #27 then
						begin
							if estado = True then
							begin
								textbackground(4); { Rojo }
								gotoxy(31,11);
								write('      Inactivo      ');
								textbackground(0); { Negro }
								gotoxy(53,11);
								write('       Activo       ');
            					estado := False;
			    			end
			    			else
			    			begin
								textbackground(10); { Verde }
								gotoxy(53,11);
								write('       Activo       ');
								textbackground(0); { Negro }
								gotoxy(31,11);
								write('      Inactivo      ');
             					estado := True;
							end;
						end;
					end;
					rk := #0;
				end;
				if i = 4 then { Enviar }
				begin
					{ Guardamos los nuevos campos del contacto }
					contacto.nombre:= upcase(nombre);
					contacto.telefono:= StrToInt(telefono);
					contacto.domicilio:= upcase(domicilio);
					contacto.estado:= estado; { Por defecto el estado es True }
					GuardaReg(Fagenda,pos, contacto); { Guardamos el contacto en .dat }
					{ Vaciamos los arboles para ingresar el nuevo contacto modificado }
					A_nom := nil;
					A_tel := nil;
					A_dom := nil;
					loadTrees(); { Cargamos de nuevo los arboles }
					rk := #27; { Salir }
				end;
			end;
		end;
		until rk = #27 {Escale salir}
	end;
	procedure listRegister(kTree: Ttree; asked:string);
	begin
		textbackground(0); { Negro }
		if rk = '' then
		begin
			if i < 9 then
			begin
				if pos(asked, Ktree^.key) = 1 then
				begin
					LeeReg(Fagenda,KTree^.position,Rcontact);
					BarTable2(5+i*2);
					if Rcontact.estado = False then
						textbackground(4); { Rojo }
					gotoxy(4,6+i*2);
					write(#179+'        '+#179+'               '+#179+'                      '+#179+'                       '+#179);
					{ ID }
					gotoxy(6,6+i*2);
					write(Ktree^.position);
					{ Telefono }
					gotoxy(15,6+i*2);
					write(Rcontact.telefono);
					{ Nombre }
					gotoxy(31,6+i*2);
					write(Rcontact.nombre);
					{ Domicilio }
					gotoxy(54,6+i*2);
					write(Rcontact.domicilio);
					i:= i + 1;
					textbackground(0);
				end;
			end
			else
			begin
				gotoxy(53,2);
				readln(rk);
				if rk = '' then
				begin
					i := 0;
					clrTable2; { Limpiamos la tabla }
				end
				else
				begin
					if rk <> '0' then
					begin
						EditContact(StrToInt(rk)); { Recargamos el procedure }
						{LeeReg(Fagenda,StrToInt(rk),Rcontact);
						if Rcontact.estado = True then
							Rcontact.estado := False
						else
							Rcontact.estado := True;
						guardareg(Fagenda,StrToInt(rk),Rcontact);}
					end;
				end;
			end;
			if i = 8 then { Si llenamos la tabla dibujamos el bordo inferior del mismo }
			begin
				gotoxy(4,23);
				write(#192+#196+#196+#196+#196+#196+#196+#196+#196+#193+#196+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#196+#193+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#193+#196+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#217);
			end;
		end;
	end;
	procedure listT(kTree: Ttree; asked:string);
	begin
		if (KTree <> nil) and (rk = '') then
		begin
			listT(KTree^.slt, asked); { Sub-arbol Izquierdo }
			listRegister(KTree, asked); { Nodo actual }
			listT(KTree^.srt, asked); { Sub-arbol Derecho }
		end;
	end;
begin
	i := 0;
	j := 0;
	while j < 9 do
	begin
		BarTable2(5+j*2);
		gotoxy(4,6+j*2);
		write(#179+'        '+#179+'               '+#179+'                      '+#179+'                       '+#179);
		j:= j + 1;
	end;
	gotoxy(4,23);
	write(#192+#196+#196+#196+#196+#196+#196+#196+#196+#193+#196+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#196+#193+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#193+#196+#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196#196+#196+#196+#196+#196#196+#196+#196+#196+#217);
	ListT(A_nom, asked);
	if (i <> 8) and (rk <> '0') then { Si la tabla no esta llena y se quiere seguir }
	begin
		gotoxy(53,2);
		readln(rk);
		if rk <> '' then
			EditContact(StrToInt(rk));
		{LeeReg(Fagenda,StrToInt(rk),Rcontact);
		if Rcontact.estado = True then
			Rcontact.estado := False
		else
			Rcontact.estado := True;
		guardareg(Fagenda,StrToInt(rk),Rcontact);}
	end;
end;

procedure border(x1,y1,x2,y2:byte); { Dibuja cuadrado con borde doble sin modificar el contenido }
var
	i: byte;
begin	 
	{ Esquinas }
	print(x1,y1,#201); { ╔ }
	print(x1,y2,#200); { ╚ }
	print(x2,y1,#187); { ╗ }
	print(x2,y2,#188); { ╝ }
	{ Bordes Sup e Inf }
	for i:=(x1 + 1) to (x2 - 1) do
	begin 
		print(i,y1,#205); { ═ }
		print(i,y2,#205); { ═ }
	end;
	{ Bordes laterales }
	for i:=(y1 + 1) to (y2 - 1) do
	begin
		print(x1,i,#186); { ║ }
		print(x2,i,#186); { ║ }
	end;
end;

procedure centerText(y: byte; str: string); { Centra un texto en cierta altura }
var
	i: Integer;
begin
	i:= 40 - (length(str) div 2); { Posicion para que el Texto quede centrado }
	gotoxy(i,y);
	write(str);
end;

procedure FocusMenu(e:byte); { e: Elemento que obtendra el foco }
var
	i: byte;
	str : string;
begin
	case e of
		0: str := '';
		1: str := 'Ver contactos';
		2: str := 'Agregar Contacto';
		3: str := 'Modificar Contacto';
		4: str := 'Salir';
	end;
	textcolor(15); { Blanco }
	textbackground(4); { Rojo }
	{ Pintamos el fondo }
	for i := 3 to 77 do
	begin
		print(i,e*5,' ');
		print(i,e*5+1,' ');
		print(i,e*5 +2,' ');
	end;
	{ Generamos los bordes }
	border(2,e*5-1,78,e*5+3);
	centerText(e*5+1, str);
	{ Volvemos a los valores por defecto }
	textcolor(15); { Blanco }
	textbackground(0); { Negro }
end;

procedure unFocusMenu(e:byte); { e: Elemento que se le quitara el foco }
var
	i: byte;
	str : string;
begin
	case e of
		1: str := 'Ver contactos';
		2: str := 'Agregar Contacto';
		3: str := 'Eliminar Contacto';
		4: str := 'Salir';
	end;
	textcolor(15); { Blanco }
	textbackground(0); { Negro }
	{ Pintamos el fondo }
	for i := 3 to 77 do
	begin
		print(i,e*5,' ');
		print(i,e*5+1,' ');
		print(i,e*5 +2,' ');
	end;
	{ Generamos los bordes }
	border(2,e*5-1,78,e*5+3);
	centerText(e*5+1, str);
end;

procedure print(x,y: byte; str: string);
begin
	gotoxy(x,y);
	write(str);
end;

procedure clrTable;
	var i: byte;
begin
	i:= 0;
	while i < 9 do
	begin
		gotoxy(6,6+i*2);
		write('					  ');
		gotoxy(30,6+i*2);
		write('					  ');
		gotoxy(54,6+i*2);
		write('					  ');
		i:= i+1;
	end;
end;

procedure clrBx;
	var i:byte;
begin
	i:= 2;
	while i < 24 do
	begin
		gotoxy(2,i);
		write('																		   ');
		i:=i+1;
	end;
	gotoxy(21,2);
	write('									 ');
end;

procedure clrTable2;
	var i: byte;
begin
	i:= 0;
	while i < 9 do
	begin
		gotoxy(6,6+i*2);
		write('	   ');
		gotoxy(17,6+i*2);
		write('		   ');
		gotoxy(30,6+i*2);
		write('					 ');
		gotoxy(54,6+i*2);
		write('					 ');
		i:= i+1;
	end;
end;

procedure BarTable(h:byte);
begin
	gotoxy(4,h);
	write(#195+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#197+#196+#196+#196+#196++#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#197+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#180);
end;

procedure BarTable2(h:byte);
begin
	gotoxy(4,h);
	write(#195+#196+#196+#196+#196+#196+#196+#196+#196+#197+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#197+#196+#196+#196++#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#197+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#196+#180);
end;

procedure FocusMenu2(e:byte); { e: Elemento que obtendra el foco }
var
	i: byte;
	str : string;
begin
	case e of
		1: str := 'Ordenar por Nombre';
		2: str := 'Ordenar por Telefono';
		3: str := 'Ordenar por Direccion';
		4: str := 'Buscar por Nombre';
		5: str := 'Buscar por Telefono';
		6: str := 'Buscar por Direccion';
		7: str := 'Atras';
	end;
	textcolor(15); { Blanco }
	textbackground(4); { Rojo }
	{ Pintamos el fondo }
	for i := 3 to 77 do
	begin
		print(i,e*3+2,' ');
	end;
	{ Generamos los bordes }
	border(2,e*3+1,78,e*3+3);
	centerText(e*3+2, str);
	{ Volvemos a los valores por defecto }
	textcolor(15); { Blanco }
	textbackground(0); { Negro }
end;

procedure unFocusMenu2(e:byte); { e: Elemento que se le quitara el foco }
var
	i: byte;
	str : string;
begin
	case e of
		1: str := 'Ordenar por Nombre';
		2: str := 'Ordenar por Telefono';
		3: str := 'Ordenar por Direccion';
		4: str := 'Buscar por Nombre';
		5: str := 'Buscar por Telefono';
		6: str := 'Buscar por Direccion';
		7: str := 'Atras';
	end;
	textcolor(15); { Blanco }
	textbackground(0); { Negro }
	{ Pintamos el fondo }
	for i := 3 to 77 do
	begin
		print(i,e*3+2,' ');
	end;
	{ Generamos los bordes }
	border(2,e*3+1,78,e*3+3);
	centerText(e*3+2, str);
end;

procedure select(i:byte);
begin
	gotoxy(75,5+i*2);
	textbackground(10);
	write(' ');
	gotoxy(75,5+i*2);
	textbackground(0);
end;

procedure deSelect(i:byte);
begin
	gotoxy(75,5+i*2);
	textbackground(0);
	write(' ');
end;
end.
