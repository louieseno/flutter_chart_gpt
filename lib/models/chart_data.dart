class ChartData {
  final String name;
  final String value;

  ChartData({required this.name, required this.value});

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
      };

  factory ChartData.fromJson(Map<String, dynamic> json) {
    return ChartData(
      name: json['name'],
      value: json['value'],
    );
  }
}
