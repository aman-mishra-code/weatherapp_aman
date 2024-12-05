import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String apiKey = 'tJ1EXMslIx0WO4TBcvcl5w==82ldt5u9szJSr3nX';
  static const String baseUrl = 'https://api.api-ninjas.com/v1/weather';

  Future<Map<String, dynamic>> getWeatherData(String city) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl?city=$city'),
        headers: {'X-Api-Key': apiKey},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}