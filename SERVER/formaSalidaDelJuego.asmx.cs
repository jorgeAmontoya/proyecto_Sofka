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
    public class formaSalidaDelJuego : System.Web.Services.WebService
    {
        [WebMethod]
        public string FormaSalidaJuego(string estado)
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
                     select id from dbo.forma_salida_del_juego where descripcion = '{0}'
                    -------------------------------------------------
                    ", estado), conexion.getConexion());
                    string idFormaSalidaJuego = adapter.SelectCommand.ExecuteScalar().ToString();                  
                
                    result["ESTADO"] = "TRUE";
                    result["MENSAJE"] = "";
                    result["RESULTADO"] = idFormaSalidaJuego;
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
            if (host.Contains("historico"))
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
