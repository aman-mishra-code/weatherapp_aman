// Import required Flutter packages and providers
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';

// Stateful widget for the search bar that allows city input
class WeatherSearchBar extends StatefulWidget {
  const WeatherSearchBar({Key? key}) : super(key: key);

  @override
  State<WeatherSearchBar> createState() => _WeatherSearchBarState();
}

// State class for WeatherSearchBar
class _WeatherSearchBarState extends State<WeatherSearchBar> {
  // Controller for managing the text input
  final _controller = TextEditingController();

  @override
  // Dispose of the controller when widget is removed from the tree
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      // Text input field for city name
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: 'Enter city name',
          // Search icon button at the end of the text field
          suffixIcon: IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Fetch weather when search icon is clicked and text isn't empty
              if (_controller.text.isNotEmpty) {
                context.read<WeatherProvider>().fetchWeather(_controller.text);
              }
            },
          ),
          // Add border to the text field
          border: const OutlineInputBorder(),
        ),
        // Handle when user presses enter/submit on keyboard
        onSubmitted: (value) {
          if (value.isNotEmpty) {
            context.read<WeatherProvider>().fetchWeather(value);
          }
        },
      ),
    );
  }
}