class WeatherParams {
  String lat;
  String long;
  String cnt;
  String unit;

  WeatherParams({
    this.lat = "52.5200",
    this.long = "13.4050",
    this.cnt = "50",
    this.unit = 'metric',
  });

  WeatherParams copyWith({
    String? lat,
    String? long,
    String? cnt,
    String? unit,
  }) {
    return WeatherParams(
      lat: lat ?? this.lat,
      long: long ?? this.long,
      cnt: cnt ?? this.cnt,
      unit: unit ?? this.unit,
    );
  }
}
