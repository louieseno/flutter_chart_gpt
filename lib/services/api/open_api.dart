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

  Future<List<ChartData>> getGraphData(String message) async {
    try {
      final Response<dynamic> response = await dio.post(baseURL,
          data: jsonEncode({
            "messages": [
              {
                "role": "user",
                "content": '''
                  Generate a valid JSON in which each element is an object. Strictly using this FORMAT and naming:
                  [{ "x": "a", "y": 12, "color": "#4285F4" }] for SyncFusion Flutter Chart. Make sure field x always stays named x. Instead of naming value field value in JSON, name it based on user metric.

                  Make sure the format use double quotes and property names are string literals. 

                  $message
                  Provide JSON data only. 
                '''
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
        final choices = response.data['choices'];
        final graphData = choices != null && choices.length > 0
            ? choices[0]['message']['content'].trim()
            : null;
        if (graphData != null && graphData != '') {
          return ChartData.chartDataFromGPT(jsonDecode(graphData));
        }
      }
    } catch (error, trace) {
      print("Error: $error \n\n Trace: $trace");
    }
    return [];
  }
}
