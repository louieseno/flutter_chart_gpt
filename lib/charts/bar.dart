import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_chart_gpt/models/chart_data.dart';

class Bar extends StatelessWidget {
  final List<ChartData> results;
  const Bar({required this.results, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          primaryYAxis: NumericAxis(minimum: 0, maximum: 40, interval: 5),
          series: <ChartSeries<ChartData, String>>[
            BarSeries<ChartData, String>(
                dataSource: results,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                color: const Color.fromRGBO(8, 142, 255, 1))
          ]),
    );
  }
}
