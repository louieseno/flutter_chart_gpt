import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_chart_gpt/models/chart_data.dart';

class CustomPieChart extends StatelessWidget {
  final List<ChartData> results;
  const CustomPieChart({required this.results, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: SfCircularChart(
            legend: Legend(isVisible: true),
            series: <CircularSeries>[
              PieSeries<ChartData, String>(
                dataSource: results,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                dataLabelSettings: const DataLabelSettings(
                    isVisible: true, color: Colors.black),
                pointColorMapper: (ChartData data, _) => data.color,
              )
            ]));
  }
}
