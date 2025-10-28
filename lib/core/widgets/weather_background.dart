import 'package:flutter/material.dart';
import 'package:weather_app/core/styling/app_colors.dart';

class WeatherBackground {
  backGround() {
    return BoxDecoration(
        gradient: LinearGradient(
            colors: [
              AppColors().backgroundColor1,
              AppColors().backgroundColor1,
              AppColors().backgroundColor2
            ],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft
        )
    );
  }
  searchBackGround(){
    return BoxDecoration(gradient: LinearGradient(
        colors: [
          AppColors().backgroundColor1,
          AppColors().backgroundColor1,
          AppColors().backgroundColor1.withOpacity(0.95),
          AppColors().backgroundColor2,
          AppColors().backgroundColor2,

        ],
        begin: Alignment.bottomRight,
        end: Alignment.topLeft
    ));
  }
  detailsBackGround(){
    return BoxDecoration(gradient: LinearGradient(
        colors: [
          AppColors().detailsBackgroundColor1,
          AppColors().detailsBackgroundColor2,
          AppColors().detailsBackgroundColor2,

        ],
        begin: Alignment.bottomRight,
        end: Alignment.topLeft
    ));
  }
}

