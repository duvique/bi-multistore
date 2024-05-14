using System.Data.OleDb;
using System.Data;
using System.Reflection;

namespace MultiStore
{
    internal static class App
    {
        public static void Run()
        {
            var excelFileName = "stage_MultiStore";
            var excelFileExtension = "xlsx";

            var excelFullFileName = $"{excelFileName}.{excelFileExtension}";

            var excelFolder = new DirectoryInfo(Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location));
            string? sheetFullPath = null;

            Console.WriteLine($"Executing Assembly path: ${excelFolder.FullName}");

            while (excelFolder != null)
            {
                if (excelFolder.GetFiles(excelFullFileName).Any())
                {
                    sheetFullPath = excelFolder.FullName;
                    break;
                }

                excelFolder = excelFolder?.Parent;
            }

            if (sheetFullPath is null)
                throw new Exception($"The file [{excelFullFileName}] was not found");


            var filePath = Path.Combine(sheetFullPath, excelFullFileName);

            var excelConnString = $"Provider=Microsoft.ACE.OLEDB.12.0;Data Source={filePath};Extended Properties='Excel 8.0;HDR=YES'";

            using var oleDbConnection = new OleDbConnection(excelConnString);
            oleDbConnection.Open();


            var tableInfo = oleDbConnection.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);

            var tableName = tableInfo?.Rows[0]["TABLE_NAME"]?.ToString();
            if (tableName is null)
                throw new ArgumentException("Name of table not defined");

            var dtExcel = new DataTable();


            var querySelectExcelData = $"SELECT * FROM [{tableName}]";

            using var oleDbDataAdapter = new OleDbDataAdapter(querySelectExcelData, oleDbConnection);
            oleDbDataAdapter.Fill(dtExcel);

            oleDbConnection.Close();

            var scriptsFolder = excelFolder?.GetDirectories().Where(d => d?.Name.ToLowerInvariant() == "scripts")
                .FirstOrDefault();

            if (scriptsFolder is null)
                throw new Exception("'Scripts' folder not found, it should be at the same folder of Excel sheets");

            // Drop database if exists;
            SqlHelper.ExecuteCommandFromSqlFile(scriptsFolder.FullName, "drop_database");
            // Create Database
            SqlHelper.ExecuteCommandFromSqlFile(scriptsFolder.FullName, "setup_database");
            // Create Schema
            SqlHelper.ExecuteCommandFromSqlFile(scriptsFolder.FullName, "create_schema", true);
            // Create Tables
            SqlHelper.ExecuteCommandFromSqlFile(scriptsFolder.FullName, "create_tables");
            // Bulk copy excel -> sql
            SqlHelper.SqlBulkCopy(dtExcel);

            var processedFilesFolder = "arquivos_processados";

            Directory.CreateDirectory(Path.Combine(excelFolder!.FullName, processedFilesFolder));

            var fullOriginalFilePath = Path.Combine(excelFolder!.FullName, excelFullFileName);
            var fullFileProcessedPath = Path.Combine(excelFolder!.FullName, processedFilesFolder, $"{excelFileName}_processed_at_{DateTime.Now.ToString().Replace("/", "-").Replace(":", "-")}.{excelFileExtension}");
            File.Move(fullOriginalFilePath, fullFileProcessedPath);

            Console.WriteLine($"Process finished sucssesfully - {DateTime.Now}");
        }
    }
}
