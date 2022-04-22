$(document).ready(function () {
    var x = 0;
    
    cargarPregunta();
    $("#CargaUsuario").html(`<p>Nombre: ${usuario}</p>`)
    document.getElementById("btn__retirarse").addEventListener("click",retirarse);
    document.getElementById("btn__siguiente").addEventListener("click",siguiente);
    
});

function estadoCheckbox_b()
{
    $("#b").prop("checked", true);
    $("#a").prop("checked", false);
    $("#c").prop("checked", false);
    $("#d").prop("checked", false);  
}

function estadoCheckbox_c()
{
    $("#c").prop("checked", true);
        $("#a").prop("checked", false);
        $("#b").prop("checked", false);
        $("#d").prop("checked", false);  
}

function estadoCheckbox_d()
{
    $("#d").prop("checked", true);
    $("#a").prop("checked", false);
    $("#b").prop("checked", false);
    $("#c").prop("checked", false);  
}

function estadoCheckbox_a()
{
    $("#a").prop("checked", true);
    $("#b").prop("checked", false);
    $("#c").prop("checked", false);
    $("#d").prop("checked", false);  
}

function cargarPregunta()
{    
    let datos = {
        idNivel:idNivel,
        idjuego:idJuego
    }    
    callAjax(urlConexionPregunta,
        "PreguntaAleatoria",
        datos,
        EstadocargarPregunta       
    );    
}

function EstadocargarPregunta(RESULTADO)
{    
    $("#Pregunta").html("<h3>"+RESULTADO.PREGUNTA[0].pregunta+"</h3>");
    Idpregunta = RESULTADO.PREGUNTA[0].Id;
    var respuestas = "";
    for (let i = 0; i < RESULTADO.OPCIONES.length; i++) {                
        respuestas = respuestas +        
        `
            <div class="box-wrapper" >
                <div class="box" id="opcion_"${RESULTADO.OPCIONES[i].letra}>
                    <div class="checkbox-wrap">
                        <input type="checkbox"  value="${RESULTADO.OPCIONES[i].id}-${RESULTADO.OPCIONES[i].respuestacorrecta}" id="${RESULTADO.OPCIONES[i].letra}" class="form-check-input"
                        onclick="javascript:estadoCheckbox_${RESULTADO.OPCIONES[i].letra}();">
                        <span></span>
                    </div>
                    <label for="${RESULTADO.OPCIONES[i].letra}" class="form-check-label fw-bold">${RESULTADO.OPCIONES[i].descripción}</label>
                </div>    
            </div>    
        `
    }
    $("#opcionesRespuesta").html(respuestas)
    document.getElementById("loader").classList.toggle("loader2");
}


function retirarse()
{

    let datos = {
        idUsuario: parseInt(idUsuario),        
        idNivel:parseInt(idNivel),
        idPregunta:parseInt(Idpregunta),
        idOpcionRespuesta:parseInt("0"),
        estadoFormaSalida:"Voluntario",
        puntosAcumulados: parseInt("0"),
        Idjuego:parseInt(idJuego)
    }    
    document.getElementById("loader").classList.toggle("loader2");
    callAjax(urlConexionhistorico,
        "Historico",
        datos,
        Estadoretirarse      
    );    
}

function Estadoretirarse(RESULTADO)
{
    
    $("#puntosAcumulados").html(`<p>Puntos acumulados:${RESULTADO}</p>`);
    $("#Pregunta").html(`<span></span> <h3> Se ha retirado, su puntuación es de: ${RESULTADO}</h3>`);
    $("#opcionesRespuesta").html("");
    $("#botones").html("");
    document.getElementById("loader").classList.toggle("loader2");
}

