using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace SERVER
{   
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    public class opcionesRespuesta:System.Web.Services.WebService
    {
        [WebMethod]
        public string OpcionRespuesta(int idPregunta)
        {
            ConexionSQL conexion = new ConexionSQL();              
            SqlDataAdapter adapter = new SqlDataAdapter();            

            JObject result = new JObject();
            String host = "";

            if ((conexion.openConexion()) == "TRUE")
            {
                try
                {
                    host = HttpContext.Current.Request.Url.LocalPath.ToString();
                   
                    adapter = new SqlDataAdapter(String.Format(@"
                    -------------------------------------------------
                      select letra, descripción, id, respuestacorrecta from opciones_respuesta where Idpregunta = '{0}'
                    -------------------------------------------------
                    ", idPregunta), conexion.getConexion());

                    DataSet opcion = new DataSet();
                    adapter.Fill(opcion);                     // con adapter.fill se ejecuta la consulta y lo guarda en el dataset
                    DataTable opcionRespuestaa = opcion.Tables[0];
                    result["ESTADO"] = "TRUE";
                    result["MENSAJE"] =   host;
                    result["RESULTADO"] = JArray.Parse(JsonConvert.SerializeObject(opcionRespuestaa, Formatting.None));


                }
                catch (Exception e)
                {
                    result["ESTADO"] = "FALSE";
                    result["MENSAJE"] = host + "_" + e.ToString();
                }                                   
            }
            else
            {
                result["ESTADO"] = "FALSE";
                result["MENSAJE"] = "Error en la conexion con base de datos";
            }
            conexion.closeConexion();
            if(host.Contains("pregunta"))
            {
                return result.ToString();
            }
            else
            {
                Context.Response.Output.Write(result);
                //Context.Response.End();
                HttpContext.Current.Response.Flush();
                HttpContext.Current.Response.SuppressContent = true;
                HttpContext.Current.ApplicationInstance.CompleteRequest();

                return result.ToString();
            }
            
        }
    }
}
