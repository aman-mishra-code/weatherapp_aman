// Import required packages for HTTP requests and JSON handling
import 'package:http/http.dart' as http;
import 'dart:convert';

// Service class to handle API interactions for weather data
class ApiService {
  // API credentials and endpoint configuration
  static const String apiKey = 'tJ1EXMslIx0WO4TBcvcl5w==82ldt5u9szJSr3nX';
  static const String baseUrl = 'https://api.api-ninjas.com/v1/weather';

  // Method to fetch weather data for a given city
  Future<Map<String, dynamic>> getWeatherData(String city) async {
    try {
      // Make GET request to API with city parameter and API key in headers
      final response = await http.get(
        Uri.parse('$baseUrl?city=$city'),
        headers: {'X-Api-Key': apiKey},
      );

      // Check if request was successful (status code 200)
      if (response.statusCode == 200) {
        // Parse JSON response into Map
        return json.decode(response.body);
      } else {
        // Throw exception if request failed
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      // Handle any network or other errors
      throw Exception('Network error: $e');
    }
  }
}