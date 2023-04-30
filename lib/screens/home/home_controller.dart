import 'package:flutter/material.dart';
import 'package:flutter_chart_gpt/models/chart_data.dart';
import 'package:flutter_chart_gpt/services/api/open_api.dart';
import 'package:get/state_manager.dart';

class HomeController extends GetxController {
  final List<String> charts = [
    'Area',
    'Bar',
    'Column',
    'Line',
    'Pie',
  ];

  RxBool isTitleEdit = false.obs;
  final TextEditingController titleEditingController =
      TextEditingController(text: 'Chart Title');
  final FocusNode titleEditFocus = FocusNode();

  RxBool isGenerating = false.obs;
  RxList<ChartData> results = <ChartData>[].obs;

  RxInt chartIndex = 0.obs;
  final TextEditingController graphEditingController = TextEditingController();

  void generateGraph() async {
    isTitleEdit.value = false;
    isGenerating.value = true;
    final data = await OpenAPI().getGraphData(graphEditingController.text);
    results.value = data;
    isGenerating.value = false;
  }

  void updateChartIndex(int value) {
    chartIndex.value = value;
  }

  void updateTitleMode(BuildContext context) async {
    if (isTitleEdit.value) {
      isTitleEdit.value = false;
    } else {
      isTitleEdit.value = true;
      await Future.delayed(const Duration(milliseconds: 500), () {
        FocusScope.of(context).requestFocus(titleEditFocus);
      });
    }
  }
}
