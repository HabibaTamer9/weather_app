import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/styling/app_colors.dart';
import 'package:weather_app/features/details/weather_details.dart';
import 'package:weather_app/features/weather_search/weather_page.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppColors>(builder: (context, color, child) {
      return Container(
        height: 70.h,
        padding: EdgeInsets.only(right: 20.w, left: 20.w, top: 20.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            color.backgroundColor2,
            color.smallCardColor2,
          ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(seconds: 1),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            WeatherPage(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(-1.0, 0.0), // تبدأ من اليمين
                              end: Offset.zero, // وتنتهي في مكانها الطبيعي
                            ).animate(animation),
                            child: child,
                          );
                        },
                      ));
                },
                icon: Icon(
                  Icons.location_on,
                  size: 30.sp,
                )),
            SizedBox(),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(seconds: 1),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                             WeatherDetails(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(1.0, 0.0), // تبدأ من اليمين
                              end: Offset.zero, // وتنتهي في مكانها الطبيعي
                            ).animate(animation),
                            child: child,
                          );
                        },
                      ));
                },
                icon: Icon(
                  Icons.list,
                  size: 30.sp,
                ))
          ],
        ),
      );
    });
  }
}
