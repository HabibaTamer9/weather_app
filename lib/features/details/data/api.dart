import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:weather_app/weather_data/lists.dart';
import 'package:weather_app/weather_data/models/weather_details_model.dart';
import 'package:weather_app/weather_data/weather_api.dart';
import 'package:http/http.dart' as http;

class DetailsAPI{
  String apiKey = WeatherAPI.apiKey;
  Future<void> currentDetailsWeather(String city , BuildContext context) async {
    var response = await http.get(Uri.parse(
        "http://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$city&days=7&aqi=yes&alerts=yes"));
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      var location = body["location"];
      var current = body["current"];
      var forecast = body["forecast"]["forecastday"];
      DateTime dateTime = DateTime.parse(location["localtime"]);

      int hour = dateTime.hour;

      bool isNight = false;

      if (hour >= 6 && hour < 18) {
        isNight = false;
      } else {
        isNight = true;
      }
      String image = WeatherAPI().getImage(current["condition"]["text"],isNight);
      WeatherLists.weatherDetails = WeatherDetailsModel(
          temp: current["temp_c"].toInt(),
          maxTemp: forecast[0]["day"]["maxtemp_c"].toInt(),
          minTemp: forecast[0]["day"]["mintemp_c"].toInt(),
          weather: current["condition"]["text"],
          image: image,
          cityName: location["name"],
          countryName: location["country"],
          sunrise: forecast[0]["astro"]["sunrise"],
          sunset: forecast[0]["astro"]["sunset"],
          uv: current["uv"].toInt(),
          feelsLike: current["feelslike_c"].toInt(),
          pressure: current["pressure_mb"].toInt(),
          humidity: current["humidity"].toInt(),
          visibility: current["vis_km"].toInt(),
          windSpeed: current["wind_kph"].toInt());

    }
  }
}