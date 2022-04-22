$(document).ready(function () {
    
    document.getElementById("btn__registrarse").addEventListener("click",register);

    document.getElementById("btn__iniciar-sesion").addEventListener("click",inisiarSesion);
    window.addEventListener("resize",anchoPagina);
    document.getElementById("Registrarse").addEventListener("click",ObtenerDatosRegistro);
    document.getElementById("Entrar").addEventListener("click",ObtenerDatosInicioSesion);

    anchoPagina();

    document.getElementById("loader").classList.toggle("loader2");
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
    var validacion = 0;
    

    if ($("#correo").val() != undefined && $("#correo").val().trim() != '') {
        correo = $("#correo").val();
    }
    else
    {
        validacion = 1;
    }

    if ($("#usuario").val() != undefined && $("#usuario").val().trim() != '') {
        usuario = $("#usuario").val();
    }
    else
    {
        validacion = 1;
    }
    if ($("#contrasena").val() != undefined && $("#contrasena").val().trim() != '') {
        contrasena = $("#contrasena").val();
    }
    else
    {
        validacion = 1;
    }

    if(validacion == 1)
    {
        alert("Llenar todos los campos");
    }
    else
    {
        
        document.getElementById("loader").classList.toggle("loader2");
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
    
}

function estadoRegistro(RESULTADO)
{
    var c = 0;
    if(RESULTADO != "este usuario ya está registrado" && RESULTADO != "este correo ya está registrado")
    {
        document.getElementById("loader").classList.toggle("loader2");
        alert("Usuario registrado, inicie sesion");
        inisiarSesion();
    }    
    else
    {
        document.getElementById("loader").classList.toggle("loader2");
        alert(RESULTADO);

    }
    
}

function ObtenerDatosInicioSesion()
{
    var validacion = 0;
    if ($("#CorreoInicioSesion").val() != undefined && $("#CorreoInicioSesion").val().trim() != '') {
        usuario = $("#CorreoInicioSesion").val();
    }
    else
    {
        validacion = 1;
    }

    if ($("#contrasñaInicioSesion").val() != undefined && $("#contrasñaInicioSesion").val().trim() != '') {
        contrasena = $("#contrasñaInicioSesion").val();
    }
    else
    {
        validacion = 1;
    }

    if(validacion == 1)
    {
        alert("Llenar todos los campos");
    }
    else
    {
        document.getElementById("loader").classList.toggle("loader2");
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
}

function EstadoInicioSesion(RESULTADO)
{
    
    if(RESULTADO == "Contraseña incorrecta" || RESULTADO == "el usuario no está registrado")
    {        
        document.getElementById("loader").classList.toggle("loader2");
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
