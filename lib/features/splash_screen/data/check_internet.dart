import 'dart:io';

import 'package:flutter/material.dart';
import 'package:weather_app/features/home_screen/data/home_api.dart';
import 'package:weather_app/weather_data/weather_api.dart';

class CheckInternet{
  Future<bool> hasNetwork( BuildContext context) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        HomeAPI().currentWeather("cairo" , context);
        WeatherAPI().getCitiesWeather();
        return true;
      }
    } catch (_) {
      return false;
    }
    return false;
  }
}