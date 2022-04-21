using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace SERVER
{    
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]   
    public class pregunta : opcionesRespuesta
    {
        [WebMethod]
        public string PreguntaAleatoria(string idNivel, string idjuego)
        {
            ConexionSQL conexion = new ConexionSQL();
            SqlDataAdapter adapter = new SqlDataAdapter();
            JObject result = new JObject();
            JObject result_aux = new JObject();
            List<int> listaAleatorio = new List<int>();
            if ((conexion.openConexion()) == "TRUE")
            {

                try
                {
                    adapter = new SqlDataAdapter(String.Format(@"
                        -------------------------------------------------
                        declare @max int=
                         (
                         select max(Id) from dbo.preguntas where Idnivel = '{0}'
                         )
                         declare @min int=
                         (
                         select min(Id) from dbo.preguntas where Idnivel = '{0}'
                         )
                         select   @min as minimo, @max as maximo
                        -------------------------------------------------
                        ", idNivel), conexion.getConexion());
                    DataSet min_max_aux = new DataSet();
                    adapter.Fill(min_max_aux);                     // con adapter.fill se ejecuta la consulta y lo guarda en el dataset
                    DataTable min_max = min_max_aux.Tables[0];
                    string min = min_max.Rows[0][0].ToString();
                    string max = min_max.Rows[0][1].ToString();


                    Random r = new Random();
                    int Naleatorio = r.Next(int.Parse(min), int.Parse(max) + 1);
                    
                    adapter = new SqlDataAdapter(string.Format(@"
                    --------------------------------------
                    select Idpreguntas from dbo.preguntas_vistas where idjuego = '{0}'                                                         
                    ----------------------------------------
                    ", idjuego), conexion.getConexion());

                    DataSet listaIdPreguntas_aux = new DataSet();
                    adapter.Fill(listaIdPreguntas_aux);                     // con adapter.fill se ejecuta la consulta y lo guarda en el dataset
                    DataTable listaIdPreguntas = listaIdPreguntas_aux.Tables[0];
                    listaAleatorio = (from row in listaIdPreguntas.AsEnumerable() select int.Parse(row["Idpreguntas"].ToString())).ToList();
                     
                    if (listaIdPreguntas.Rows.Count != 0)
                    {
                        while (listaAleatorio.Contains(Naleatorio))
                        {
                            Naleatorio = r.Next(int.Parse(min), int.Parse(max) + 1);
                        }
                    }

                    adapter = new SqlDataAdapter(string.Format(@"
                    --------------------------------------
                     insert into preguntas_vistas
                                                (idpreguntas, Idjuego) 
                                                values 
                                                ('{0}','{1}')     

                    select pregunta, Id from dbo.preguntas where  id = '{0}'                                                         
                    ----------------------------------------
                    ", Naleatorio.ToString(), idjuego), conexion.getConexion());
                    
                    DataSet preguntaAleatoriaAux = new DataSet();
                    adapter.Fill(preguntaAleatoriaAux);                     // con adapter.fill se ejecuta la consulta y lo guarda en el dataset
                    DataTable infoPreguntaAleatoria = preguntaAleatoriaAux.Tables[0];

                    var opciones = OpcionRespuesta(Naleatorio);                   
                    var b = JObject.Parse(opciones);

                    result["ESTADO"] = "TRUE";
                    result["MENSAJE"] = "";
                    result_aux["PREGUNTA"] = JArray.Parse(JsonConvert.SerializeObject(infoPreguntaAleatoria, Formatting.None));

                   result_aux["OPCIONES"]= b["RESULTADO"];

                    result["RESULTADO"] = result_aux;

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
