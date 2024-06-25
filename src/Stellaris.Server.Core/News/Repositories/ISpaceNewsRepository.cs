using Stellaris.Server.Core.News.Models;
using Stellaris.Server.Core.News.Queries;

namespace Stellaris.Server.Core.News.Repositories;

public interface ISpaceNewsRepository
{
    Task<Guid> AddSpaceNewsAsync(SpaceNews spaceNews, CancellationToken cancellationToken);
    Task<IReadOnlyCollection<SpaceNews>> GetAll(GetSpaceNewsQuery query, CancellationToken cancellationToken);
}
