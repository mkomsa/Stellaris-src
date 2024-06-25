using MediatR;
using Microsoft.AspNetCore.Mvc;
using Stellaris.Server.Core.WeatherInsight.Models.Weather;
using Stellaris.Server.Core.WeatherInsight.Queries;

namespace Stellaris.Server.Api.Controllers;

[ApiController]
[Route("api/weather-insight")]
public class WeatherInsightController(IMediator mediator) : ControllerBase
{
    private readonly IMediator _mediator = mediator;

    [HttpGet]
    public async Task<IActionResult> GetWeatherData(CancellationToken cancellationToken)
    {
        GetWeatherInsightQuery query = new GetWeatherInsightQuery();

        WeatherData result = await mediator.Send(query, cancellationToken);

        return Ok(result);
    }
}
