using MediatR;
using Microsoft.AspNetCore.Mvc;
using Stellaris.Server.Core.News.Commands.Create;
using Stellaris.Server.Core.News.Models;
using Stellaris.Server.Core.News.Queries;

namespace Stellaris.Server.Api.Controllers;

[ApiController]
[Route("api/space-news")]
public class SpaceNewsController(IMediator mediator) : ControllerBase
{
    [HttpGet]
    public async Task<IActionResult> GetSpaceNews([FromQuery] GetSpaceNewsQuery query)
    {
        IReadOnlyCollection<SpaceNews> result = await mediator.Send(query);

        return Ok(result);
    }

    [HttpPost]
    public async Task<IActionResult> Create([FromBody] CreateSpaceNewsCommand command)
    {
        var result = await mediator.Send(command);

        return Ok(result);
    }
}
