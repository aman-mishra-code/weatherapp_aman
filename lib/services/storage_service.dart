
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/weather.dart';

class StorageService {
  static const String _weatherKey = 'weather_data_';

  static Future<void> saveWeather(Weather weather) async {
    final prefs = await SharedPreferences.getInstance();
    final weatherJson = weather.toMap();
    await prefs.setString(_weatherKey + weather.cityName, jsonEncode(weatherJson));
  }

  static Future<Weather?> getLatestWeather(String cityName) async {
    final prefs = await SharedPreferences.getInstance();
    final weatherJson = prefs.getString(_weatherKey + cityName);

    if (weatherJson != null) {
      final weatherMap = jsonDecode(weatherJson) as Map<String, dynamic>;
      return Weather.fromMap(weatherMap);
    }
    return null;
  }
}