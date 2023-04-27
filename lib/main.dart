import 'package:flutter/material.dart';
import 'package:flutter_chart_gpt/charts/bar.dart';
import 'package:flutter_chart_gpt/models/chart_data.dart';
import 'package:chips_choice/chips_choice.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Chart GPT'),
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
  List<ChartData> results = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: Styles.inputPadding,
                child: TextField(
                  maxLines: 4,
                  decoration: Styles.inputBoxStyle,
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
              Bar(
                results: results,
              ),
            ],
          ),
        ));
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
