import 'dart:convert';

import 'package:http/http.dart';
import 'package:previsao_tempo/models/air_pollution_model.dart';
import 'package:previsao_tempo/models/city_model.dart';
import 'package:previsao_tempo/models/weather_model.dart';

abstract class Resource {
  Client client;
  Resource(this.client);
}

class AirPollutionResource extends Resource {
  AirPollutionResource(super.client);

  Future<AirPollution?> getAirPollution(CityModel cityModel) async {
    Uri u = Uri.parse(
      "http://api.openweathermap.org/data/2.5/air_pollution?lat=${cityModel.latitude}&lon=${cityModel.longitude}&appid=${OpenWeatherAPI.apiKey}"
    );
    var res = await client.get(u);
    if (res.statusCode != 200) {
      return null;
    }

    var b = jsonDecode(res.body);
    var c = AirPollution.fromJson(b['list'][0]);
    return c;
  }
}

class ForecastResource extends Resource {
  ForecastResource(super.client);
  
  Future<List<WeatherTimestampModel>?> getForecast(CityModel cityModel) async {
    Uri u = Uri.parse("http://api.openweathermap.org/data/2.5/forecast?lat=${cityModel.latitude}&lon=${cityModel.longitude}&appid=${OpenWeatherAPI.apiKey}");
    var res = await client.get(u);

    if (res.statusCode != 200) {
      return null;
    }

    List<WeatherTimestampModel> l = [];
    var b = jsonDecode(res.body);
    for (var element in b['list']) {
      var c = WeatherTimestampModel.fromJson(element);
      l.add(c);
    }
    return l;
  }
}

class GeoCodingResource extends Resource {
  
  GeoCodingResource(super.client);

  Future<List<CityModel>?> getCity(String city, [String? state, String? country]) async {
    String args = city;
    args += state == null?"": ",$state";
    args += country == null?"": ",$country";
    Uri u = Uri.parse("http://api.openweathermap.org/geo/1.0/direct?q=$args&limit=5&appid=${OpenWeatherAPI.apiKey}");
    var res = await client.get(u);

    if (res.statusCode != 200) {
      return null;
    }
    List<CityModel> l = [];
    var b = jsonDecode(res.body);

    for (var el in b) {
      var c = CityModel.fromJson(el);
      l.add(
        c
      );
    }

    return l;
  }
}

class OpenWeatherAPI {
  static const String apiKey = "fe3ff82201d685aa14666214873292c4";

  Client client = Client();


  late GeoCodingResource geoCodingResource;
  late ForecastResource forecastResource;
  late AirPollutionResource airPollutionResource;

  OpenWeatherAPI() {
    geoCodingResource = GeoCodingResource(client);
    forecastResource = ForecastResource(client);
    airPollutionResource = AirPollutionResource(client);
  }
}