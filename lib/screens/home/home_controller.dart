import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_chart_gpt/models/chart_data.dart';
import 'package:flutter_chart_gpt/services/api/open_api.dart';
import 'package:get/state_manager.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:ui' as ui;

class HomeController extends GetxController {
  final GlobalKey repaintKey = GlobalKey();
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

  RxBool isSavingGraph = false.obs;

  RxInt chartIndex = 0.obs;
  final TextEditingController graphEditingController = TextEditingController();

  void _showSnackBar(String content, bool status) {
    ScaffoldMessenger.of(repaintKey.currentContext!).showSnackBar(
      SnackBar(
        backgroundColor: status ? Colors.pink : Colors.redAccent,
        content: Text(
          content,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

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

  void saveGraph() async {
    isSavingGraph.value = true;
    try {
      await Future.delayed(const Duration(milliseconds: 300), () async {
        RenderRepaintBoundary boundary = repaintKey.currentContext!
            .findRenderObject() as RenderRepaintBoundary;
        ui.Image image = await boundary.toImage(pixelRatio: 10.0);
        ByteData? byteData =
            await image.toByteData(format: ui.ImageByteFormat.png);
        if (byteData != null) {
          final result =
              await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());
          final success = result['isSuccess'];
          _showSnackBar(
              success ? 'Graph Downloaded!' : 'Graph failed to download!',
              success);
        }
      });
    } catch (error) {
      _showSnackBar(error.toString(), false);
    }
    isSavingGraph.value = false;
  }

  void _requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
    // final info = statuses[Permission.storage].toString();
  }

  @override
  void onReady() {
    super.onReady();
    _requestPermission();
  }
}
