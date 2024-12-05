import 'package:flutter/material.dart';
import '../models/weather.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';

class WeatherProvider extends ChangeNotifier {
  Weather? _currentWeather;
  bool _isLoading = false;
  bool _isCelsius = true;
  String _error = '';

  Weather? get currentWeather => _currentWeather;
  bool get isLoading => _isLoading;
  bool get isCelsius => _isCelsius;
  String get error => _error;

  final ApiService _apiService = ApiService();

  Future<void> fetchWeather(String city) async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      final weatherData = await _apiService.getWeatherData(city);
      _currentWeather = Weather.fromJson(weatherData, city);
      await StorageService.saveWeather(_currentWeather!);
    } catch (e) {
      _error = 'Failed to fetch weather data. Loading cached data...';
      _currentWeather = await StorageService.getLatestWeather(city);
      if (_currentWeather == null) {
        _error = 'No cached data available. Please check your internet connection.';
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void toggleUnit() {
    _isCelsius = !_isCelsius;
    notifyListeners();
  }

  double getDisplayTemperature(double celsius) {
    return _isCelsius ? celsius : (celsius * 9 / 5) + 32;
  }
}