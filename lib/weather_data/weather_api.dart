import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/weather_data/lists.dart';
import 'package:weather_app/weather_data/models/current_weather_model.dart';

class WeatherAPI {
  static final String apiKey = "0038efd1a1f4429abbb193927251810";

  bool getHour(time){
    DateTime dateTime = DateTime.parse(time);

    int hour = dateTime.hour;

    if (hour >= 6 && hour < 18) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> getCitiesWeather() async {
    for (var city in WeatherLists.cities) {
      var response = await http.get(Uri.parse(
          "http://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$city&days=7&aqi=yes&alerts=yes"));
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var location = body["location"];
        var current = body["current"];
        var forecast = body["forecast"]["forecastday"];
        bool isNight = getHour(location["localtime"]);
        String image = getImage(current["condition"]["text"],isNight);
        WeatherLists.citiesWeather.add(CurrentWeatherModel(
            temp: current["temp_c"].toInt(),
            maxTemp: forecast[0]["day"]["maxtemp_c"].toInt(),
            minTemp: forecast[0]["day"]["mintemp_c"].toInt(),
            weather: current["condition"]["text"],
            image: image,
            cityName: location["name"],
            countryName: location["country"],
            isNight: isNight));
      }
    }
  }

  String getImage(String weather , bool isNight) {
    weather = weather.toLowerCase();
    if (weather.contains("clear")) {
      return "assets/images/moon.png";
    } else if (weather.contains("sunny")) {
      return "assets/images/sun.png";
    } else if (weather.contains("cloudy") && !isNight) {
      return "assets/images/Sun cloud.png";
    } else if (weather.contains("cloudy") && isNight) {
      return "assets/images/Moon cloud.png";
    }else if (weather.contains("overcast")) {
      return "assets/images/cloud.png";
    } else if ((weather.contains("rain") ||
        weather.contains("light drizzle")) && !isNight) {
      return "assets/images/Sun rain.png";
    } else if (weather.contains("rain") && isNight) {
      return "assets/images/Moon rain.png";
    } else if (weather.contains("thundery")) {
      return "assets/images/Thunder.png";
    } else if (weather.contains("snow")) {
      return "assets/images/snow.png";
    } else if (weather.contains("blowing snow")) {
      return "assets/images/storm.png";
    }
    if(isNight) {
      return "assets/images/moon.png";
    }else {
      return "assets/images/sun.png";
    }
  }
}
