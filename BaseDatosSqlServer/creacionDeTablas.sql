USE [preguntas_respuestas]
go
create table [dbo].[datos_usuario] 
( 
		[Id][int]Identity(1,1)Not Null,
		[Usuario][nvarchar](max) Not Null,
		[Correo][nvarchar](max),
		[Contrase�a][nvarchar](max) not Null

) 
ALTER TABLE [datos_usuario] ADD CONSTRAINT PK_datos_usuario PRIMARY KEY (id)

go

create table [dbo].[juego]
(
		[Id][int]Identity(1,1)Not Null,
		[IdUsuario][int] Not Null,		
) 
ALTER TABLE [juego] ADD CONSTRAINT PK_juego PRIMARY KEY (id)		
go
Use [preguntas_respuestas]
create table [dbo].[preguntas]
(
		[Id][int]Identity(1,1) Not null,
		[pregunta][nvarchar](max) Not null,
		[Idnivel][int] Not null,
)
ALTER TABLE [preguntas] ADD CONSTRAINT PK_preguntas PRIMARY KEY (id)

go
create table [dbo].[preguntas_vistas]
(
		[Id][int]Identity(1,1)Not Null,
		[Idjuego][int] Not Null,
		[Idpreguntas][int] Not Null,	

		
) 
ALTER TABLE [preguntas_vistas] ADD CONSTRAINT PK_preguntas_vistas PRIMARY KEY (id)




go 
Use [preguntas_respuestas]
create Table [dbo].[nivel]
(
		[Id][int]Identity(1,1) Not null,
		[descripcion][nvarchar](max) not null
)
ALTER TABLE [nivel] ADD CONSTRAINT PK_nivel PRIMARY KEY (id)

go 
use [preguntas_respuestas]
create table [dbo].[opciones_respuesta]
(
		[id][int]identity(1,1)not null,
		[Idpregunta][int] not null ,
		[IDnivel][int] not null,
		[letra][nvarchar](max) not null,
		[descripci�n][nvarchar](max) not null,
		[respuestacorrecta][bit] not null

)

ALTER TABLE [opciones_respuesta] ADD CONSTRAINT PK_opciones_respuesta PRIMARY KEY (id)

go
use[preguntas_respuestas]
create table [dbo].[forma_salida_del_juego]
(
		[id][int]identity(1,1) not null,
		[descripcion][nvarchar](max) not null
)
ALTER TABLE [forma_salida_del_juego] ADD CONSTRAINT PK_forma_salida_del_juego PRIMARY KEY (id)


go 
use[preguntas_respuestas]
create table [dbo].[historico]
(
		[id][int]identity(1,1) not null,
		[iddatos_usuario][int] not null,
		[idnivel][int] not null,
		[idpreguntas][int] not null,
		[idopciones_respuesta][int]  null,
		[idforma_salida_del_juego][int] null,
		[puntos_acumulados][int] not null,
		[idjuego][int] not null,
)
ALTER TABLE [historico] ADD CONSTRAINT PK_historico PRIMARY KEY (id)




go 
-----------------llaves foraneas
ALTER TABLE [dbo].[historico]  WITH CHECK ADD FOREIGN KEY([Iddatos_usuario])
REFERENCES [dbo].[datos_usuario] ([Id])

---ALTER TABLE [dbo].[historico]  WITH CHECK ADD FOREIGN KEY([Idpreguntas])
---REFERENCES [dbo].[preguntas] ([Id])

--ALTER TABLE [dbo].[historico]  WITH CHECK ADD FOREIGN KEY([Idnivel])
---REFERENCES [dbo].[nivel] ([Id])

ALTER TABLE [dbo].[historico]  WITH CHECK ADD FOREIGN KEY([Idopciones_respuesta])
REFERENCES [dbo].[opciones_respuesta] ([Id])


