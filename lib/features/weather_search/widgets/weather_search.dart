import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/styling/app_colors.dart';
import 'package:weather_app/core/styling/size.dart';
import 'package:weather_app/core/widgets/weather_background.dart';
import 'package:weather_app/core/widgets/weather_card.dart';
import 'package:weather_app/features/weather_search/data/weather_search_api.dart';
import 'package:weather_app/weather_data/lists.dart';
import 'package:weather_app/weather_data/models/current_weather_model.dart';

class WeatherSearch extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors().backgroundColor2,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 18.sp,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white70),
        focusColor: Colors.white,
      ),
        textTheme: TextTheme(
            headlineLarge: TextStyle(
                fontSize: 40.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white
            ),
            titleLarge: TextStyle(

                color: Colors.white),
            titleMedium: TextStyle(
                fontSize: 90,
                fontWeight: FontWeight.w300,
                color: Colors.white
            ),
            titleSmall: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
                color: AppColors().textColor),
            bodyLarge: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                color: AppColors().textColor),
            bodyMedium: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: AppColors().textColor),
            bodySmall: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppColors().subtextColor),
            labelLarge: TextStyle(
                color: AppColors().textColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600))
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {

    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: AppSize.height,
          width: AppSize.width,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          decoration: WeatherBackground().searchBackGround(),
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: WeatherLists.search.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 15).h,
                child: WeatherCard(
                  i: index,
                  list: WeatherLists.search,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
        future: WeatherSearchAPI().getWeatherSearchList(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                height: AppSize.height,
                width: AppSize.width,
                decoration: WeatherBackground().searchBackGround(),
                child: Center(child: CircularProgressIndicator()));
          } else if (snapshot.hasError) {
            return Container(
                height: AppSize.height,
                width: AppSize.width,
                decoration: WeatherBackground().searchBackGround(),
                child: Center(
                    child: Text(
                      "Field loading data ",
                      style: TextStyle(color: Colors.white),
                    )));
          } else if (snapshot.data!.isEmpty) {
            return Container(
                height: AppSize.height,
                width: AppSize.width,
                decoration: WeatherBackground().searchBackGround(),
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "🔍",
                            style: TextStyle(fontSize: 35.sp),
                          ),
                          Text(
                            "No results",
                            style: TextStyle(color: Colors.grey, fontSize: 25.sp),
                          )
                        ])));
          } else {
            final List<CurrentWeatherModel>? list = snapshot.data;
            return Stack(
              children: [
                Container(
                  height: AppSize.height,
                  width: AppSize.width,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  decoration: WeatherBackground().searchBackGround(),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: list?.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                        const EdgeInsets.symmetric(vertical: 15).h,
                        child: WeatherCard(
                          i: index,
                          list: list!,
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        });
  }
}
