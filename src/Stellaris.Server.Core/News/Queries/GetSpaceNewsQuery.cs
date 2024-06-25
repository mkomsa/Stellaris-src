using MediatR;

namespace Stellaris.Server.Core.News.Queries;
public class GetSpaceNewsQuery : IRequest<IReadOnlyCollection<Models.SpaceNews>>
{
    public string? Title { get; set; }
    public string? PublishDate { get; set; }
    public string? ReadTime { get; set; }
}
