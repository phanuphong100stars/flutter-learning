import 'package:geocoding/geocoding.dart';

import '../models/weather_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
// import 'package:flutter/material.dart';

class WeatherService {
  static const String baseUrl =
      "https://api.openweathermap.org/data/2.5/weather";
  static const String apiKey = "5498152daeff2c19ac541d7b7d369814";
  // final BuildContext context;

  WeatherService(
      //   {

      //    required this.context
      // }
      );

  Future<Weather> getWeather(String cityName) async {
    final response = await http
        .get(Uri.parse('$baseUrl?q=$cityName&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('Failed to load weather'),
      //   ),
      // );

      throw Exception('Failed to load weather');
    }
  }

  Future<String> getCurrentCity() async {
    // Get Permission from user
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    // fetch current location

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    String city = placemark[0].locality.toString();

    return city;
  }
}
