import 'package:flutter/material.dart';
import 'package:flutter_chart_gpt/charts/bar.dart';
import 'package:flutter_chart_gpt/models/chart_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<ChartData> results;
  @override
  void initState() {
    final test = [
      {"x": "Monday", "y": 50, "color": "#FF6384"},
      {"x": "Tuesday", "y": 10, "color": "#36A2EB"}
    ];
    results = ChartData.chartDataFromGPT(test);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Bar(
            results: results,
          ),
        ));
  }
}
