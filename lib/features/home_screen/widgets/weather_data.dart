import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/styling/app_colors.dart';
import 'package:weather_app/weather_data/lists.dart';

class WeatherData extends StatelessWidget {
  const WeatherData({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppColors>(
      builder: (context, color , child) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                WeatherLists.currentState.cityName,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                "${WeatherLists.currentState.temp}°",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  height: 0.9,
                ),
              ),
              Text(
                WeatherLists.currentState.weather,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: Colors.grey.shade400),
              ),
              Text(
                "H:${WeatherLists.currentState.maxTemp}° L:${WeatherLists.currentState.minTemp}°",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(
                height: 10.h,
              ),color.isNight ?
              Image.asset("assets/images/House.png"):
              Image.asset("assets/images/house2.png"),
            ]);
      }
    );
  }
}
