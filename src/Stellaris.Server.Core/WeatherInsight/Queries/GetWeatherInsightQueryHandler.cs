using MediatR;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Stellaris.Server.Core.WeatherInsight.Models.ValidityCheck;
using Stellaris.Server.Core.WeatherInsight.Models.Weather;

namespace Stellaris.Server.Core.WeatherInsight.Queries;

internal class GetWeatherInsightQueryHandler(IHttpClientFactory clientFactory) : IRequestHandler<GetWeatherInsightQuery, WeatherData?>
{
    private readonly IHttpClientFactory _clientFactory = clientFactory;
    private const string WeatherInsightUrl = "https://mars.nasa.gov/rss/api/?feed=weather&category=insight_temperature&feedtype=json&ver=1.0";

    public async Task<WeatherData?> Handle(GetWeatherInsightQuery query, CancellationToken cancellationToken)
    {
        string json;

        using (var httpClient = clientFactory.CreateClient())
        {
            json = await httpClient.GetStringAsync(WeatherInsightUrl, cancellationToken);
        }

        WeatherData? weatherData = JsonConvert.DeserializeObject<WeatherData>(json);

        if (weatherData is null)
        {
            throw new JsonSerializationException("Failed to deserialize WeatherData. The JSON data may be invalid or empty.");
        }

        JObject jsonObject = JObject.Parse(json);

        foreach (string solKey in weatherData.SolKeys)
        {
            JToken? solDataToken = jsonObject.GetValue(solKey);
            JToken? validityCheckToken = jsonObject.SelectToken($"validity_checks.{solKey}");

            if (solDataToken == null || validityCheckToken == null)
                continue;

            SolData? solData = JsonConvert.DeserializeObject<SolData>(solDataToken.ToString());
            weatherData.SolData.Add(solKey, solData);

            ValidityCheck? validityCheck =
                JsonConvert.DeserializeObject<ValidityCheck>(validityCheckToken.ToString());
            weatherData.ValidityChecks.Items.Add(solKey, validityCheck);
        }

        weatherData.SolData["675"].Season = "fall";
        weatherData.SolData["676"].Season = "winter";
        weatherData.SolData["677"].Season = "spring";
        weatherData.SolData["678"].Season = "summer";

        weatherData = RandomizeData(weatherData);
        return weatherData;
    }

    private WeatherData RandomizeData(WeatherData weatherData)
    {
        Random rand = new Random();

        foreach (var solData in weatherData.SolData.Values)
        {

            solData.Pressure.Maximum = rand.NextDouble() * rand.Next(750, 800);
            solData.Pressure.Minimum = rand.NextDouble() * rand.Next(700, 740);
            solData.Pressure.Average = rand.NextDouble() * rand.Next(740, 749);
            solData.Pressure.Count = rand.Next(800000, 900000);

            solData.AtmosphericTemperature.Maximum = rand.NextDouble() * rand.Next(-100, -12);
            solData.AtmosphericTemperature.Minimum = rand.NextDouble() * rand.Next(-100, -12);
            solData.AtmosphericTemperature.Average = rand.NextDouble() * rand.Next(-100, -12);
            solData.AtmosphericTemperature.Count = rand.Next(150000, 200000);

            solData.HorizontalWindSpeed.Maximum = rand.NextDouble() * rand.Next(10, 40);
            solData.HorizontalWindSpeed.Minimum = rand.NextDouble() * rand.Next(1, 3);
            solData.HorizontalWindSpeed.Average = rand.NextDouble() * rand.Next(5, 9);
            solData.HorizontalWindSpeed.Count = rand.Next(80000, 900000);
        }

        return weatherData;
    }
}
