class ChartData {
  final String x;
  final num y;

  ChartData({required this.x, required this.y});

  Map<String, dynamic> toJson() => {
        "x": x,
        "y": y,
      };

  factory ChartData.fromJson(Map<String, dynamic> json) {
    return ChartData(
      x: json['x'],
      y: json['y'],
    );
  }

  static List<ChartData> chartDataFromGPT(List<dynamic> snapshot) {
    return snapshot.map((item) {
      return ChartData.fromJson(item);
    }).toList();
  }
}
