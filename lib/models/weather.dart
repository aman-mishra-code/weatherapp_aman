class Weather {
  final double temp;
  final double feelsLike;
  final double minTemp;
  final double maxTemp;
  final int humidity;
  final String condition;
  final String cityName;
  final DateTime timestamp;

  Weather({
    required this.temp,
    required this.feelsLike,
    required this.minTemp,
    required this.maxTemp,
    required this.humidity,
    required this.condition,
    required this.cityName,
    required this.timestamp,
  });

  factory Weather.fromJson(Map<String, dynamic> json, String cityName) {
    return Weather(
      temp: json['temp'].toDouble(),
      feelsLike: json['feels_like'].toDouble(),
      minTemp: json['min_temp'].toDouble(),
      maxTemp: json['max_temp'].toDouble(),
      humidity: json['humidity'],
      condition: _getCondition(json['cloud_pct']),
      cityName: cityName,
      timestamp: DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'temp': temp,
      'feels_like': feelsLike,
      'min_temp': minTemp,
      'max_temp': maxTemp,
      'humidity': humidity,
      'condition': condition,
      'city_name': cityName,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory Weather.fromMap(Map<String, dynamic> map) {
    return Weather(
      temp: map['temp'],
      feelsLike: map['feels_like'],
      minTemp: map['min_temp'],
      maxTemp: map['max_temp'],
      humidity: map['humidity'],
      condition: map['condition'],
      cityName: map['city_name'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }

  static String _getCondition(int cloudPct) {
    if (cloudPct < 30) return 'Clear';
    if (cloudPct < 70) return 'Partly Cloudy';
    return 'Cloudy';
  }
}