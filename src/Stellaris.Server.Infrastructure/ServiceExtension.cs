using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Npgsql;
using Stellaris.Server.Core.News.Repositories;
using Stellaris.Server.Infrastructure.DAL;
using Stellaris.Server.Infrastructure.DAL.Repositories;

namespace Stellaris.Server.Infrastructure;

public static class ServiceExtension
{
    public static void RegisterInfrastructureServices(this IServiceCollection services, IConfiguration configuration)
    {
        string? connectionString = configuration.GetConnectionString("DefaultConnection");
        ArgumentException.ThrowIfNullOrEmpty(connectionString);

        NpgsqlDataSource dataSourceBuilder = new NpgsqlDataSourceBuilder(connectionString)
            .EnableDynamicJson()
            .Build();

        services.AddDbContext<AppDbContext>(options => options.UseNpgsql(dataSourceBuilder));
        services.AddScoped<ISpaceNewsRepository, SpaceNewsRepository>();
    }
}
