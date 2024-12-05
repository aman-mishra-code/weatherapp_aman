// Import required Flutter packages and custom widgets/providers
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../widgets/weather_display.dart';
import '../widgets/search_bar.dart';

// HomeScreen widget that serves as the main screen of the weather app
class HomeScreen extends StatelessWidget {
  // Constructor with optional key parameter
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar configuration
      appBar: AppBar(
        title: const Text('Weather App'),
        actions: [
          // Refresh button in app bar
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Get weather provider instance using Provider
              final weatherProvider = context.read<WeatherProvider>();
              // Refresh weather data for current city if one is selected
              if (weatherProvider.currentWeather != null) {
                weatherProvider.fetchWeather(
                  weatherProvider.currentWeather!.cityName,
                );
              }
            },
          ),
          // Temperature unit toggle button (°C/°F)
          IconButton(
            // Watch provider to update temperature unit display
            icon: Text(
              context.watch<WeatherProvider>().isCelsius ? '°C' : '°F',
            ),
            onPressed: () {
              // Toggle between Celsius and Fahrenheit
              context.read<WeatherProvider>().toggleUnit();
            },
          ),
        ],
      ),
      // Main content layout
      body: Column(
        children: const [
          // Search bar for entering city names
          WeatherSearchBar(),
          // Expanded widget to display weather information
          Expanded(child: WeatherDisplay()),
        ],
      ),
    );
  }
}