function siguiente()
{
    
    var idOpcionRespuestaSeleccionada = "";
    var statusCorrecta = false;
    if($('#a').is(':checked'))
    {
        idOpcionRespuestaSeleccionada = $('#a').val().split("-")[0];
        statusCorrecta = $('#a').val().split("-")[1];
    }
    if($('#b').is(':checked'))
    {
        idOpcionRespuestaSeleccionada = $('#b').val().split("-")[0];
        statusCorrecta = $('#b').val().split("-")[1];
    }
    if($('#c').is(':checked'))
    {
        idOpcionRespuestaSeleccionada = $('#c').val().split("-")[0];
        statusCorrecta = $('#c').val().split("-")[1];
    }
    if($('#d').is(':checked'))
    {
        idOpcionRespuestaSeleccionada = $('#d').val().split("-")[0];
        statusCorrecta = $('#d').val().split("-")[1];
    }


    if(idOpcionRespuestaSeleccionada == "")
    {
        alert("Seleccione una opción");

       
    }
    else if(statusCorrecta == "true")
    {
        numPreguntasCorrectas = numPreguntasCorrectas + 1;
        var estadoGano = "";
        if(numPreguntasCorrectas == 5 && idNivel == 5)
        {
            var estadoGano = "Ganó";
        }
        let datos = {
            idUsuario: parseInt(idUsuario),        
            idNivel:parseInt(idNivel),
            idPregunta:parseInt(Idpregunta),
            idOpcionRespuesta:parseInt(idOpcionRespuestaSeleccionada),
            estadoFormaSalida:estadoGano,
            puntosAcumulados: parseInt(puntosPorNivel),
            Idjuego:parseInt(idJuego)
        } 
        document.getElementById("loader").classList.toggle("loader2");   
        callAjax(urlConexionhistorico,
            "Historico",
            datos,
            estadoSiguiente      
        );
    }
    else
    {
        let datos = {
            idUsuario: parseInt(idUsuario),        
            idNivel:parseInt(idNivel),
            idPregunta:parseInt(Idpregunta),
            idOpcionRespuesta:parseInt(idOpcionRespuestaSeleccionada),
            estadoFormaSalida:"Por Error",
            puntosAcumulados: parseInt(puntosPorNivel),
            Idjuego:parseInt(idJuego)
        }    
        document.getElementById("loader").classList.toggle("loader2");
        callAjax(urlConexionhistorico,
            "Historico",
            datos,
            estadoError     
        );
    }
}

function estadoSiguiente(RESULTADO)
{
    
    if(numPreguntasCorrectas == 5 && idNivel == 5)
    {
        $("#Pregunta").html(`<span></span> <h3> Usted ha respondido todas las preguntas de manera correcta, termino el juego. Ha ganado: ${RESULTADO} Puntos</h3>`);
        $("#opcionesRespuesta").html("");
        $("#botones").html("");
        $("#puntosAcumulados").html(`<p>Puntos acumulados: ${RESULTADO}</p>`);
        $("#numPreguntasCorrectas").html(`<p>Número de preguntas correctas: ${numPreguntasCorrectas}</p>`);
        document.getElementById("loader").classList.toggle("loader2");
    }
    if(numPreguntasCorrectas ==5)
    {
        idNivel = idNivel +1;
        numPreguntasCorrectas = 0;        
        puntosPorNivel = 100000*idNivel;
    }

    if(idNivel <= 5)
    {
        $("#puntosAcumulados").html(`<p>Puntos acumulados: ${RESULTADO}</p>`);
        $("#numNivel").html(`<p>Nivel ${idNivel}</p>`);
        $("#numPreguntasCorrectas").html(`<p>Número de preguntas correctas: ${numPreguntasCorrectas}</p>`);
        document.getElementById("loader").classList.toggle("loader2");
        alert("Respuesta Correcta, pasara a la siguiente pregunta");
        document.getElementById("loader").classList.toggle("loader2");
        cargarPregunta();
    }
}

function estadoError(RESULTADO)
{
    $("#puntosAcumulados").html(`<p>Puntos acumulados:${RESULTADO}</p>`);
    $("#Pregunta").html(`<span></span> <h3>Ha perdido, su puntuación es de: ${RESULTADO}</h3>`);
    $("#opcionesRespuesta").html("");
    $("#botones").html("");
    document.getElementById("loader").classList.toggle("loader2");
}