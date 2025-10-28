import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/styling/app_colors.dart';
import 'package:weather_app/weather_data/lists.dart';
import 'package:weather_app/weather_data/models/current_weather_model.dart';

class WeatherCard extends StatefulWidget {
  const WeatherCard({super.key, required this.i, required this.list});

  final List<CurrentWeatherModel> list;
  final int i;

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  CurrentWeatherModel cityWeather = WeatherLists.citiesWeather[0];
  Color color1 = Color(0xFF362A84);
  Color color2 = Color(0xFF5936B4);

  @override
  void initState() {
    // TODO: implement initState
    cityWeather = widget.list[widget.i];
    if(cityWeather.isNight == false){
      color1 = AppColors().cardColor3;
      color2 = AppColors().cardColor4;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(math.pi),
            child: ClipPath(
              clipper: RoundedDiagonalPathClipper(),
              child: Container(
                width: 338.w,
                height: 185.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [color2, color1],
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft),
                  borderRadius: BorderRadius.all(Radius.circular(20.0.r)),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: 20.h,
          left: 20.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0).h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${cityWeather.temp}°",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontSize: 70.sp),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0).h,
                        child: Text(
                          "H:${cityWeather.maxTemp}° , L:${cityWeather.minTemp}°",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                      Text(
                        "${cityWeather.cityName},${cityWeather.countryName}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0).h,
                  child: Column(
                    children: [
                      Container(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                offset: Offset(-55.w, 0.h),
                                color: color2.withOpacity(0.6),
                                blurRadius: 70,
                                spreadRadius: 5)
                          ]),
                          height: 150.h,
                          width: 150.w,
                          child: Image.asset(cityWeather.image)),
                      Text(
                        cityWeather.weather,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
