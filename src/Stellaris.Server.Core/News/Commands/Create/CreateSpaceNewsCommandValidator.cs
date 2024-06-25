using FluentValidation;

namespace Stellaris.Server.Core.News.Commands.Create;

internal class CreateSpaceNewsCommandValidator : AbstractValidator<CreateSpaceNewsCommand>
{
    public CreateSpaceNewsCommandValidator()
    {
        ClassLevelCascadeMode = CascadeMode.Stop;
        RuleLevelCascadeMode = CascadeMode.Stop;

        RuleFor(command => command)
            .NotEmpty();

        RuleFor(command => command.Title)
            .MaximumLength(64)
            .NotEmpty();

        RuleFor(command => command.Content)
            .MaximumLength(4096)
            .NotEmpty();

        RuleFor(command => command.ImageUrl)
            .MaximumLength(512)
            .NotEmpty();

        RuleFor(command => command.Category)
            .MaximumLength(24)
            .NotEmpty();

        RuleFor(command => command.Category)
            .Must((value) =>
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

                if (!availableCategories.Contains(value.ToLower()))
                {
                    return false;
                }

                return true;
            })
            .WithMessage("Incorrect category");
    }
}
