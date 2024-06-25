using Newtonsoft.Json;

namespace Stellaris.Server.Core.WeatherInsight.Models.ValidityCheck;

public class HwsValidity
{
    [JsonProperty("valid")]
    public bool IsValid { get; set; }
}
