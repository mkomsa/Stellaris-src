using Newtonsoft.Json;
using Stellaris.Server.Core.WeatherInsight.Models.ValidityCheck;

namespace Stellaris.Server.Core.WeatherInsight.Models.Weather;

public class WeatherData
{
    [JsonProperty("sol_keys")]
    public List<string> SolKeys { get; set; } = new();

    [JsonProperty("validity_checks")]
    public ValidityChecks ValidityChecks { get; set; } = new();

    public Dictionary<string, SolData?> SolData { get; init; } = new();
}
