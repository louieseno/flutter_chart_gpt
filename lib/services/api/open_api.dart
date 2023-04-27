import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_chart_gpt/env/env.dart';
import 'package:flutter_chart_gpt/models/chart_data.dart';

const baseURL = "https://api.openai.com/v1/chat/completions";

class OpenAPI {
  late Dio dio;

  static final OpenAPI _instance = OpenAPI._internal();
  factory OpenAPI() => _instance;
  OpenAPI._internal() {
    dio = Dio();
    dio.options.headers['Authorization'] = "Bearer ${Env.openAPIKey}";
  }

  Future<List<ChartData>> getGraphData() async {
    try {
      final Response<dynamic> response = await dio.post(baseURL,
          data: jsonEncode({
            "messages": [
              {
                "role": "user",
                "content":
                    "Generate a valid JSON in which each element is an object. Strictly using this FORMAT and naming:"
                        '[{ "x": "a", "y": 12, "color": "#4285F4" }] for the following description for SyncFusion flutter chart. create a bar chart for milk consumption based on 3 data sets of consumption , Monday - 50 bottles, 20 remaining and 1 half'
              }
            ],
            "temperature": 0.5,
            "max_tokens": 1000,
            "n": 1,
            "model": "gpt-3.5-turbo",
            "frequency_penalty": 0.5,
            "presence_penalty": 0.5,
          }));
      if (response.statusCode == 200) {
        return ChartData.chartDataFromGPT(
            jsonDecode(response.data['choices'][0]['message']['content']));
      }
    } catch (error, trace) {
      print("Error: $error \n\n Trace: $trace");
    }
    return [];
  }
}
