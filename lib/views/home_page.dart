import 'package:flutter/material.dart';
import 'package:previsao_tempo/data/openweather_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  OpenWeatherAPI openWeatherAPI = OpenWeatherAPI();
  
  getGeolocation() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Previsão do Tempo"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              const Expanded(
                child: TextField(
                  
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
          )
        ],
      ),
    );
  }
}