using Newtonsoft.Json;

namespace Stellaris.Server.Core.WeatherInsight.Models.Weather;

public class HWS
{
    [JsonProperty("av")]
    public double Average { get; set; }

    [JsonProperty("ct")]
    public int Count { get; set; }

    [JsonProperty("mn")]
    public double Minimum { get; set; }

    [JsonProperty("mx")]
    public double Maximum { get; set; }
}