ALTER TABLE [dbo].[historico]  WITH CHECK ADD FOREIGN KEY([Idforma_salida_del_juego])
REFERENCES [dbo].[forma_salida_del_juego] ([Id])

ALTER TABLE [dbo].[opciones_respuesta]  WITH CHECK ADD FOREIGN KEY([Idpregunta])
REFERENCES [dbo].[preguntas] ([Id])

ALTER TABLE [dbo].[preguntas]  WITH CHECK ADD FOREIGN KEY([Idnivel])
REFERENCES [dbo].[nivel] ([Id])




ALTER TABLE [dbo].[preguntas_vistas]  WITH CHECK ADD FOREIGN KEY([Idpreguntas])
REFERENCES [dbo].[preguntas] ([Id])


ALTER TABLE [dbo].[juego]  WITH CHECK ADD FOREIGN KEY([IdUsuario])
REFERENCES [dbo].[datos_usuario] ([Id])

ALTER TABLE [dbo].[preguntas_vistas]  WITH CHECK ADD FOREIGN KEY([Idjuego])
REFERENCES [dbo].[juego] ([Id])

ALTER TABLE [dbo].[historico]  WITH CHECK ADD FOREIGN KEY([idjuego])
REFERENCES [dbo].[juego] ([Id])





go
--select * from dbo.preguntas where Idnivel= 1 and Id = 2
------------- insertar informaci�n de la tabla


set identity_insert [dbo].[nivel] ON
INSERT [dbo].[nivel] (Id, descripcion) values (1,  'Nivel 1')
INSERT [dbo].[nivel] (Id, descripcion) values (2,  'Nivel 2')
INSERT [dbo].[nivel] (Id, descripcion) values (3,  'Nivel 3')
INSERT [dbo].[nivel] (Id, descripcion) values (4,  'Nivel 4')
INSERT [dbo].[nivel] (Id, descripcion) values (5,  'Nivel 5')

set identity_insert [dbo].[nivel] off


go
--truncate table dbo.preguntas
use[preguntas_respuestas]
go
set identity_insert [dbo].[preguntas] on
go
insert [dbo].[preguntas] ([id], [pregunta], [Idnivel]) values (1, '�Qu� son las palabras reservadas?', 1)
insert [dbo].[preguntas] ([id], [pregunta], [Idnivel]) values (2, '�Qu� codificaci�n utiliza solamente 0 y 1? ', 1)
insert [dbo].[preguntas] ([id], [pregunta], [Idnivel]) values (3, '�Qu� es un bit?  ', 1)
insert [dbo].[preguntas] ([id], [pregunta], [Idnivel]) values (4, '�C�al de los siguientes n�meros es de tipo float? ', 1)
insert [dbo].[preguntas] ([id], [pregunta], [Idnivel]) values (5, 'En una variable tipo string se pueden guardar:' , 1)

insert [dbo].[preguntas] ([id], [pregunta], [Idnivel]) values (6, '� Que es un IDE?' , 2)
insert [dbo].[preguntas] ([id], [pregunta], [Idnivel]) values (7, '�Qu� significan las siglas "www"?' , 2)
insert [dbo].[preguntas] ([id], [pregunta], [Idnivel]) values (8, '�Cu�l es la distribuci�n de Linux m�s usada?' , 2)
insert [dbo].[preguntas] ([id], [pregunta], [Idnivel]) values (9, '�Cu�l de las siguientes variables est� escrita correctamente?' , 2)
insert [dbo].[preguntas] ([id], [pregunta], [Idnivel]) values (10,'�Qu� significa CLR?' , 2)

