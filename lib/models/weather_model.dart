class WeatherTimestampModel {
  DateTime dateTime;
  double tempMin;
  double tempMax;
  String weatherText;

  WeatherTimestampModel(
    this.dateTime,
    this.tempMin,
    this.tempMax,
    this.weatherText
  );

  factory WeatherTimestampModel.fromJson(
    Map<String, dynamic> json
  ) {
    return WeatherTimestampModel(
      DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000), 
      json['main']['temp_min'],
      json['main']['temp_max'],
      json['weather'][0]["main"]
    );
  }
}