using MediatR;
using Stellaris.Server.Core.Common.Helpers;
using Stellaris.Server.Core.News.Models;
using Stellaris.Server.Core.News.Repositories;

namespace Stellaris.Server.Core.News.Commands.Create;

internal class CreateSpaceNewsCommandHandler(ISpaceNewsFaker faker, ISpaceNewsRepository spaceNewsRepository) : IRequestHandler<CreateSpaceNewsCommand, Guid>
{
    public async Task<Guid> Handle(CreateSpaceNewsCommand command, CancellationToken cancellationToken)
    {
        SpaceNews spaceNews = SpaceNews.Create(command.Title, command.Content, command.ImageUrl, command.Category);

        Guid result = await spaceNewsRepository.AddSpaceNewsAsync(spaceNews, cancellationToken);

        return result;
    }
}
