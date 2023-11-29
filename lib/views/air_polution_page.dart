import 'package:flutter/material.dart';
import 'package:previsao_tempo/data/openweather_api.dart';
import 'package:previsao_tempo/models/air_pollution_model.dart';
import 'package:previsao_tempo/models/city_model.dart';

class AirPollutionPage extends StatefulWidget {

  final CityModel cityModel;

  const AirPollutionPage({super.key, required this.cityModel});

  @override
  State<AirPollutionPage> createState() => _AirPollutionPageState();
}

class _AirPollutionPageState extends State<AirPollutionPage> {

  OpenWeatherAPI openWeatherAPI = OpenWeatherAPI();
  Future<AirPollution?>? airPollution;

  getAirPolution() {
    setState(() {
      airPollution = openWeatherAPI.airPollutionResource.getAirPollution(widget.cityModel);
    }); 
  }

  @override
  void initState() {
    super.initState();
    getAirPolution();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Qualidade do ar"),
      ),
      body: Center(
        child: FutureBuilder<AirPollution?>(
          future: airPollution,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(snapshot.data!.airQuality),
                    const SizedBox(height: 20,),
                    chemicalLevels(snapshot.data!)
                  ],
                );
              case ConnectionState.none:
                return const SizedBox.shrink();
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
              return const Text("wtf...");
            }
          }
        ),
      ),
    );
  }

  Widget chemicalLevels(AirPollution airPollution) {
    return Column(
      children: [
        Text("CO:     ${airPollution.co}"),
        Text("NO:     ${airPollution.no}"),
        Text("NO2:    ${airPollution.no2}"),
        Text("O3:     ${airPollution.o3}"),
        Text("SO2:    ${airPollution.so2}"),
        Text("PM2_5:  ${airPollution.pm2_5}"),
        Text("PM10:   ${airPollution.pm10}"),
        Text("NH3:    ${airPollution.nh3}"),
      ]
    );
  }
}