using MediatR;
using Stellaris.Server.Core.Common.Helpers;
using Stellaris.Server.Core.News.Models;
using Stellaris.Server.Core.News.Repositories;
using System.Globalization;

namespace Stellaris.Server.Core.News.Queries;

internal class GetSpaceNewsQueryHandler(ISpaceNewsFaker spaceNewsFaker, ISpaceNewsRepository spaceNewsRepository) : IRequestHandler<GetSpaceNewsQuery, IReadOnlyCollection<Models.SpaceNews>>
{

    public async Task<IReadOnlyCollection<Models.SpaceNews>> Handle(GetSpaceNewsQuery query, CancellationToken cancellationToken)
    {

        IReadOnlyCollection<SpaceNews> spaceNews = await spaceNewsRepository.GetAll(query, cancellationToken);

        return spaceNews.OrderByDescending(n => DateTime.Parse(n.PublishDate, CultureInfo.InvariantCulture)).ToArray();
    }
}
