using Microsoft.Data.SqlClient;
using System.Data;

namespace MultiStore
{
    internal class SqlHelper
    {
        public static void ExecuteCommandFromSqlFile(string fileDirectory, string scriptName, bool useDefaultDatabase = false)
        {
            string scriptCommand = File.ReadAllText(Path.Combine(fileDirectory, $"{scriptName}.sql"));

            using var sqlConnection = DatabaseConnectionFactory.CreateConnection(useDefaultDatabase ? null : "master");
            sqlConnection.Open();

            using var sqlCommand = new SqlCommand(scriptCommand, sqlConnection);
            sqlCommand.ExecuteNonQuery();
        }

        public static void SqlBulkCopy(DataTable dt)
        {

            using var sqlConnection = DatabaseConnectionFactory.CreateConnection();
            using var sqlBulkCopy = new SqlBulkCopy(sqlConnection);

            sqlBulkCopy.DestinationTableName = "stage.MultiStore";

            foreach (DataColumn column in dt.Columns)
            {
                var name = column.ColumnName.Trim().Replace("-", " ");

                var sqlColumnName = name.Split(' ')
                    .Select(word =>
                    {
                        return string.Concat(word[0].ToString().ToUpper(), word.ToLower().AsSpan(1));
                    })
                    .Aggregate((a, b) => $"{a}{b}");

                sqlBulkCopy.ColumnMappings.Add(column.ColumnName, sqlColumnName);
            }

            sqlConnection.Open();
            sqlBulkCopy.WriteToServer(dt);
        }
    }
}
