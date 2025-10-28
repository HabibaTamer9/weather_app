import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/styling/app_colors.dart';
import 'package:weather_app/core/styling/size.dart';
import 'package:weather_app/core/widgets/weather_background.dart';
import 'package:weather_app/features/home_screen/data/home_api.dart';
import 'package:weather_app/features/home_screen/widgets/bottom_container.dart';
import 'package:weather_app/features/home_screen/widgets/bottombar.dart';
import 'package:weather_app/features/home_screen/widgets/cloud_move.dart';
import 'package:weather_app/features/home_screen/widgets/rain_effect.dart';
import 'package:weather_app/features/home_screen/widgets/sun.dart';
import 'package:weather_app/features/home_screen/widgets/weather_data.dart';
import 'package:weather_app/features/search/cities_search.dart';
import 'package:weather_app/weather_data/lists.dart';
import 'package:weather_app/weather_data/models/current_weather_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<void> _refresh() async {
    HomeAPI().currentWeather(WeatherLists.currentState.cityName, context);
    await Future.delayed(Duration(seconds: 2));

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AppColors>(builder: (context, color, child) {
        CurrentWeatherModel list = WeatherLists.currentState;
        return SizedBox(
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: RefreshIndicator(
            onRefresh: _refresh,
            color: color.cardColor1,
            backgroundColor: Colors.white,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Stack(
                children: [
                SizedBox(
                height: 844.h,
                width: double.infinity,
                child: list.weather.contains("Clear") ||
                    list.weather.contains("Sunny")
                    ? AnimatedSwitcher(
                  duration: const Duration(seconds: 2), // مدة الفيد
                  child: color.isNight
                      ? Image.asset(
                    "assets/images/background.png",
                    key: const ValueKey('night'),
                    fit: BoxFit.fill,

                    height: double.infinity,
                    width: double.infinity,
                  )
                      : Image.asset(
                    "assets/images/light_background.jpg",
                    key: const ValueKey('day'),
                    fit: BoxFit.fill,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                ) : AnimatedSwitcher(
                  duration: const Duration(seconds: 2), // مدة الفيد
                  child: color.isNight
                      ? Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                color.cardColor2,
                                AppColors().backgroundColor2,
                                AppColors().backgroundColor1
                              ],
                              begin: Alignment.bottomRight,
                              end: Alignment.topLeft)))
                      : Image.asset(
                    "assets/images/light_background.jpg",
                    fit: BoxFit.fill,
                    height: double.infinity,
                    width: double.infinity,
                  )),
                ),
                list.weather.contains("cloudy") ||
                    list.weather.contains("Cloudy") ||
                    list.weather.contains("Overcast")
                    ? MovingClouds()
                    : SizedBox(),
                list.weather.contains("Sunny")
                    ? Positioned(
                    top: 0,
                    bottom: AppSize.height * 0.3,
                    child: Sun(hour: list.hour, image: list.image))
                    : SizedBox(),
                Positioned(
                    top: 90.h,
                    right: 0,
                    left: 0,
                    bottom: 0,
                    child: WeatherData()),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: BottomBar(),
                  //other params
                ),
                list.weather.contains("rain") ? RainEffect() : SizedBox(),
                Positioned(bottom: 50.h, child: BottomContainer()),
                Positioned(
                    bottom: 20.h,
                    right: 0,
                    left: 0,
                    child: Center(
                      child: Container(
                        width: 70.w,
                        height: 70.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                        child: IconButton(
                          onPressed: () =>
                              showSearch(
                                  context: context, delegate: CitiesSearch()),
                          icon: Icon(
                            Icons.add,
                            color: color.smallCardColor2,
                            size: 50.sp,
                          ),
                        ),
                      ),
                    ))
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
