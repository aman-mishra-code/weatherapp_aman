# weatherapp_aman

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

Weather App
A Flutter weather application that displays current weather conditions and forecasts using the Api-Ninja Weather API. The app supports offline functionality using Hive for local storage and provides temperature unit conversion between Celsius and Fahrenheit.
Features

Current weather data display
Search for weather by city name
Temperature unit conversion (Celsius/Fahrenheit)
Offline data storage
Error handling for network issues
Clean and intuitive user interface


Prerequisites

Flutter SDK (2.17.0 or higher)
Dart SDK (2.17.0 or higher)
Android Studio / VS Code
API Key from Api-Ninja (sign up at https://api-ninjas.com)

Installation:
1. Clone the repository:
   git clone https://github.com/aman-mishra-code/weatherapp
   cd weather_app
2. Install dependencies:
   flutter pub get
3. Update the API key:
   Open lib/services/api_service.dart
   Replace 'YOUR_API_NINJA_KEY' with your actual Api-Ninja API key
4. Run the app:
   flutter run