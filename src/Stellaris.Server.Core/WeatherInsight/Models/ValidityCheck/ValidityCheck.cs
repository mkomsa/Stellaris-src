using Newtonsoft.Json;

namespace Stellaris.Server.Core.WeatherInsight.Models.ValidityCheck;
public class ValidityCheck
{

    [JsonProperty("AT")]
    public AtValidity AtValidity { get; set; }
    [JsonProperty("HWS")]
    public HwsValidity HwsValidity { get; set; }
    [JsonProperty("PRE")]
    public PreValidity PreValidity { get; set; }
}
