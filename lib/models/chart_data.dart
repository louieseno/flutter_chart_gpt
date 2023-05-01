import 'package:flutter/material.dart';
import 'package:flutter_chart_gpt/extensions/color_extension.dart';

class ChartData {
  final String x;
  final num y;
  final Color color;

  ChartData({required this.x, required this.y, this.color = Colors.pink});

  Map<String, dynamic> toJson() => {"x": x, "y": y, "color": color};

  factory ChartData.fromJson(Map<String, dynamic> json) {
    return ChartData(
      x: json['x'],
      y: json['y'],
      color: HexColor.fromHex(json['color']),
    );
  }

  static List<ChartData> chartDataFromGPT(List<dynamic> snapshot) {
    return snapshot.map((item) {
      return ChartData.fromJson(item);
    }).toList();
  }
}
