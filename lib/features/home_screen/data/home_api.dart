import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:weather_app/core/styling/app_colors.dart';
import 'package:weather_app/features/details/data/api.dart';
import 'package:weather_app/weather_data/lists.dart';
import 'package:weather_app/weather_data/models/current_weather_model.dart';
import 'package:weather_app/weather_data/models/days_weather_model.dart';
import 'package:weather_app/weather_data/models/hourly_weather_model.dart';
import 'package:weather_app/weather_data/weather_api.dart';

class HomeAPI {
  String apiKey = WeatherAPI.apiKey;

  Future<void> currentWeather(String city, BuildContext context) async {
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
      Provider.of<AppColors>(context, listen: false).isNightFunction(isNight);
      String image =
          WeatherAPI().getImage(current["condition"]["text"], isNight);
      WeatherLists.currentState = CurrentWeatherModel(
          temp: current["temp_c"].toInt(),
          maxTemp: forecast[0]["day"]["maxtemp_c"].toInt(),
          minTemp: forecast[0]["day"]["mintemp_c"].toInt(),
          weather: current["condition"]["text"],
          image: image,
          cityName: location["name"],
          countryName: location["country"],
        hour : hour
      );
      int i = 0;
      if (hour < 18) {
        i = 1;
      } else {
        i = 2;
      }

      addHourlyWeatherData(forecast, hour, i);
      addDaysWeatherData(forecast);
      DetailsAPI().currentDetailsWeather(city, context);
    }
  }

  void addHourlyWeatherData(List forecast, int index, int days) {
    WeatherLists.hourlyWeather.clear();
    List hours = forecast[0]["hour"];
    for (int hour = index; hour < hours.length; hour++) {
      String localtime = hours[hour]["time"];
      DateTime dateTime = DateTime.parse(localtime);

      int hourTime = dateTime.hour;
      String aOrP = "";
      bool isNight = WeatherAPI().getHour(localtime);

      if (hour > 12) {
        hourTime -= 12;
        aOrP = "PM";
      } else {
        aOrP = "AM";
      }
      String image =
          WeatherAPI().getImage(hours[hour]["condition"]["text"], isNight);
      WeatherLists.hourlyWeather.add(HourlyWeatherModel(
          hour: "$hourTime $aOrP",
          weather: hours[hour]["condition"]["text"],
          image: image,
          temp: hours[hour]["temp_c"].toInt()));
    }
    if (days == 2) {
      hours = forecast[1]["hour"];
      for (int hour = 0; hour < index; hour++) {
        String localtime = hours[hour]["time"];
        DateTime dateTime = DateTime.parse(localtime);

        int hourTime = dateTime.hour;
        String aOrP = "";
        bool isNight = WeatherAPI().getHour(localtime);

        if (hour > 12) {
          hourTime -= 12;
          aOrP = "PM";
        } else {
          aOrP = "AM";
        }
        String image =
            WeatherAPI().getImage(hours[hour]["condition"]["text"], isNight);
        WeatherLists.hourlyWeather.add(HourlyWeatherModel(
            hour: "$hourTime $aOrP",
            weather: hours[hour]["condition"]["text"],
            image: image,
            temp: hours[hour]["temp_c"].toInt()));
      }
    }
  }

  void addDaysWeatherData(List days) {
    WeatherLists.daysWeather.clear();
    for (var day in days) {
      String localtime = day["date"];
      DateTime dateTime = DateTime.parse(localtime);
      int weekdayNumber = dateTime.weekday;

      List<String> daysArabic = [
        "Mon",
        "tue",
        "wed",
        "thu",
        "fri",
        "sat",
        "sun"
      ];

      String weekdayName = daysArabic[weekdayNumber - 1];
      String image =
          WeatherAPI().getImage(day["day"]["condition"]["text"], false);
      WeatherLists.daysWeather.add(DaysWeatherModel(
          day: weekdayName,
          weather: day["day"]["condition"]["text"],
          image: image,
          temp: day["day"]["maxtemp_c"].toInt()));
    }
  }
}
