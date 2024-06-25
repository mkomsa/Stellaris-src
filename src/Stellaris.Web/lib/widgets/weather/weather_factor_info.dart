import 'package:flutter/material.dart';
import 'package:stellaris_app/models/weather/weather_metric_info.dart';

class WeatherFactorInfo extends StatefulWidget {
  const WeatherFactorInfo(this.metricInfo, {Key? key}) : super(key: key);

  final WeatherMetricInfo metricInfo;

  @override
  State<StatefulWidget> createState() {
    return _WeatherFactorInfoState();
  }

  List<MetricRow> _generateMetricRows() {
    return [
      const MetricRow(
          icon: Icon(Icons.info_outline),
          value: 'Valid',
          description: 'Data validity check'),
      MetricRow(
          icon: const Icon(Icons.trending_up_outlined),
          value: metricInfo.max.toStringAsFixed(2),
          description: 'Maximum data sample over the sol'),
      MetricRow(
          icon: const Icon(Icons.trending_down_outlined),
          value: metricInfo.min.toStringAsFixed(2),
          description: 'Minimum data sample over the sol'),
      MetricRow(
          icon: const Icon(Icons.equalizer),
          value: metricInfo.average.toStringAsFixed(2),
          description: 'Average of samples over the Sol'),
      MetricRow(
          icon: const Icon(Icons.format_list_numbered),
          value: metricInfo.count.toString(),
          description: 'Total number of recorded samples over the Sol'),
    ];
  }

  List<MetricRow> getMetrics() {
    return _generateMetricRows();
  }
}

class _WeatherFactorInfoState extends State<WeatherFactorInfo> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(
        top: 4,
        bottom: 8,
      ),
      itemCount: widget.getMetrics().length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.getMetrics(),
        );
      },
    );
  }
}

class MetricRow extends StatefulWidget {
  final Icon icon;
  final String value;
  final String description;

  const MetricRow(
      {super.key,
      required this.icon,
      required this.value,
      required this.description});

  @override
  State<MetricRow> createState() {
    return _MetricRowState();
  }
}

class _MetricRowState extends State<MetricRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.only(top: 4, left: 8),
            child: widget.icon),
        const SizedBox(width: 12),
        Text(
          widget.value,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Theme.of(context).colorScheme.onSecondaryContainer),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
