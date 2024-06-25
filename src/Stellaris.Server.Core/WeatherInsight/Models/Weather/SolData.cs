using Newtonsoft.Json;

namespace Stellaris.Server.Core.WeatherInsight.Models.Weather;
public class SolData
{
    [JsonProperty("AT")]
    public AT AtmosphericTemperature { get; set; }

    [JsonProperty("HWS")]
    public HWS HorizontalWindSpeed { get; set; }

    [JsonProperty("PRE")]
    public PRE Pressure { get; set; }

    [JsonProperty("Last_UTC")]
    public string LastUTC { get; set; }

    [JsonProperty("Season")]
    public string Season { get; set; }
}
