import 'dart:convert';

import 'package:weather_app/weather_data/Lists.dart';
import 'package:weather_app/weather_data/weather_api.dart';
import 'package:http/http.dart' as http;

class SearchAPI{
  String apiKey = WeatherAPI.apiKey;
  Future getCitiesSearchWeather(String val) async {
    WeatherLists.searchCities.clear();
    final searchResponse = await http.get(Uri.parse(
        "https://api.weatherapi.com/v1/search.json?key=$apiKey&q=$val"));
    if (searchResponse.statusCode != 200) return null;

    final searchData = jsonDecode(searchResponse.body);
    return searchData;
  }
}