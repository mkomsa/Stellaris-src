using Bogus;

namespace Stellaris.Server.Core.News.Models;

public class SpaceNews
{
    public Guid Id { get; set; }
    public string Title { get; set; } = null!;
    public string? PublishDate { get; set; }
    public string Content { get; set; } = null!;
    public string ReadTime { get; set; } = null!;
    public string Category { get; set; } = null!;
    public string ImageUrl { get; set; } = null;

    public static SpaceNews Create(string title, string publishDate, string content, string readTime, string category, string imageUrl)
    {
        return new SpaceNews()
        {
            Id = Guid.NewGuid(),
            Title = title,
            PublishDate = publishDate,
            Content = content,
            ReadTime = readTime,
            Category = category,
            ImageUrl = imageUrl
        };
    }

    public static SpaceNews Create(string title, string content, string? imageUrl, string? category)
    {
        Faker faker = new Faker();

        return new SpaceNews()
        {
            Id = Guid.NewGuid(),
            Title = title,
            Content = content,
            ImageUrl = ValidateImageUrl(imageUrl)
                ? imageUrl
                : faker.Image.PicsumUrl(),
            PublishDate = DateTime.Now.ToUniversalTime().ToString(),
            ReadTime = ((content.Length / 5) / 238).ToString(),
            Category = AssignCategory(category)
        };
    }

    public static bool ValidateImageUrl(string imageUrl)
    {
        bool isValid = Uri.TryCreate(imageUrl, UriKind.Absolute, out Uri result);

        return isValid;
    }

    public static string AssignCategory(string? category)
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

        if (!string.IsNullOrEmpty(category) && availableCategories.Contains(category.ToLower()))
        {
            return category;
        }

        Random rand = new Random();
        return availableCategories[rand.Next(availableCategories.Length - 1)];
    }
}
