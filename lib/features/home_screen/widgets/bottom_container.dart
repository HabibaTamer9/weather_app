import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/styling/app_colors.dart';
import 'package:weather_app/core/widgets/weather_small_card.dart';
import 'package:weather_app/weather_data/lists.dart';
import 'package:weather_app/weather_data/models/days_weather_model.dart';
import 'package:weather_app/weather_data/models/hourly_weather_model.dart';

class BottomContainer extends StatelessWidget {
  const BottomContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppColors>(builder: (context, color, child) {
      return DefaultTabController(
        length: 2,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25.0.r), // حواف دائرية
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
            // قيمة الـBlur
            child: Container(
              width: 390.w,
              height: 275.h,
              decoration: BoxDecoration(
                color: color.detailsBackgroundColor1.withOpacity(0.5),
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      color.backgroundColor2,
                      color.backgroundColor1,
                      color.cardColor2,
                      color.cardColor2
                    ]),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.r),
                    topRight: Radius.circular(25.r),
                    bottomLeft: Radius.circular(50.r),
                    bottomRight: Radius.circular(50.r)),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2), // حدود خفيفة
                  width: 1.5.w,
                ),
              ),
              // هنا تضع محتويات الـUI اللي داخل الكونتينر (مثل نصوص و أيقونات)
              child: Padding(
                padding: const EdgeInsets.all(10.0).h,
                child: Column(
                  children: [
                    TabBar(
                        indicatorColor: Colors.white60,
                        dividerColor: Colors.grey,
                        labelStyle: Theme.of(context).textTheme.bodySmall,
                        unselectedLabelStyle:
                            Theme.of(context).textTheme.bodySmall,
                        tabs: [
                          Tab(
                            child: Text("Hourly Forecast"),
                          ),
                          Tab(
                            child: Text("Weekly Forecast"),
                          )
                        ]),
                    Container(
                      margin: EdgeInsets.only(bottom: 20.h),
                      height: 150.h,
                      width: 390.w,
                      child: TabBarView(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 10.h, left: 10.w),
                            width: 390.w,
                            height: 150.h,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: WeatherLists.hourlyWeather.length,
                                itemBuilder: (context, index) {
                                  HourlyWeatherModel list =
                                      WeatherLists.hourlyWeather[index];
                                  if (index == 0) {
                                    return WeatherSmallCard(
                                      time: "Now",
                                      image: list.image,
                                      temp: list.temp,
                                      cardColor: color.cardColor2,
                                    );
                                  } else {
                                    return WeatherSmallCard(
                                        time: list.hour,
                                        image: list.image,
                                        temp: list.temp);
                                  }
                                }),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10, left: 10),
                            width: 390.w,
                            height: 150.h,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: WeatherLists.daysWeather.length,
                                itemBuilder: (context, index) {
                                  DaysWeatherModel list =
                                      WeatherLists.daysWeather[index];
                                  if (index == 0) {
                                    return WeatherSmallCard(
                                      time: "Today",
                                      image: list.image,
                                      temp: list.temp,
                                      cardColor: color.cardColor2,
                                    );
                                  } else {
                                    return WeatherSmallCard(
                                        time: list.day,
                                        image: list.image,
                                        temp: list.temp);
                                  }
                                }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
