using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

namespace SERVER
{
    public class ConexionSQL
    {
        SqlConnection conexion;

        public ConexionSQL()
        {          
            conexion = new SqlConnection("Server=149.56.110.210;Database=preguntas_respuestas; User ID=JorgeAMontoya;Password=3113229014");
        }


        public string openConexion()
        {
            try
            {
                if (conexion.State != ConnectionState.Open)
                {
                    conexion.Open();
                    //Apertura de conexión
                    return "TRUE";
                }
                else
                {
                    //Conexión ya abierta
                    return "TRUE";
                }
            }
            catch (SqlException ex)
            {
                //Error de conexión a base de datos
                return ex.ToString();
            }
        }

        public void closeConexion()
        {
            if (conexion.State == ConnectionState.Open)
                conexion.Close();
            //Limpieza de las conexiones abandonadas y que se mantienen abiertas
            SqlConnection.ClearPool(conexion);
        }

        public SqlConnection getConexion()
        {
            //Retorna el objeto conexión actualmente disponible
            return this.conexion;
        }
    }
}