using Newtonsoft.Json;

namespace Stellaris.Server.Core.WeatherInsight.Models.ValidityCheck;

public class PreValidity
{
    [JsonProperty("valid")]
    public bool IsValid { get; set; }
}
