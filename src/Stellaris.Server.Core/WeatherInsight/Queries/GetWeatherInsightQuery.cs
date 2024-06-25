using MediatR;
using Stellaris.Server.Core.WeatherInsight.Models.Weather;

namespace Stellaris.Server.Core.WeatherInsight.Queries;

public class GetWeatherInsightQuery : IRequest<WeatherData?>
{
}
