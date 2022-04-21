var utilidades = new Object();

// Funcion para obtener datos de la base de datos
callAjax = function (urlConexion, metodo, data, successEvent, objDT, urlExterna) {
    
    $.ajax({
        url: urlConexion + "/" + metodo,
        type: 'POST',
        dataType: 'json',
        async: true,
        data: data,
        error: function (objeto1, objeto2, objeto3) {

            if (urlExterna == undefined) {
                utilidades.errorEvent(objeto1);
            }
            else {
                if (objeto1.status == 0) {
                    utilidades.urlExterna();
                }
                else {
                    utilidades.errorEvent(objeto1);
                }
            }
        },
        timeout: 600000,
        success: function (data) {
            if (data.ESTADO == "TRUE" && objDT == undefined) {
                successEvent(data.RESULTADO);
            }
            else if (data.ESTADO == "TRUE") {
                successEvent(data.RESULTADO, objDT);
            } else {
                utilidades.errorEvent();
            }
        }
    });
}

utilidades.urlExterna = function () {
    //url inalcanzable
    utilidades.avisoDeConfirmacion(
        primario.aplicacion,
        "No se pudo conectar con la base de datos ya que no tiene acceso",
        "error",
        "OK",
        "#AB0000",
        function () { }
    );
}

//Funcion de respuesta cuando falla una consulta a la base de datos
utilidades.errorEvent = function (objeto) {

    if (objeto == undefined) {
        utilidades.avisoDeConfirmacion(
            primario.aplicacion,
            "Algo fallo durante la consulta de los datos para el juego.",
            "error",
            "Ok",
            "#f27474",
            function () { }
        );
    }
    else if (objeto.status == 601 || objeto.status == 503) {
        var message = {
            mensaje: "end_session"
        };
        primario.window_source.postMessage(message, primario.window_origin);
    }
    else {
        utilidades.avisoDeConfirmacion(
            primario.aplicacion,
            "Algo fallo durante la consulta de los datos para el juego.",
            "error",
            "Ok",
            "#f27474",
            function () { }
        );
    }
}

utilidades.avisoDeConfirmacion = function (titulo, contenido, tipo, textoBoton, colorBoton, callbackContinuar) {
    /*tipo : warning, error, success, info, question*/
    swal({
        title: titulo,
        text: contenido,
        type: tipo,
        allowOutsideClick: false,
        showCancelButton: false,
        confirmButtonColor: colorBoton,
        confirmButtonText: textoBoton,
    }).then((result) => {
        if (result.value) {
            callbackContinuar();
        }
    });
}

utilidades.avisoTemporal = function (tipo, titulo) {
    swal({
        position: 'center',
        type: tipo,
        title: titulo,
        showConfirmButton: false,
        timer: 1000
    });
}
