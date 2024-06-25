using Stellaris.Server.Api.Middleware.ErrorHandling;

namespace Stellaris.Server.Api.Middleware;

public static class ServiceExtension
{
    public static void RegisterErrorHandlers(this IServiceCollection services)
    {
        services.AddSingleton<ErrorHandlingMiddleware>();
    }
}
