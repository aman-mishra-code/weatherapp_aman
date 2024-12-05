// Import required packages for JSON operations and shared preferences
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/weather.dart';

// Service class to handle local storage operations for weather data
class StorageService {
  // Constant key prefix for storing weather data
  static const String _weatherKey = 'weather_data_';

  // Method to save weather data to local storage
  static Future<void> saveWeather(Weather weather) async {
    // Get instance of SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    // Convert Weather object to Map
    final weatherJson = weather.toMap();
    // Store encoded JSON string with city-specific key
    await prefs.setString(_weatherKey + weather.cityName, jsonEncode(weatherJson));
  }

  // Method to retrieve cached weather data for a specific city
  static Future<Weather?> getLatestWeather(String cityName) async {
    // Get instance of SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    // Retrieve stored JSON string using city-specific key
    final weatherJson = prefs.getString(_weatherKey + cityName);

    // If cached data exists, decode and convert to Weather object
    if (weatherJson != null) {
      final weatherMap = jsonDecode(weatherJson) as Map<String, dynamic>;
      return Weather.fromMap(weatherMap);
    }
    // Return null if no cached data found
    return null;
  }
}