using Newtonsoft.Json;

namespace Stellaris.Server.Core.WeatherInsight.Models.Weather;
public class AT
{
    private double _average;
    private double _minimum;
    private double _maximum;

    [JsonProperty("av")]
    public double Average
    {
        get => _average;
        set => _average = Math.Round(value, 3);
    }

    [JsonProperty("ct")]
    public int Count { get; set; }

    [JsonProperty("mn")]
    public double Minimum
    {
        get => _minimum;
        set => _minimum = Math.Round(value, 3);
    }

    [JsonProperty("mx")]
    public double Maximum
    {
        get => _maximum;
        set => _maximum = Math.Round(value, 3);
    }

    public AT(double average, int count, double minimum, double maximum)
    {
        Average = average;
        Count = count;
        Minimum = minimum;
        Maximum = maximum;
    }
}
