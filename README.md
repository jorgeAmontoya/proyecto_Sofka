# proyecto_Sofka
concurso_preguntas_respuestas

A continuación se describirán los pasos que se deben seguir para configurar la base de datos, 
el backend y el frontend del proyecto.

1) Configuración base de datos
 
Para la administración de la base de datos se usó el gestor de base de datos relacional de 
Microsoft  SQL Server, en su versión Express, el cual es gratuito y permite el almacenamiento 
de datos  completos de manera confiable para sitios web ligeros. 

Partiendo del hecho de que ya se tiene instalado el motor de base de datos SQL Server Express
y un entorno integrado para administrar bases de datos como lo es SQL Server Management Studio. 

En la siguiente url se explica como instalar SQL Server Express y SSMS y como conectarse 
con el usuario administrador de windows.

https://codigosql.top/sql-server/instalar-sql-server-management-studio/


Ya teniendo instalado SQL Server Express y SSMS, se procede a crear la base de datos, el usuario 
con el cual se va a conectar esta base de datos, las tablas con sus respectivas llaves primarias 
y foráneas; y por último el contenido de algunas  tablas maestras. Para esto en el repositorio se 
adjuntan dos Scripts ubicados en la ruta  "~/BaseDatosSqlServer". Los cuales se explicarán a continuación:



1.1 crearUsuarioBaseDatosJorgeAMontoya.sql : Para la ejecución de este Script se debe de iniciar sesión en 
el motor de base de datos con un usuario administrador, el cual nos permitirá crear una base de datos y un 
usuario que se pueda conectar a esta misma.

1.2 creacionDeTablas.sql : Para la ejecución de este Script se inicia sesión con el usuario creado en el 
paso anterior, al ejecutar este Script se crean las tablas necesarias con sus respectivas relaciones y los
datos base en las tablas maestras.

para omitir la instalación y ejecutar los Scripts, se creo la base de datos en un servidor con Ip publica,
al cual se puede conectar desde cualquier equipo con conexion a internet y asi validar el modelo de base 
de datos o crear conexion desde cualquier equipo donde se despliegue la parte server del proyecto. 
Donde las credenciales se encuentran en el Script “crearUsuarioBaseDatosJorgeAMontoya.sql“ que se ejecuto.


2) Configuración Frontend 

En este punto, se realizó el despliegue de la parte Frontend del proyecto, con la ayuda de IIS, el 
cual permite asignar una ruta HTTP y correr en local el proyecto, el sitio en su parte Frontend, 
se realizó con HTML, CSS y JavaScript.

Por lo tanto para desplegar la parte web en local se usará el servidor IIS el cual es una 
característica de windows que se deberá activar, para esto, se realizan los siguientes pasos:

se presiona la tecla windows se escribe  “panel de control”, después se elige la opción 
“programas y características”. 
ver archivo Readme_Instrucciones_Configuraciones_Sofka.pdf para mas información

Una vez se ingrese en “Programas y características”, se selecciona la opción de 
“Activar o desactivar las características de Windows”, y selecciona la opcion para habilitar el IIS.
ver archivo Readme_Instrucciones_Configuraciones_Sofka.pdf para mas información

Una vez se active el IIS, se crea un sitio web en el IIS, dando clic derecho sobre sitios y  luego 
se da clic en agregar sitio web.Al realizar lo anterior se abre una nueva ventana donde se debe 
ingresar la siguiente información, el nombre del sitio, la ruta donde se va a alojar los archivos
 tanto de la parte web como la de server y se asignará un puerto para que pueda ser llamado el 
sitio, en este caso se le asigna el 84 para que pueda ser llamado desde el localHost.
ver archivo Readme_Instrucciones_Configuraciones_Sofka.pdf para mas información



En la carpeta web a la que apunta el IIS, se va a pegar el contenido de la carpeta WEB que se 
encuentra en el repositorio. En el contenido de la carpeta WEB existe un archivo llamado "variables.js"
 que está en la ruta (~/WEB//variables.js),  dónde está configurada la URL que está asociada a la 
aplicación web de ASP .Net de la parte server del proyecto, por defecto está apuntando a la URL 
del servidor público donde se desplegó la base de datos. En caso de querer correr todo en local 
es necesario modificar estas variables. Además hay otro archivo variables.js que se deben modificar, 
este archivo está ubicado en (~ /WEB/vistas/preguntas/variables.js).
ver archivo Readme_Instrucciones_Configuraciones_Sofka.pdf para mas información



3)  Configuración Backend 

En este punto, se realizó el despliegue de la parte Backend del proyecto, con la ayuda de IIS, 
el cual ya fue configurado en el paso 2. El sitio en su parte Backend se realizó creando una 
aplicación web con ASP.NET(.NET Framework) usando servicios web ASMX.

Además de configurar el IIS, hay que activar otra característica de Windows como lo es ASP.NEt 4.8. 
Por lo que se debe presionar la tecla windows se escribe  “panel de control”, después se elige la 
opción “programas y características”, dar clic en la opción de “Activar o desactivar caracteristicas 
de Windows” y se seleccionan las opciones para activar ASP.NEt 4.8.
ver archivo Readme_Instrucciones_Configuraciones_Sofka.pdf para mas información
o tambien se puede consultar la pagina:
"https://www.jesusninoc.com/06/04/crear-un-servicio-web-asp-net-asmx-con-microsoft-visual-studio-publicarlo-en-un-servidor-iis-local-y-despues-utilizarlo-desde-powershell-con-new-webserviceproxy/"
donde ademas de mostrar como activar ASP.NET, se muestra como crear una aplicación web con ASP .Net, 
del cual se tomo como base para realizar esta aplicación


Una vez se activó esta otra característica de Windows y creado un sitio web en el IIS 
el cual apunta a la carpeta web del proyecto, se debe de crear una aplicación para lanzar
la aplicación server. Para esto, se debe dar clic derecho al sitio web creado y se elige 
la opción de crear aplicación, luego se abre una ventana donde en Alias se puso el nombre de 
SERVER y la ruta de acceso físico apunta  a la carpeta server en donde estará alojado el compilado 
la aplicación ASP .NET.
ver archivo Readme_Instrucciones_Configuraciones_Sofka.pdf para mas información

Por otra parte existe una configuración de la cadena de conexión a base de datos en la clase 
ConexionSQL.cs, la cual viene configurada en el proyecto por defecto para conectarse a la base 
de datos que se encuentra en el servidor con Ip pública. En caso de que se quiera cambiar, se debe 
modificar la línea 15 con las credenciales que se necesiten.


Para poder visualizar el código de la parte Backend del proyecto, se debe tener instalado 
preferiblemente Visual Studio, dando clic en el archivo SERVER.sln, donde se abrira todo el proyecto. 
Además para poder publicar el compilado en el IIS, es necesario crear un perfil de publicación.
ver archivo Readme_Instrucciones_Configuraciones_Sofka.pdf para mas información

Todos estos pasos se realizaron en un servidor, por lo que a la aplicación se puede acceder 
y validar su funcionamiento en la siguiente url: 

http://149.56.110.210:84/




