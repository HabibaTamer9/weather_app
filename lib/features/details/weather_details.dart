import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/styling/app_colors.dart';
import 'package:weather_app/core/styling/size.dart';
import 'package:weather_app/core/widgets/weather_small_card.dart';
import 'package:weather_app/features/details/widgets/details_container.dart';
import 'package:weather_app/features/details/widgets/sunrise.dart';
import 'package:weather_app/weather_data/lists.dart';
import 'package:weather_app/weather_data/models/hourly_weather_model.dart';
import 'package:weather_app/weather_data/models/weather_details_model.dart';

class WeatherDetails extends StatelessWidget {
  WeatherDetails({super.key});

  final WeatherDetailsModel details = WeatherLists.weatherDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AppColors>(builder: (context, color, child) {
        return Container(
          padding: EdgeInsets.only(
              top: AppSize.height * 0.05, left: 18.w, right: 18.w),
          height: AppSize.height,
          width: AppSize.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            color.detailsBackgroundColor1,
            color.detailsBackgroundColor2,
            color.detailsBackgroundColor2,
          ], begin: Alignment.bottomRight, end: Alignment.topLeft)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      details.cityName,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${details.temp}°",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: Colors.grey.shade400),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 5.w, vertical: 2.h),
                          color: Colors.grey.shade400,
                          width: 2.w,
                          child: Text(""),
                        ),
                        Text(
                          details.weather,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: Colors.grey.shade400),
                        ),
                      ],
                    ),
                  ],
                ),
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
                Sunrise(
                  sunrise: details.sunrise,
                  sunset: details.sunset,
                ),
                GridView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20.h,
                      crossAxisSpacing: 20.w,
                      mainAxisExtent: 160.h),
                  children: [
                    DetailsContainer(
                        icon: Icon(
                          Icons.thermostat,
                          size: 25.sp,
                        ),
                        title: "Feels like",
                        content: "${details.feelsLike}°"),
                    DetailsContainer(
                        icon: Icon(Icons.air, size: 25.sp),
                        title: "Wind",
                        content: "${details.windSpeed} km/h"),
                    DetailsContainer(
                        icon: Icon(Icons.water_drop_outlined, size: 25.sp),
                        title: "Humidity",
                        content: "${details.humidity}%"),
                    DetailsContainer(
                        icon: Icon(Icons.sunny, size: 25.sp),
                        title: "UV",
                        content: "${details.uv}"),
                    DetailsContainer(
                        icon: Icon(Icons.visibility_outlined, size: 25.sp),
                        title: "Visibility",
                        content: "${details.visibility} km"),
                    DetailsContainer(
                        icon: Icon(Icons.speed, size: 25.sp),
                        title: "Pressure",
                        content: "${details.pressure} hPa"),
                  ],
                ),
                SizedBox(
                  height: AppSize.height * 0.1,
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
