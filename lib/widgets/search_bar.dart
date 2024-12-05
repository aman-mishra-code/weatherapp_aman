import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';

class WeatherSearchBar extends StatefulWidget {
  const WeatherSearchBar({Key? key}) : super(key: key);

  @override
  State<WeatherSearchBar> createState() => _WeatherSearchBarState();
}

class _WeatherSearchBarState extends State<WeatherSearchBar> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: 'Enter city name',
          suffixIcon: IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                context.read<WeatherProvider>().fetchWeather(_controller.text);
              }
            },
          ),
          border: const OutlineInputBorder(),
        ),
        onSubmitted: (value) {
          if (value.isNotEmpty) {
            context.read<WeatherProvider>().fetchWeather(value);
          }
        },
      ),
    );
  }
}