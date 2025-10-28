import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/styling/app_colors.dart';
import 'package:weather_app/core/styling/size.dart';
import 'package:weather_app/core/widgets/weather_background.dart';
import 'package:weather_app/features/home_screen/data/home_api.dart';
import 'package:weather_app/features/search/data/search_api.dart';
import 'package:weather_app/weather_data/lists.dart';

class CitiesSearch extends SearchDelegate {
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
        titleLarge: TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
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
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Container(
      decoration: WeatherBackground().searchBackGround(),
      child: ListView.builder(
          itemCount: WeatherLists.searchCities.length,
          itemBuilder: (context, i) {
            String cityName = WeatherLists.searchCities[i];
            return ListTile(
              title: Text(
                cityName,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            );
          }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return FutureBuilder(
        future: SearchAPI().getCitiesSearchWeather(query),
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
          } else if (!snapshot.hasData) {
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
            var list = snapshot.data as List;
            return Stack(
              children: [
                Container(
                  height: AppSize.height,
                  width: AppSize.width,
                  decoration: WeatherBackground().searchBackGround(),
                  child: ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, i) {
                        String cityName = list[i]["name"];
                        return GestureDetector(
                          onTap: () async{

                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => Center(
                                      child: CircularProgressIndicator(),
                                    ));
                            await HomeAPI().currentWeather(cityName, context);
                            if (!context.mounted) return;
                              Navigator.pop(context);
                              Navigator.pop(context);
                          },
                          child: ListTile(
                            title: Text(
                              cityName,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        );
                      }),
                ),
              ],
            );
          }
        });
  }
}
