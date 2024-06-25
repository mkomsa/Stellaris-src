namespace Stellaris.Server.Infrastructure.DAL.Exceptions;

internal class DbAddException : Exception
{
    public DbAddException(string message) : base(message)
    {

    }

    public DbAddException(string message, Exception inner) : base(message)
    {

    }
}