insert [dbo].[preguntas] ([id], [pregunta], [Idnivel]) values (11,'� C�al de las siguientes  variables locales est�n escritas correctamente usando camel Case?' , 3)
insert [dbo].[preguntas] ([id], [pregunta], [Idnivel]) values (12,'�Los operadores  booleanos son aquellos que  devuelven un true o un false, dentro de los operadores Booleanos est� el conectivo l�gico and, este operador devuelve un true si:' , 3)
insert [dbo].[preguntas] ([id], [pregunta], [Idnivel]) values (13,'Si se tiene la siguiente cadena de texto S = �hOlA MunDo� al aplicar el s.lower () , qu� transformaci�n tendr� la cadena de texto:' , 3)
insert [dbo].[preguntas] ([id], [pregunta], [Idnivel]) values (14,'�Para qu� sirven las variables?' , 3)
insert [dbo].[preguntas] ([id], [pregunta], [Idnivel]) values (15,'�Se puede cambiar el valor de una constante?' , 3)

insert [dbo].[preguntas] ([id], [pregunta], [Idnivel]) values (16,'�Qu� bucle usar�as para recorrer una lista de elementos?' , 4)
insert [dbo].[preguntas] ([id], [pregunta], [Idnivel]) values (17,'�Qu� hace el operador ++?' , 4)
insert [dbo].[preguntas] ([id], [pregunta], [Idnivel]) values (18, '�Es obligatorio el uso de else dentro de un condicional If?' , 4)
insert [dbo].[preguntas] ([id], [pregunta], [Idnivel]) values (19, '�Cu�l es la diferencia entre un m�todo y una funci�n?' , 4)
insert [dbo].[preguntas] ([id], [pregunta], [Idnivel]) values (20, '� Qu� se puede entender por lenguaje de programaci�n?' , 4)
insert [dbo].[preguntas] ([id], [pregunta], [Idnivel]) values (21, '�Qu� es una base de datos?' , 5)

insert [dbo].[preguntas] ([id], [pregunta], [Idnivel]) values (22, '�Qu� es un algoritmo?' , 5)
insert [dbo].[preguntas] ([id], [pregunta], [Idnivel]) values (23, '�Que es una variable de bandera?' , 5)
insert [dbo].[preguntas] ([id], [pregunta], [Idnivel]) values (24, '�Cual es la mejor forma de consumir librer�as de terceros?' , 5)
insert [dbo].[preguntas] ([id], [pregunta], [Idnivel]) values (25, 'No sirve Do\ While para iterar sobre una lista de elementos' , 5)
go 
SET IDENTITY_INSERT [dbo].[Preguntas] OFF

