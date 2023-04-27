class ChartData {
  final String x;
  final int y;

  ChartData({required this.x, required this.y});

  Map<String, dynamic> toJson() => {
        "x": x,
        "y": y,
      };

  factory ChartData.fromJson(Map<String, dynamic> json) {
    return ChartData(
      x: json['x'] ?? 'None',
      y: json['y'] ?? 0,
    );
  }

  static List<ChartData> chartDataFromGPT(List<dynamic> snapshot) {
    return snapshot.map((item) {
      return ChartData.fromJson(item);
    }).toList();
  }
}
