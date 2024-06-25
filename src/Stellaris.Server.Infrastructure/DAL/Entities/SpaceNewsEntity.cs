using Stellaris.Server.Core.News.Models;

namespace Stellaris.Server.Infrastructure.DAL.Entities;

internal class SpaceNewsEntity
{
    public Guid Id { get; set; }
    public string Title { get; set; } = null!;
    public string? PublishDate { get; set; }
    public string Content { get; set; } = null!;
    public string ReadTime { get; set; } = null!;
    public string Category { get; set; } = null!;
    public string ImageUrl { get; set; } = null;

    public static SpaceNewsEntity FromSpaceNews(SpaceNews spaceNews)
    {
        return new SpaceNewsEntity()
        {
            Id = spaceNews.Id,
            Title = spaceNews.Title,
            PublishDate = spaceNews.PublishDate,
            Content = spaceNews.Content,
            ReadTime = spaceNews.ReadTime,
            ImageUrl = spaceNews.ImageUrl,
            Category = spaceNews.Category,
        };
    }

    public SpaceNews ToSpaceNews()
    {
        return new SpaceNews()
        {
            Id = Id,
            Title = Title,
            PublishDate = PublishDate,
            Content = Content,
            ImageUrl = ImageUrl,
            ReadTime = ReadTime,
            Category = Category,
        };
    }
}