go
 set identity_insert [dbo].[opciones_respuesta] on
 go
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (1, 1, 1, 'a' , 'Son las palabras que usamos para definir variables', 0)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (2, 1, 1, 'b' , 'Son las palabras que usa el compilador para transformar el c�digo en c�digo m�quina', 0)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (3, 1, 1, 'c' , 'Son las palabras que no podemos usar; porque tienen un significado especial para el compilador', 1)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (4, 1, 1, 'd' , 'Es la palabra que se reserva en memoria para usarla posteriormente', 0)
													   
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (5, 2,1, 'a' , 'Binario', 1)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (6, 2,1, 'b' , 'jerogl�ficos', 0)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (7, 2,1, 'c' , 'Castellano', 0)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (8, 2,1, 'd' , 'C#', 0)

 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (9,  3, 1, 'a' , 'La unidad m�s peque�a de almacenamiento', 1)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (10, 3, 1, 'b' , 'Unidad de medida de la velocidad del cpu', 0)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (11, 3, 1, 'c' , 'La unidad m�s grande de almacenamiento', 0)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (12, 3, 1, 'd' , 'Es una unidad de medida de longitud', 0)

 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (13, 4, 1, 'a' , '�ocho�', 0)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (14, 4, 1, 'b' , '3/0', 0)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (15, 4, 1, 'c' , '3.6', 1)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (16, 4, 1, 'd' , '2.5X10^41', 0)

 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (17, 5, 1, 'a' , 'cadenas de texto ', 1)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (18, 5, 1, 'b' , 'mapas', 0)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (19, 5, 1, 'c' , 'dibujos', 0)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (20, 5, 1, 'd' , 'diccionarios', 0)

 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (21, 6, 2, 'a' , 'Un entorno de desarrollo integrado', 1)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (22, 6, 2, 'b' , 'Identificador �nico excepcional', 0)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (23, 6, 2, 'c' , 'Significa intellisense DEscription', 0)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (24, 6, 2, 'd' , 'Es un lenguaje de programaci�n', 0)

 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (25, 7, 2, 'a' , 'Windows world  walk', 0)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (26, 7, 2, 'b' , 'World Wide Web', 1)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (27, 7, 2, 'c' , 'Wait war warning', 0)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (28, 7, 2, 'd' , 'Wash water white', 0)

 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (29, 8, 2, 'a' , 'Windows', 0)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (30, 8, 2, 'b' , 'Excel', 0)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (31, 8, 2, 'c' , 'Ubuntu', 1)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (32, 8, 2, 'd' , 'Mac', 0)

 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (33, 9, 2, 'a' , 'string saludoFormal = buenos d�as;', 0)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (34, 9, 2, 'b' , 'string saludoFormal = �buenos� d�as', 0)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (35, 9, 2, 'c' , 'string saludoFormal = buenos �d�as�;', 0)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (36, 9, 2, 'd' , 'string saludoFormal = �buenos d�as�;', 1)

 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (37, 10, 2, 'a' , 'Common Lite Read', 0)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (38, 10, 2, 'b' , 'Common language runtime', 1)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (39, 10, 2, 'c' , 'Common Language read', 0)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (40, 10, 2, 'd' , 'Com�n  la risa', 0)

 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (41, 11, 3, 'a' , 'string ESTOESUNAVARIABLE = �hola�;', 0)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (42, 11, 3, 'b' , 'string EstoEsUnaVariable = �hola�;', 0)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (43, 11, 3, 'c' , 'string estoEsUnaVariable = �hola�;', 1)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (44, 11, 3, 'd' , 'string estoesuna variable = �hola�;', 0)

 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (45, 12, 3, 'a' , 'Si  ambos valores son true ', 1)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (46, 12, 3, 'b' , 'Si ambos valores son false', 0)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (47, 12, 3, 'c' , 'Siempre es true', 0)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (48, 12, 3, 'd' , 'Si un valor es true y el otro es false', 0)

 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (49, 13, 3, 'a' , '�hola mundo�', 1)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (50, 13, 3, 'b' , 'HOLA MUNDO', 0)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (51, 13, 3, 'c' , 'Hola Mundo', 0)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (52, 13, 3, 'd' , 'Hola_mundo', 0)

 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (53, 14, 3, 'a' , 'Para realizar operaciones', 0)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (54, 14, 3, 'b' , 'Para almacenar valores y operar con ellos', 1)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (55, 14, 3, 'c' , 'Para asignar valores que no se pueden modificar en tiempo de ejecuci�n', 0)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (56, 14, 3, 'd' , 'Para variar la informaci�n', 0)

 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (57, 15, 3, 'a' , ' Si se puede pero no es recomendable hacerlo', 0)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (58, 15, 3, 'b' , '  Si', 0)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (59, 15, 3, 'c' , 'No se puede', 1)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (60, 15, 3, 'd' , 'se puede hacer solo cuando la constante sea de tipo entero', 0)

 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (61, 16, 4, 'a' , 'if', 0)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (62, 16, 4, 'b' , 'Switch', 0)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (63, 16, 4, 'c' , 'Diccionario', 0)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (64, 16, 4, 'd' , 'for y foreach ambos sirven', 1)

 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (65, 17, 4, 'a' , 'Ese operador no existe', 0)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (66, 17, 4, 'b' , 'Es el operador de la suma', 0)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (67, 17, 4, 'c' , 'El operador suma 1 a un valor entero asignado', 1)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (68, 17, 4, 'd' , 'El operador resta 2 a un valor entero asignado', 0)

 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (69, 18, 4, 'a' , 'Si', 0)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (70, 18, 4, 'b' , 'No', 1)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (71, 18, 4, 'c' , 'Solo si el condicional If est� dentro de un for', 0)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (72, 18, 4, 'd' , 'Solo es obligatorio si el if est� dentro de un switch', 0)

 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (73, 19, 4, 'a' , 'Un m�todo acepta que se le pasen par�metros y una funci�n no', 0)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (74, 19, 4, 'b' , 'Un m�todo puede devolver o no resultados, una funci�n devuelve siempre resultado', 1)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (75, 19, 4, 'c' , 'Es lo mismo se pueden llamar de ambas formas', 0)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (76, 19, 4, 'd' , 'Una funci�n solo se puede usar en .Net Core', 0)

 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (77, 20, 4, 'a' , 'Una manera de comunicarse con el hardware', 0)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (78, 20, 4, 'b' , 'Una manera definida para escribir instrucciones claras para programar aplicaciones de alto nivel.', 1)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (79, 20, 4, 'c' , 'Lo relacionado con la codificaci�n de p�ginas web y sitios interactivos', 0)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (80, 20, 4, 'd' , 'Una forma de dise�ar c�digo para la m�quina', 0)

 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (81, 21, 5, 'a' , 'Un repositorio de datos', 0)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (82, 21, 5, 'b' , 'Es un servidor que permite persistir informaci�n o datos concretos', 1)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (83, 21, 5, 'c' , 'Es un grupo de datos ef�meros', 0)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (84, 21, 5, 'd' , 'Es una colecci�n de datos o informaci�n concreta', 0)

 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (85, 22, 5, 'a' , 'C�digo fuente', 0)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (86, 22, 5, 'b' , 'Instrucciones l�gicas con un prop�sito espec�fico', 1)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (87, 22, 5, 'c' , 'Una funci�n matem�tica', 0)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (88, 22, 5, 'd' , 'Una estructura programada orientada a una sintaxis', 0)

 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (89, 23, 5, 'a' , 'Es una variable l�gica que se utiliza para conservar el estado (verdadero o falso) de una condici�n, la cual toma valores binarios 1= si y 0 = no', 1)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (90, 23, 5, 'b' , 'Es un tri�ngulo con colores', 0)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (91, 23, 5, 'c' , 'Es un tipo de variable', 0)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (92, 23, 5, 'd' , 'Es una palabra reservada', 0)

 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (93, 24, 5, 'a' , 'Referenciando al proyecto que genera la librer�a', 0)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (94, 24, 5, 'b' , 'Referenciando directamente la librer�a en el proyecto', 0)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (95, 24, 5, 'c' , 'Usando paquetes nuget', 1)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (96, 24, 5, 'd' , 'Instanciando la librer�a', 0)

 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (97, 25, 5, 'a' , 'No es su uso principal, pero s� se puede', 0)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (98,  25, 5, 'b' , 'Si, sirve para eso', 0)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (99, 25, 5, 'c' , 'Si, solo si la expresi�n evaluada siempre sea True', 0)
 insert [dbo].[opciones_respuesta] ([id], [Idpregunta],[IDnivel],[letra], [descripci�n], [respuestacorrecta]) values (100,25, 5, 'd' , 'No, para eso se utilizan el for o el foreach', 1)
go
 set identity_insert [dbo].[opciones_respuesta] off
go

SET IDENTITY_INSERT [dbo].[forma_salida_del_juego] ON 
INSERT [dbo].[forma_salida_del_juego] ([Id], [descripcion]) VALUES (1, 'Por Error')
INSERT [dbo].[forma_salida_del_juego] ([Id], [descripcion]) VALUES (2, 'Voluntario')
INSERT [dbo].[forma_salida_del_juego] ([Id], [descripcion]) VALUES (3, 'Gan�')
SET IDENTITY_INSERT [dbo].[forma_salida_del_juego] Off