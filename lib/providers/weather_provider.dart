// Import required Flutter and custom packages
import 'package:flutter/material.dart';
import '../models/weather.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';

// WeatherProvider class that extends ChangeNotifier to manage weather state
class WeatherProvider extends ChangeNotifier {
  // Private fields to store weather data and state
  Weather? _currentWeather;     // Stores the current weather information
  bool _isLoading = false;      // Tracks loading state
  bool _isCelsius = true;       // Tracks temperature unit preference
  String _error = '';           // Stores error messages

  // Getters for accessing private fields
  Weather? get currentWeather => _currentWeather;
  bool get isLoading => _isLoading;
  bool get isCelsius => _isCelsius;
  String get error => _error;

  // Instance of ApiService to make API calls
  final ApiService _apiService = ApiService();

  // Method to fetch weather data for a given city
  Future<void> fetchWeather(String city) async {
    // Set loading state and clear any previous errors
    _isLoading = true;
    _error = '';
    notifyListeners();  // Notify listeners of state change

    try {
      // Attempt to fetch weather data from API
      final weatherData = await _apiService.getWeatherData(city);
      _currentWeather = Weather.fromJson(weatherData, city);
      // Save fetched weather data to local storage
      await StorageService.saveWeather(_currentWeather!);
    } catch (e) {
      // Handle error case by attempting to load cached data
      _error = 'Failed to fetch weather data. Loading cached data...';
      _currentWeather = await StorageService.getLatestWeather(city);
      // Update error message if no cached data is available
      if (_currentWeather == null) {
        _error = 'No cached data available. Please check your internet connection.';
      }
    } finally {
      // Reset loading state and notify listeners regardless of outcome
      _isLoading = false;
      notifyListeners();
    }
  }

  // Method to toggle between Celsius and Fahrenheit
  void toggleUnit() {
    _isCelsius = !_isCelsius;
    notifyListeners();  // Notify listeners of unit change
  }

  // Helper method to convert temperature based on selected unit
  double getDisplayTemperature(double celsius) {
    return _isCelsius ? celsius : (celsius * 9 / 5) + 32;  // Convert to Fahrenheit if not Celsius
  }
}