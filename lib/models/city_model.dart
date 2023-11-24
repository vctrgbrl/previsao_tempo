class CityModel {
  String name;
  double latitude;
  double longitude;
  String country;
  String? state;

  CityModel({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.country,
    this.state
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      name: json["name"], 
      latitude: json["latitude"], 
      longitude: json["longitude"], 
      country: json["country"]
    );
  }
}