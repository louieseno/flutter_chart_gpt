import 'package:flutter/material.dart';
import 'package:flutter_chart_gpt/models/chart_data.dart';
import 'package:flutter_chart_gpt/services/api/open_api.dart';
import 'package:get/state_manager.dart';

class HomeController extends GetxController {
  RxBool isGenerating = false.obs;
  RxList<ChartData> results = <ChartData>[].obs;
  RxInt chartIndex = 0.obs;
  final List<String> charts = [
    'Area',
    'Bar',
    'Column',
    'Line',
    'Pie',
  ];
  final TextEditingController textEditingController = TextEditingController();

  void generateGraph() async {
    isGenerating.value = true;
    final data = await OpenAPI().getGraphData(textEditingController.text);
    results.value = data;
    isGenerating.value = false;
  }

  void updateChartIndex(int value) {
    chartIndex.value = value;
  }
}
