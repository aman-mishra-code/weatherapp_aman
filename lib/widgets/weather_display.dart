// Import required Flutter packages and providers
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';

// Widget to display weather information
class WeatherDisplay extends StatelessWidget {
  const WeatherDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use Consumer to listen to WeatherProvider changes
    return Consumer<WeatherProvider>(
      builder: (context, weatherProvider, child) {
        // Show loading indicator while fetching data
        if (weatherProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        // Show error message if any
        if (weatherProvider.error.isNotEmpty) {
          return Center(child: Text(weatherProvider.error));
        }

        // Get weather data from provider
        final weather = weatherProvider.currentWeather;
        // Show placeholder text if no weather data available
        if (weather == null) {
          return const Center(
            child: Text('Search for a city to see weather information'),
          );
        }

        // Display weather information in a centered column
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // City name
              Text(
                weather.cityName,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 20),
              // Weather condition icon
              Icon(
                _getWeatherIcon(weather.condition),
                size: 100,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 20),
              // Temperature display with unit
              Text(
                '${weatherProvider.getDisplayTemperature(weather.temp).toStringAsFixed(1)}°'
                    '${weatherProvider.isCelsius ? 'C' : 'F'}',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              // Weather condition text
              Text(
                weather.condition,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              // "Feels like" temperature
              Text(
                'Feels like: ${weatherProvider.getDisplayTemperature(weather.feelsLike).toStringAsFixed(1)}°'
                    '${weatherProvider.isCelsius ? 'C' : 'F'}',
              ),
              // Humidity percentage
              Text('Humidity: ${weather.humidity}%'),
            ],
          ),
        );
      },
    );
  }

  // Helper method to determine which icon to show based on weather condition
  IconData _getWeatherIcon(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return Icons.wb_sunny;      // Sun icon for clear weather
      case 'partly cloudy':
        return Icons.cloud_queue;   // Partial cloud icon for partly cloudy
      case 'cloudy':
        return Icons.cloud;         // Full cloud icon for cloudy
      default:
        return Icons.cloud_queue;   // Default to partial cloud icon
    }
  }
}