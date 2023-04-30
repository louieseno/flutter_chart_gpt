import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_chart_gpt/models/chart_data.dart';

class CustomAreaChart extends StatelessWidget {
  final List<ChartData> results;
  const CustomAreaChart({required this.results, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: SfCartesianChart(
          legend: Legend(isVisible: true, position: LegendPosition.bottom),
          primaryXAxis: CategoryAxis(),
          series: <ChartSeries>[
            AreaSeries<ChartData, String>(
                dataSource: results,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y)
          ]),
    );
  }
}
