import 'dart:convert';

import 'package:weather_app/weather_data/Lists.dart';
import 'package:weather_app/weather_data/models/current_weather_model.dart';
import 'package:weather_app/weather_data/weather_api.dart';
import 'package:http/http.dart' as http;

class WeatherSearchAPI{
  String apiKey = WeatherAPI.apiKey;
  Future<void> getListSearchWeather(String val) async {
    WeatherLists.search.clear();
    final searchResponse = await http.get(Uri.parse(
        "https://api.weatherapi.com/v1/search.json?key=$apiKey&q=$val"));
    if (searchResponse.statusCode == 200){

      final searchData = jsonDecode(searchResponse.body);
      for (var city in searchData) {
        String cityName = city['name'];
        var response = await http.get(Uri.parse(
            "http://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$cityName&days=7&aqi=yes&alerts=yes"));
        if (response.statusCode == 200) {
          var body = jsonDecode(response.body);
          var location = body["location"];
          var current = body["current"];
          var forecast = body["forecast"]["forecastday"];
          bool isNight = WeatherAPI().getHour(location["localtime"]);
          String image = WeatherAPI().getImage(current["condition"]["text"], isNight);
          WeatherLists.search.add(CurrentWeatherModel(
              temp: current["temp_c"].toInt(),
              maxTemp: forecast[0]["day"]["maxtemp_c"].toInt(),
              minTemp: forecast[0]["day"]["mintemp_c"].toInt(),
              weather: current["condition"]["text"],
              image: image,
              cityName: location["name"],
              countryName: location["country"],
              isNight: isNight
          ));
        }
      }
    }

  }

  Future<List<CurrentWeatherModel>> getWeatherSearchList(String val) async {
    List<CurrentWeatherModel> results = [];

    final searchResponse = await http.get(Uri.parse(
        "https://api.weatherapi.com/v1/search.json?key=$apiKey&q=$val"));

    if (searchResponse.statusCode == 200) {
      final searchData = jsonDecode(searchResponse.body);

      for (var city in searchData) {
        String cityName = city['name'];

        var response = await http.get(Uri.parse(
            "http://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$cityName&days=7&aqi=yes&alerts=yes"));

        if (response.statusCode == 200) {
          var body = jsonDecode(response.body);
          var location = body["location"];
          var current = body["current"];
          var forecast = body["forecast"]["forecastday"];

          bool isNight = WeatherAPI().getHour(location["localtime"]);
          String image = WeatherAPI().getImage(current["condition"]["text"], isNight);

          results.add(CurrentWeatherModel(
            temp: current["temp_c"].toInt(),
            maxTemp: forecast[0]["day"]["maxtemp_c"].toInt(),
            minTemp: forecast[0]["day"]["mintemp_c"].toInt(),
            weather: current["condition"]["text"],
            image: image,
            cityName: location["name"],
            countryName: location["country"],
            isNight: isNight,
          ));
        }
      }
    }
    WeatherLists.search = results;
    return results; // ✅ أهم حاجة
  }
}