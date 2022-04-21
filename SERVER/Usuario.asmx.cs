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
    public class Usuario : System.Web.Services.WebService
    {
        [WebMethod]        
        public string Registro(string usuario, string correo, string contraseña)
        {         
            ConexionSQL conexion = new ConexionSQL();
            SqlDataAdapter adapter = new SqlDataAdapter();
            string iddatos_usuario = "";
            JObject result = new JObject();
            if ((conexion.openConexion()) == "TRUE")
            {
                try
                {
                    adapter = new SqlDataAdapter(String.Format(@"
                -------------------------------------------------
                declare @exitCorreo int = 
                (
                select count (*) as exist from dbo.datos_usuario where correo = '{1}' 
                )
                if ( @exitCorreo = 1)
                BEGIN
                SELECT 'este correo ya está registrado'
                END

                declare @Usuario int  = 
                (
                select count (*) as exist from dbo.datos_usuario where Usuario = '{0}'
                )
                if ( @Usuario = 1)
                BEGIN
                SELECT 'este usuario ya está registrado'
                END

                if (@Usuario = 0 and @exitCorreo = 0 )
                BEGIN
                insert into dbo.datos_usuario
                (Usuario,Correo,contraseña)
                Values
                ('{0}','{1}', '{2}')
                select @@identity as iddatos_usuario
                END
                -------------------------------------------------
                ", usuario, correo, contraseña), conexion.getConexion());

                    iddatos_usuario = adapter.SelectCommand.ExecuteScalar().ToString();
                    
                    result["ESTADO"] = "TRUE";
                    result["MENSAJE"] = "";
                    result["RESULTADO"] = iddatos_usuario;

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

        [WebMethod]
        public string Ingresar(string usuario, string contraseña)
        {            
            ConexionSQL conexion = new ConexionSQL();               
            SqlDataAdapter adapter = new SqlDataAdapter();           
            string mensaje = "";
            JObject result = new JObject();
            if ((conexion.openConexion()) == "TRUE")
            {
                try
                {
                    adapter = new SqlDataAdapter(String.Format(@"
                    -------------------------------------------------
                          declare @usuariovalida int = (select count(*) as exist from dbo.datos_usuario where Usuario = '{0}')
                            if(@usuariovalida = 0)
                            BEGIN
                            select 'el usuario no está registrado'
                            END
                            ELSE
                            BEGIN
                                declare @exist int = (select count(*) as exist from dbo.datos_usuario where Usuario = '{0}' and contraseña = '{1}')
                            
                                if (@exist = 0 )
                                BEGIN
                                     select @exist as exist
                                END
                                ELSE
                                BEGIN
                                    declare @IdUsuario int = 
                                    (
                                        select Id from dbo.datos_usuario where Usuario = '{0}' and contraseña = '{1}'
                                    )
                                    
                                    insert into dbo.juego (IdUsuario) values (@IdUsuario)
                                    declare @Idjuego int = (select @@identity)
                                    select Usuario, Id, @Idjuego as  Idjuego from dbo.datos_usuario where Usuario = '{0}' and contraseña = '{1}'
                                    
                                END
                            END
                    ----------------------------------------------
                    ", usuario, contraseña), conexion.getConexion());
                    
                    DataSet estadoInicioSesionAux = new DataSet();
                    adapter.Fill(estadoInicioSesionAux);                     // con adapter.fill se ejecuta la consulta y lo guarda en el dataset
                    DataTable estadoInicioSesion = estadoInicioSesionAux.Tables[0];
                    if (estadoInicioSesion.Rows[0][0].ToString() == "0")
                    {

                        mensaje = "Contraseña incorrecta";
                        result["RESULTADO"] = mensaje;
                    }
                    else if (estadoInicioSesion.Rows[0][0].ToString() == "el usuario no está registrado")
                    {
                        mensaje = "el usuario no está registrado";
                        result["RESULTADO"] = mensaje;
                    }
                    else
                    {
                        result["RESULTADO"] = JArray.Parse(JsonConvert.SerializeObject(estadoInicioSesion, Formatting.None));
                    }

                    result["ESTADO"] = "TRUE";
                    result["MENSAJE"] = "";                   
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
