using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Stellaris.Server.Infrastructure.DAL.Entities;

namespace Stellaris.Server.Infrastructure.DAL.Configurations;

internal class SpaceNewsEntityConfiguration : IEntityTypeConfiguration<SpaceNewsEntity>
{
    public void Configure(EntityTypeBuilder<SpaceNewsEntity> builder)
    {
        SetTableName(builder);
        SetPrimaryKey(builder);
        ConfigureColumns(builder);
    }

    private void SetTableName(EntityTypeBuilder<SpaceNewsEntity> builder)
    {
        builder.ToTable("space_news");
    }

    private void SetPrimaryKey(EntityTypeBuilder<SpaceNewsEntity> builder)
    {
        builder.HasKey(entity => entity.Id);
    }

    private void ConfigureColumns(EntityTypeBuilder<SpaceNewsEntity> builder)
    {
        builder.Property(entity => entity.Title)
            .HasColumnName("title")
            .HasMaxLength(64)
            .IsRequired();

        builder.Property(entity => entity.PublishDate)
            .HasColumnName("publish_date");

        builder.Property(entity => entity.Content)
            .HasColumnName("content")
            .HasMaxLength(4096)
            .IsRequired();

        builder.Property(entity => entity.ReadTime)
            .HasColumnName("read_time")
            .IsRequired();

        builder.Property(entity => entity.ImageUrl)
            .HasColumnName("image_url")
            .IsRequired();

        builder.Property(entity => entity.Category)
            .HasColumnName("category")
            .IsRequired();
    }
}
