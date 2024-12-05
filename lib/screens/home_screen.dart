import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../widgets/weather_display.dart';
import '../widgets/search_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              final weatherProvider = context.read<WeatherProvider>();
              if (weatherProvider.currentWeather != null) {
                weatherProvider.fetchWeather(
                  weatherProvider.currentWeather!.cityName,
                );
              }
            },
          ),
          IconButton(
            icon: Text(
              context.watch<WeatherProvider>().isCelsius ? '°C' : '°F',
            ),
            onPressed: () {
              context.read<WeatherProvider>().toggleUnit();
            },
          ),
        ],
      ),
      body: Column(
        children: const [
          WeatherSearchBar(),
          Expanded(child: WeatherDisplay()),
        ],
      ),
    );
  }
}