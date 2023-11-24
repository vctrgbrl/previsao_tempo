import 'dart:convert';

import 'package:http/http.dart';
import 'package:previsao_tempo/models/city_model.dart';

abstract class Resource {
  Client client;
  Resource(this.client);
}

class GeoCodingResource extends Resource {
  
  GeoCodingResource(super.client);

  Future<List<CityModel>?> getCity(String city, String? state, String? country) async {
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
      l.add(
        CityModel.fromJson(el)
      );
    }

    return l;
  }
}

class OpenWeatherAPI {
  static const String apiKey = "fe3ff82201d685aa14666214873292c4";

  Client client = Client();

  late GeoCodingResource geoCodingResource;

  OpenWeatherAPI() {
    geoCodingResource = GeoCodingResource(client);
  }
}