using Microsoft.Data.SqlClient;

namespace MultiStore
{
    public static class DatabaseConnectionFactory
    {
        public static SqlConnection CreateConnection(string? database = null)
        {
            var connectionStringBuilder = new SqlConnectionStringBuilder($"Server=localhost;Database=multistore_dw;Trusted_Connection=True;TrustServerCertificate=True");

            if (database != null)
                connectionStringBuilder["Database"] = database;

            return new SqlConnection(connectionStringBuilder.ToString());
        }
    }
}
