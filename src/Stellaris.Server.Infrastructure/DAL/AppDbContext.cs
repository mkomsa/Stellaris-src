using Microsoft.EntityFrameworkCore;
using Stellaris.Server.Infrastructure.DAL.Entities;
using System.Reflection;

namespace Stellaris.Server.Infrastructure.DAL;

internal class AppDbContext : DbContext
{
    public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
    {

    }

    public DbSet<SpaceNewsEntity> SpaceNews { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.ApplyConfigurationsFromAssembly(Assembly.GetExecutingAssembly());
    }
}
