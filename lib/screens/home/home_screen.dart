import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chart_gpt/screens/home/home_controller.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_chart_gpt/charts/custom_area_chart.dart';
import 'package:flutter_chart_gpt/charts/custom_bar_chart.dart';
import 'package:flutter_chart_gpt/charts/custom_column_chart.dart';
import 'package:flutter_chart_gpt/charts/custom_line_chart.dart';
import 'package:flutter_chart_gpt/charts/custom_pie_chart.dart';
import 'package:get/state_manager.dart';

class HomeScreen extends GetView<HomeController> {
  static const route = '/';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Chart GPT'),
        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: Styles.inputPadding,
                child: Column(
                  children: [
                    TextField(
                      controller: controller.textEditingController,
                      maxLines: 4,
                      decoration: Styles.inputBoxStyle,
                    ),
                    const SizedBox(height: 10.0),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: controller.generateGraph,
                          child: const Text('Draw'),
                        )),
                  ],
                ),
              ),
              const Divider(),
              Obx(() {
                if (controller.isGenerating.value == true) {
                  return const CircularProgressIndicator();
                }
                return Column(
                  children: [
                    ChipsChoice<int>.single(
                      value: controller.chartIndex.value,
                      onChanged: (val) => controller.updateChartIndex(val),
                      choiceItems: C2Choice.listFrom<int, String>(
                        source: controller.charts,
                        value: (i, v) => i,
                        label: (i, v) => v,
                      ),
                      choiceCheckmark: false,
                      choiceStyle: C2ChipStyle.filled(
                        selectedStyle: const C2ChipStyle(
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: Styles.titlePadding,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const <Widget>[
                          Text(
                            'Chart Title',
                            style: Styles.titleStyle,
                          ),
                          SizedBox(width: 20),
                          Icon(
                            Icons.edit,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                    const RenderChart()
                  ],
                );
              }),
            ],
          ),
        ));
  }
}

class RenderChart extends GetView<HomeController> {
  const RenderChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.chartIndex.value == 0) {
        return CustomAreaChart(results: controller.results);
      }
      if (controller.chartIndex.value == 1) {
        return CustomBarChart(results: controller.results);
      }
      if (controller.chartIndex.value == 2) {
        return CustomColumnChart(results: controller.results);
      }
      if (controller.chartIndex.value == 3) {
        return CustomLineChart(results: controller.results);
      }
      return CustomPieChart(results: controller.results);
    });
  }
}

class Styles {
  static const inputPadding =
      EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0);

  static final inputBoxStyle = InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      filled: true,
      hintStyle: TextStyle(color: Colors.grey[400]),
      hintText: "Describe your data",
      fillColor: Colors.white70);

  static const titlePadding =
      EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0);

  static const titleStyle = TextStyle(fontSize: 16.0);
}
