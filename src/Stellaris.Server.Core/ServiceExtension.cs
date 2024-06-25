using Microsoft.Extensions.DependencyInjection;
using Stellaris.Server.Core.Common.Helpers;

namespace Stellaris.Server.Core;
public static class ServiceExtension
{
    public static void RegisterCoreServices(this IServiceCollection services)
    {
        services.AddMediatR(
            cfg =>
            {
                cfg.RegisterServicesFromAssembly(typeof(ServiceExtension).Assembly);
            });

        services.AddHttpClient();
        services.AddScoped<ISpaceNewsFaker, SpaceNewsFaker>();
    }
}
