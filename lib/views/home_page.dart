import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:previsao_tempo/data/openweather_api.dart';
import 'package:previsao_tempo/models/city_model.dart';
import 'package:previsao_tempo/models/weather_model.dart';
import 'package:previsao_tempo/views/air_polution_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  OpenWeatherAPI openWeatherAPI = OpenWeatherAPI();
  TextEditingController textEditingController = TextEditingController();
  Future<List<CityModel>?>? cityModelList;

  Future<List<WeatherTimestampModel>?>? weatherList;

  CityModel? cityModel;
  int tempType = 0;

  getGeolocation() async {
    String text = textEditingController.text;
    setState(() {
      cityModelList = openWeatherAPI.geoCodingResource.getCity(text);
    });
  }

  getForecast() {
    setState(() {
      weatherList = openWeatherAPI.forecastResource.getForecast(cityModel!);
    }); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Previsão do Tempo"),
        actions: [
          IconButton(
            onPressed: cityModel.isNull? null:  () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (c) => AirPollutionPage(cityModel: cityModel!))
              );
            },
            icon: const Icon(Icons.cloud),
          )
        ],
      ),
      body: cityModel.isNull ? choseCityWidget() : cityInfo()
    );
  }

  Widget cityInfo() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text("Cidade: ${cityModel!.name}, ${cityModel!.state}"),
          tempTypeSelect(),
          FutureBuilder<List<WeatherTimestampModel>?>(
            future: weatherList,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  return Column(
                    children: snapshot.data!.map(weatherListItem).toList()
                  );
                case ConnectionState.none:
                  return const SizedBox.shrink();
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                default:
                return const Text("wtf...");
              }
            })
        ],
      ),
    );
  }

  String temperatureText(double temp) {
    if (tempType == 1) {
      temp -= 273.15;
    } else if (tempType == 2){
      temp = (temp - 273.15) * 9/5 + 32;
    }
    return temp.toStringAsPrecision(5);
  }

  String parseDate(DateTime dt) {
    String s = "${dt.day}/${dt.month}/${dt.year} ${dt.toString().split(" ")[1].substring(0,5)}";
    return s;
  }

  Widget weatherListItem(WeatherTimestampModel weather) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text("Temp Max: ${temperatureText(weather.tempMax)}"),
              Text("Temp Min: ${temperatureText(weather.tempMax)}"),
            ],
          ),
          Column(
            children: [
              Text("Weather: ${weather.weatherText}"),
              Text("Data: ${parseDate(weather.dateTime)}"),
            ],
          )
        ],
      ),
    );
  }

  Widget tempTypeSelect() {
    String t = "Kelvin";
    if (tempType == 1) {
      t = "Celsius";
    } else if (tempType == 2){
      t = "Fahrenheit";
    }
    return ElevatedButton(
      onPressed: () {
        setState(() {
          tempType = (tempType+1)%3;
        });
      }, 
      child: Text(t)
    );
  }

  Widget choseCityWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: textEditingController,
                )
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: getGeolocation, 
                  child: const Icon(Icons.search)
                ),
              )
            ],
          ),
          cityList()
        ],
      ),
    );
  }

  Widget cityList() {
    return FutureBuilder<List<CityModel>?>(
      future: cityModelList,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return Column(
              children: snapshot.data!.map(cityListItemWidget).toList()
            );
          case ConnectionState.none:
            return const SizedBox.shrink();
          case ConnectionState.waiting:
            return const Expanded(child: Center(child: CircularProgressIndicator()));
          default:
          return const Text("wtf...");
        }
      }
    );
  }

  Widget cityListItemWidget(CityModel city) {
    return ListTile(
      title: Text(city.name),
      subtitle: Text("${city.state}, ${city.country}"),
      onTap: () {
        setState(() {
          cityModel = city;
        });
        getForecast();
      },
    );
  }
}