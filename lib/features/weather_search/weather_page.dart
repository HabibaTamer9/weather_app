import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/widgets/weather_background.dart';
import 'package:weather_app/core/widgets/weather_card.dart';
import 'package:weather_app/features/weather_search/data/weather_search_api.dart';
import 'package:weather_app/features/weather_search/widgets/search_container.dart';
import 'package:weather_app/features/weather_search/widgets/weather_search.dart';
import 'package:weather_app/weather_data/lists.dart';
import 'package:weather_app/weather_data/models/current_weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  List<CurrentWeatherModel> list = WeatherLists.citiesWeather;
  TextEditingController controller = TextEditingController();
  bool isLoading = false;

  search(String val) async {
    setState(() {
      isLoading = true;
    });
    WeatherLists.search.clear();
    await WeatherSearchAPI().getListSearchWeather(val);
    if (WeatherLists.search.isNotEmpty) {
      setState(() {
        list = WeatherLists.search;
      });
    }
    setState(() {
      isLoading = false;
      list = WeatherLists.search;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: WeatherBackground().backGround(),
        ),
        Positioned(
          top: 30.h,
          right: 20.h,
          left: 20.h,
          child: SizedBox(
            height: 844.h,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios)),
                    Center(
                      child: Text(
                        "Weather",
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                    SizedBox()
                  ],
                ),
                InkWell(
                  onTap: (){
                   showSearch(context: context, delegate: WeatherSearch());
                  },
                    child: SearchContainer()),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0).h,
                    child: isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15).h,
                                child: WeatherCard(
                                  i: index,
                                  list: list,
                                ),
                              );
                            },
                          ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
