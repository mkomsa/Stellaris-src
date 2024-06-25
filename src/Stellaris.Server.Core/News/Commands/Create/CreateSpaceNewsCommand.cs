using MediatR;

namespace Stellaris.Server.Core.News.Commands.Create;

public class CreateSpaceNewsCommand : IRequest<Guid>
{
    public string Title { get; set; } = null!;
    public string Content { get; set; } = null!;
    public string? ImageUrl { get; set; }
    public string? Category { get; set; }
}
