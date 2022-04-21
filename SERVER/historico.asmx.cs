using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace SERVER
{
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    public class historico : System.Web.Services.WebService
    {

        [WebMethod]
        public string Historico(int idUsuario, int idNivel, int idPregunta, int idOpcionRespuesta, string estadoFormaSalida, int puntosAcumulados,int  Idjuego)
        {
            ConexionSQL conexion = new ConexionSQL();              
            SqlDataAdapter adapter = new SqlDataAdapter();
            JObject result = new JObject();
            if ((conexion.openConexion()) == "TRUE")
            {
                try
                {
                    string idFormaSalidaJuego = "";
                    if (estadoFormaSalida !=null && estadoFormaSalida !="")
                    {
                        formaSalidaDelJuego ids_formaSalidaDelJuego = new formaSalidaDelJuego();

                        var idFormaSalidaJuego_aux = ids_formaSalidaDelJuego.FormaSalidaJuego(estadoFormaSalida);
                        var b = JObject.Parse(idFormaSalidaJuego_aux);
                        idFormaSalidaJuego = b["RESULTADO"].ToString();
                    }
                    switch (idFormaSalidaJuego)
                    {
                        case "1":
                            adapter = new SqlDataAdapter(String.Format(@"
                            -------------------------------------------------                       
                            insert into dbo.historico 
                            (iddatos_usuario,idnivel,idpreguntas, idopciones_respuesta,idforma_salida_del_juego, 
                            puntos_acumulados, idjuego) 
                            values 
                            ('{0}','{1}', '{2}', '{3}', '{4}', 0, '{6}')    
                            declare @idMaxHistorico int = (select max(id) from dbo.historico where iddatos_usuario = '{0}' and idjuego='{6}')
                            select puntos_acumulados from dbo.historico where  id = @idMaxHistorico
                            -------------------------------------------------
                            ", idUsuario, idNivel, idPregunta, idOpcionRespuesta, idFormaSalidaJuego, puntosAcumulados, Idjuego), conexion.getConexion());
                            puntosAcumulados = int.Parse(adapter.SelectCommand.ExecuteScalar().ToString());
                            break;
                        case "2":
                            adapter = new SqlDataAdapter(String.Format(@"
                            -------------------------------------------------        
                            declare  @idOpcionRespuesta int 
                    
                            if('{3}'='0')
                            BEGIN
                            set @idOpcionRespuesta = null
                            END
                            Else
                            BEGIN
                            set @idOpcionRespuesta = '{3}'
                            END
                            declare @idMax int =
                            (
                                select max(id) from dbo.historico where iddatos_usuario = '{0}'
                                and idJuego = '{6}'
                            )
                            declare  @puntos_acumulados int = 
                            (
                                select puntos_acumulados from dbo.historico
                                where id = @idMax
                            )
                            if(@puntos_acumulados is null)
							begin
								set @puntos_acumulados = 0
							end
                            insert into dbo.historico 
                            (iddatos_usuario,idnivel,idpreguntas, idopciones_respuesta,idforma_salida_del_juego, 
                            puntos_acumulados,Idjuego) 
                            values 
                            ('{0}','{1}', '{2}', @idOpcionRespuesta, '{4}', @puntos_acumulados,'{6}')
                            declare @idMaxHistorico int = (select max(id) from dbo.historico where iddatos_usuario = '{0}' and idjuego='{6}')
                            select puntos_acumulados from dbo.historico where  id = @idMaxHistorico 
                         
                            -------------------------------------------------
                            ", idUsuario, idNivel, idPregunta, idOpcionRespuesta, idFormaSalidaJuego, puntosAcumulados, Idjuego), conexion.getConexion());
                            puntosAcumulados = int.Parse(adapter.SelectCommand.ExecuteScalar().ToString());

                            break;
                        case "3":
                            adapter = new SqlDataAdapter(String.Format(@"
                            -------------------------------------------------        
                            declare @idMax int =
                            (
                                select max(id) from dbo.historico where iddatos_usuario = '{0}'
                                and idJuego = '{6}'
                            )
                            declare  @puntos_acumulados int = 
                            (
                                select puntos_acumulados from dbo.historico
                                where id = @idMax
                            )
                            set @puntos_acumulados = @puntos_acumulados + '{5}'
                            insert into dbo.historico 
                            (iddatos_usuario,idnivel,idpreguntas, idopciones_respuesta,idforma_salida_del_juego, 
                            puntos_acumulados, Idjuego) 
                            values 
                            ('{0}','{1}', '{2}', '{3}', '{4}', @puntos_acumulados, '{6}')      
                            declare @idMaxHistorico int = (select max(id) from dbo.historico where iddatos_usuario = '{0}' and idjuego='{6}')
                            select puntos_acumulados from dbo.historico where  id = @idMaxHistorico                           
                            -------------------------------------------------
                            ", idUsuario, idNivel, idPregunta, idOpcionRespuesta, idFormaSalidaJuego, puntosAcumulados, Idjuego), conexion.getConexion());
                            puntosAcumulados = int.Parse(adapter.SelectCommand.ExecuteScalar().ToString());
                            break;
                        case "":
                            adapter = new SqlDataAdapter(String.Format(@"
                            -------------------------------------------------   
                            declare  @idforma_salida_del_juego int 
                    
                            if('{4}'='')
                            BEGIN
                            set @idforma_salida_del_juego = null
                            END
                            Else
                            BEGIN
                            set @idforma_salida_del_juego = '{4}'
                            END

                            declare @idMax int =
                            (
                                select max(id) from dbo.historico where iddatos_usuario = '{0}'
                                and idJuego = '{6}'
                            )
                            declare  @puntos_acumulados int = 
                            (
                                select puntos_acumulados from dbo.historico
                                where id = @idMax
                            )
                            if (@puntos_acumulados is null)
							BEGIN
							    set @puntos_acumulados = '{5}'
							END
							else
							BEGIN
							    set @puntos_acumulados = @puntos_acumulados + '{5}'
							END

                            insert into dbo.historico 
                            (iddatos_usuario,idnivel,idpreguntas, idopciones_respuesta,idforma_salida_del_juego, 
                            puntos_acumulados,Idjuego) 
                            values 
                            ('{0}','{1}', '{2}', '{3}', @idforma_salida_del_juego, @puntos_acumulados, '{6}') 
    
                            declare @idMaxHistorico int = (select max(id) from dbo.historico where iddatos_usuario = '{0}' and idjuego='{6}')
				            select puntos_acumulados from dbo.historico where  id = @idMaxHistorico
                            -------------------------------------------------
                            ", idUsuario, idNivel, idPregunta, idOpcionRespuesta, idFormaSalidaJuego, puntosAcumulados, Idjuego), conexion.getConexion());
                            puntosAcumulados = int.Parse(adapter.SelectCommand.ExecuteScalar().ToString());
                        break;                        
                    }                    
                    result["ESTADO"] = "TRUE";
                    result["MENSAJE"] = "";
                    result["RESULTADO"] = puntosAcumulados;
                }
                catch (Exception e)
                {
                    result["ESTADO"] = "FALSE";
                    result["MENSAJE"] = e.ToString();
                }
            }
            else
            {
                result["ESTADO"] = "FALSE";
                result["MENSAJE"] = "Error en la conexion con base de datos";
            }
            conexion.closeConexion();
            Context.Response.Output.Write(result);
            Context.Response.End();
            return result.ToString();
        }
    }
}
