class AirPollution {
  int airQualityIndicator;
  late String airQuality;
  double co;
  double no;
  double no2;
  double o3;
  double so2;
  double pm2_5;
  double pm10;
  double nh3;
  DateTime dateTime;

  AirPollution(
    this.airQualityIndicator,
    this.co,
    this.no,
    this.no2,
    this.o3,
    this.so2,
    this.pm2_5,
    this.pm10,
    this.nh3,
    this.dateTime
  ) {
    switch (airQualityIndicator) {
      case 1:
        airQuality = "Péssima";
        break;
      case 2:
        airQuality = "Ruim";
        break;
      case 3:
        airQuality = "Moderada";
        break;
      case 4:
        airQuality = "Bom";
        break;
      case 5:
        airQuality = "Ótima";
        break;
    }
  }

  factory AirPollution.fromJson(Map<String, dynamic> json) {
    return AirPollution(
      json['main']['aqi'], 
      json['components']['co'], 
      json['components']['no'], 
      json['components']['no2'], 
      json['components']['o3'], 
      json['components']['so2'], 
      json['components']['pm2_5'], 
      json['components']['pm10'], 
      json['components']['nh3'], 
      DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000)
    );
  }
}