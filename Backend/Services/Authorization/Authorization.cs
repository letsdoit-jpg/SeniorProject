using System;
using System.Data.SqlClient;

namespace Authorization{
    
    class authorize{
        
        public static string getUserRole(string username)
        {
            SqlConnection conn = new SqlConnection();
            conn.ConnectionString = Environment.GetEnvironmentVariable("MARVELCONNECTIONSTRING");
            conn.Open();
            SqlCommand cmd = new SqlCommand("SELECT role" + " from UserTable " + "WHERE UserTable.role = role", conn);
            cmd.ExecuteNonQuery();
            string role = "";
            role = (string)cmd.ExecuteScalar();
            return role;
        }

        static void Main(string[] args)
        {
            SqlConnection conn = new SqlConnection();
            conn.ConnectionString = Environment.GetEnvironmentVariable("MARVELCONNECTIONSTRING");
            conn.Open();
            string userName = System.Security.Principal.WindowsIdentity.GetCurrent().Name;
            SqlCommand cmd = new SqlCommand("SELECT COUNT(username)" + "FROM UserTable" + "WHERE UserTable.username = userName", conn);
            cmd.ExecuteNonQuery();
            int count = (int)cmd.ExecuteScalar();
            if (count > 0){
                string userRole = getUserRole(userName);
                if (userRole == "Admin"){

                }
                if (userRole == "Student"){
                    
                }
            }
            else{
                Console.WriteLine("Error: Current user is an unauthorized user.");
            }

        }
    }
}
