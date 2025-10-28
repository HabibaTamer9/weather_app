import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/styling/app_colors.dart';

class WeatherSmallCard extends StatelessWidget {
  const WeatherSmallCard(
      {super.key,
      required this.time,
      required this.image,
      required this.temp,
      this.cardColor});

  final String time;
  final String image;
  final int temp;
  final Color? cardColor;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppColors>(builder: (context, color, child) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(100.0.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 13.0, sigmaY: 12.0),
          child: Container(
            padding: EdgeInsets.only(top: 8.h),
            margin: EdgeInsets.all(5),
            width: 65.w,
            height: 150.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.0.r),
              border: Border.all(
                color: Colors.white.withOpacity(0.2), // حدود خفيفة
                width: 1.5.w,
              ),
              color: cardColor != null
                  ? cardColor?.withOpacity(0.5)
                  : color.smallCardColor2.withOpacity(0.5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  time,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(fontSize: 17.sp),
                ),
                SizedBox(width: 44.w, height: 40.h, child: Image.asset(image)),
                Text(
                  "$temp°",
                  style: Theme.of(context).textTheme.labelLarge,
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
