import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';

class WeatherDisplay extends StatelessWidget {
  const WeatherDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
      builder: (context, weatherProvider, child) {
        if (weatherProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (weatherProvider.error.isNotEmpty) {
          return Center(child: Text(weatherProvider.error));
        }

        final weather = weatherProvider.currentWeather;
        if (weather == null) {
          return const Center(
            child: Text('Search for a city to see weather information'),
          );
        }

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                weather.cityName,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 20),
              Icon(
                _getWeatherIcon(weather.condition),
                size: 100,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 20),
              Text(
                '${weatherProvider.getDisplayTemperature(weather.temp).toStringAsFixed(1)}°'
                    '${weatherProvider.isCelsius ? 'C' : 'F'}',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text(
                weather.condition,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              Text(
                'Feels like: ${weatherProvider.getDisplayTemperature(weather.feelsLike).toStringAsFixed(1)}°'
                    '${weatherProvider.isCelsius ? 'C' : 'F'}',
              ),
              Text('Humidity: ${weather.humidity}%'),
            ],
          ),
        );
      },
    );
  }

  IconData _getWeatherIcon(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return Icons.wb_sunny;
      case 'partly cloudy':
        return Icons.cloud_queue;
      case 'cloudy':
        return Icons.cloud;
      default:
        return Icons.cloud_queue;
    }
  }
}