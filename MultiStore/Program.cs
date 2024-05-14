// See https://aka.ms/new-console-template for more information

using MultiStore;

try
{
    Console.WriteLine("Starting import...");
    App.Run();
}
catch (Exception e)
{
    Console.WriteLine("Process Failed!");
    Console.WriteLine(e);
}

Console.ReadKey();



