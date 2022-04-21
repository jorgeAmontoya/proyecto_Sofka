$(document).ready(function () {
    
    document.getElementById("btn__registrarse").addEventListener("click",register);

    document.getElementById("btn__iniciar-sesion").addEventListener("click",inisiarSesion);
    window.addEventListener("resize",anchoPagina);
    document.getElementById("Registrarse").addEventListener("click",ObtenerDatosRegistro);
    document.getElementById("Entrar").addEventListener("click",ObtenerDatosInicioSesion);

    anchoPagina();
});


function anchoPagina(){
    if(window.innerWidth >850){
        caja_trasera_login.style.display = "block";
        caja_trasera_register.style.display = "block";
    }
    else
    {
        caja_trasera_register.style.display = "block";
        caja_trasera_register.style.opacity = "1";
        caja_trasera_login.style.display = "none";
        formulario_login.style.display = "block";
        formulario_register.style.display = "none";
        contenedor_login_register.style.left = "0px";
    }
}

function inisiarSesion(){
    if(window.innerWidth > 850)
    {
        
        formulario_register.style.display = "none";
        contenedor_login_register.style.left = "10px";
        formulario_login.style.display = "block";
        caja_trasera_register.style.opacity = "1";
        caja_trasera_login.style.opacity = "0";
    }
    else
    {
        
        formulario_register.style.display = "none";
        contenedor_login_register.style.left = "0px";
        formulario_login.style.display = "block";
        caja_trasera_register.style.display = "block";
        caja_trasera_login.style.display = "none";
    }
    
}
function register(){
    if(window.innerWidth > 850)
    {
        formulario_register.style.display = "block";
        contenedor_login_register.style.left = "410px";
        formulario_login.style.display = "none";
        caja_trasera_register.style.opacity = "0";
        caja_trasera_login.style.opacity = "1";
    }
    else
    {
        formulario_register.style.display = "block";
        contenedor_login_register.style.left = "0px";
        formulario_login.style.display = "none";
        caja_trasera_register.style.display = "none";
        caja_trasera_login.style.display = "block";
        caja_trasera_login.style.opacity = "1";
    }
}

function ObtenerDatosRegistro()
{

    if ($("#nombre_completo").val() != undefined) {
        nombre = $("#nombre_completo").val();
    }

    if ($("#correo").val() != undefined) {
        correo = $("#correo").val();
    }

    if ($("#usuario").val() != undefined) {
        usuario = $("#usuario").val();
    }

    if ($("#contrasena").val() != undefined) {
        contrasena = $("#contrasena").val();
    }


    let datos = {
        usuario:usuario,
        correo:correo,
        contraseña:contrasena
    }
    
    callAjax(primario.urlConexion,
        "Registro",
        datos,
        estadoRegistro        
    );

    
}

function estadoRegistro(RESULTADO)
{
    var c = 0;
    if(RESULTADO != "este usuario ya está registrado" && RESULTADO != "este correo ya está registrado")
    {
        alert("Usuario registrado, inicie sesion");
        inisiarSesion();
    }    
    else
    {
        alert(RESULTADO);

    }
}

function ObtenerDatosInicioSesion()
{
    if ($("#CorreoInicioSesion").val() != undefined) {
        usuario = $("#CorreoInicioSesion").val();
    }

    if ($("#contrasñaInicioSesion").val() != undefined) {
        contrasena = $("#contrasñaInicioSesion").val();
    }
    let datos = {
        usuario:usuario,
        contraseña:contrasena
    }
    
    callAjax(primario.urlConexion,
        "Ingresar",
        datos,
        EstadoInicioSesion       
    );
}

function EstadoInicioSesion(RESULTADO)
{
    if(RESULTADO == "Contraseña incorrecta" || RESULTADO == "el usuario no está registrado")
    {        
        alert(RESULTADO);
    }
    else{
        idJuego = RESULTADO[0].Idjuego;
        idUsuario = RESULTADO[0].Id;
        usuario = RESULTADO[0].Usuario;
        $(".contenedor__todo").empty();
	    $(".contenedor__todo").load("vistas/preguntas/preguntas.html");
        
    }
    

}
