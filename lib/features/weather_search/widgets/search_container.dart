import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/styling/app_colors.dart';

class SearchContainer extends StatelessWidget {
  const SearchContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          AppColors().backgroundColor1,
          AppColors().backgroundColor1.withOpacity(0.7),
          AppColors().backgroundColor2,
        ],
          begin: Alignment.bottomRight,
          end: Alignment.topLeft
        ),
          borderRadius: BorderRadius.circular(10.r)
      ),
      margin: EdgeInsets.only(top: 10).h,
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      height: 36.h,
      child: Row(
        children: [
          Icon(Icons.search , color: AppColors().subtextColor,),
          SizedBox(width: 5.w,),
          Text("Search For a city", style: Theme.of(context).textTheme.bodySmall,)
        ],
      )
    );
  }
}
