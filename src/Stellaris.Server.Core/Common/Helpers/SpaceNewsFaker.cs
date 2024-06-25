using Bogus;
using Stellaris.Server.Core.News.Models;

namespace Stellaris.Server.Core.Common.Helpers;

public interface ISpaceNewsFaker
{
    public string GenerateImage();
    public SpaceNews[] Generate(int count);
}

internal class SpaceNewsFaker : ISpaceNewsFaker
{
    private readonly Faker<SpaceNews> _faker;

    public SpaceNewsFaker()
    {
        string[] availableCategories = new[]
        {
            "science",
            "exploration",
            "tech",
            "environment",
            "colonization",
            "astronomy",
            "culture",
            "education",
        };


        _faker = new Faker<SpaceNews>()
            .RuleFor(n => n.Title, f => f.Lorem.Sentence())
            .RuleFor(n => n.PublishDate, f => f.Date.Past().ToString("yyyy-MM-dd HH:mm"))
            .RuleFor(n => n.Content, f => f.Lorem.Paragraphs(f.Random.Number(3, 8)))
            .RuleFor(n => n.ReadTime, f => f.Random.Number(3, 10).ToString())
            .RuleFor(n => n.ImageUrl, f => f.Image.PicsumUrl())
            .RuleFor(n => n.Category, f => availableCategories[f.Random.Number(availableCategories.Length - 1)]);
    }

    public string GenerateImage()
    {
        Faker faker = new Faker();

        return faker.Image.PicsumUrl();
    }

    public SpaceNews[] Generate(int count)
    {
        return _faker.Generate(count).ToArray();
    }
}
