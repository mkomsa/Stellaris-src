﻿using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Stellaris.Server.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class SpaceNewsCategory : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "Category",
                table: "space_news",
                type: "text",
                nullable: false,
                defaultValue: "");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Category",
                table: "space_news");
        }
    }
}
