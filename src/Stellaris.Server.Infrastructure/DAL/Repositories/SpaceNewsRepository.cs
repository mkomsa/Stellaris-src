using Microsoft.EntityFrameworkCore;
using Stellaris.Server.Core.Common.Helpers;
using Stellaris.Server.Core.News.Models;
using Stellaris.Server.Core.News.Queries;
using Stellaris.Server.Core.News.Repositories;
using Stellaris.Server.Infrastructure.DAL.Entities;
using Stellaris.Server.Infrastructure.DAL.Exceptions;
using System.Globalization;

namespace Stellaris.Server.Infrastructure.DAL.Repositories;

internal class SpaceNewsRepository(ISpaceNewsFaker spaceNewsFaker, AppDbContext dbContext) : ISpaceNewsRepository
{
    public async Task<Guid> AddSpaceNewsAsync(SpaceNews spaceNews, CancellationToken cancellationToken)
    {
        try
        {
            SpaceNewsEntity spaceNewsEntity = SpaceNewsEntity.FromSpaceNews(spaceNews);
            await dbContext.SpaceNews.AddAsync(spaceNewsEntity, cancellationToken);
            await dbContext.SaveChangesAsync(cancellationToken);

            return spaceNewsEntity.Id;
        }
        catch (DbUpdateException ex)
        {
            throw new DbAddException("SpaceNews insert failed.", ex);
        }
    }

    public async Task<IReadOnlyCollection<SpaceNews>> GetAll(GetSpaceNewsQuery query, CancellationToken cancellationToken)
    {
        Random rand = new Random();
        SpaceNews[] fakeNews = spaceNewsFaker.Generate(rand.Next(5, 12));

        fakeNews = fakeNews
            .Where(e => query.Title == null || e.Title.ToLower().Contains(query.Title.ToLower()))
            .Where(e => query.ReadTime == null || int.Parse(e.ReadTime) >= int.Parse(query.ReadTime))
            .ToArray();

        IQueryable<SpaceNewsEntity> baseQuery = dbContext.SpaceNews
            .Where(e => query.Title == null || e.Title.ToLower().Contains(query.Title.ToLower()))
            .Where(e => query.ReadTime == null || int.Parse(e.ReadTime) >= int.Parse(query.ReadTime));


        SpaceNewsEntity[] spaceNews = await baseQuery
            .AsNoTracking()
            .ToArrayAsync(cancellationToken);

        if (query.PublishDate != null)
        {
            DateTime queryDate = DateTime.Parse(query.PublishDate, CultureInfo.InvariantCulture).Date;

            spaceNews = spaceNews
                .Where(e => DateTime.Parse(e.PublishDate, CultureInfo.InvariantCulture).Date >= queryDate)
                .ToArray();

            fakeNews = fakeNews
                .Where(news => DateTime.Parse(news.PublishDate, CultureInfo.InvariantCulture).Date >= queryDate).ToArray();
        }

        List<SpaceNews> result = spaceNews.Select(e => e.ToSpaceNews()).ToList();
        result.AddRange(fakeNews);

        return result;
    }
}
