import 'package:flutter/material.dart';
import '../services/weather_service.dart';
import '../models/weather_model.dart';
import 'package:lottie/lottie.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService();
  Weather? _weather;

  _fetchWeather() async {
    final cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  String getWeatherAnimation(String? mainCondition) {
    const assetFolder = 'assets';
    const sunny = '$assetFolder/sunny.json';
    const cloud = '$assetFolder/cloud.json';
    const rain = '$assetFolder/rain.json';
    const thunder = '$assetFolder/thunder.json';

    switch (mainCondition?.toLowerCase()) {
      case 'clounds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return cloud;
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return rain;
      case 'thunderstorm':
        return thunder;
      case 'clear':
        return sunny;
      default:
        return sunny;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _weather?.cityName ?? "loading city...",
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
          Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
          Text(
            '${_weather?.temperature.round()}°C',
            style: TextStyle(fontSize: 42, color: Colors.white),
          ),
        ],
      )),
    );
  }
}
