import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_chart_gpt/models/chart_data.dart';

class CustomColumnChart extends StatelessWidget {
  final List<ChartData> results;
  const CustomColumnChart({required this.results, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: SfCartesianChart(
          legend: Legend(isVisible: true, position: LegendPosition.bottom),
          primaryXAxis: CategoryAxis(),
          series: <ChartSeries<ChartData, String>>[
            ColumnSeries<ChartData, String>(
                dataSource: results,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                color: const Color.fromRGBO(8, 142, 255, 1))
          ]),
    );
  }
}
