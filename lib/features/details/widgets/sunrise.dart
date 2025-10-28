import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/styling/app_colors.dart';
import 'package:weather_app/core/styling/size.dart';

class Sunrise extends StatelessWidget {
  const Sunrise({super.key, required this.sunrise, required this.sunset});
  final String sunrise;
  final String sunset;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppColors>(
      builder: (context , color ,child) {
        return Container(
          width: AppSize.width * 0.9,
          height: 185.h,
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22.r),
              border: Border.all(color: AppColors().subtextColor),
              color: Colors.black.withOpacity(0.2)),
          child: Stack(
            children: [
              Positioned(
                bottom: 50.h,
                child: Container(
                  height: 1,
                  width: AppSize.width*0.9,
                  color: AppColors().subtextColor,
                ),
              ),
              Positioned(
                  bottom: 50.h,
                  left: 4.w,
                  right: 4.w,
                  child: ClipPath(
                    clipper: HalfCircleClipper(),
                    child: Container(
                      width: AppSize.width * 0.9,
                      height: 150.h,
                      color: Colors.black.withOpacity(0.4),
                    ),
                  )),
              Positioned(
                  top:40.h,
                  right: 100.w,
                  left: 100.w,
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [BoxShadow(
                       color: Color(0xFF5936B4),
                        blurRadius: 80.r,
                      )]
                    ),
                    child: Icon(
                      color.isNight ?Icons.nightlight :Icons.sunny,
                      size: 40.sp,
                      color:color.isNight? Colors.white: Colors.amber,
                    ),
                  )),
              Positioned(
                  bottom: 15.h,
                  left: 15.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "sunrise",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.grey.shade400),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        sunrise,
                        style: Theme.of(context).textTheme.bodyMedium,
                      )
                    ],
                  ),),
              Positioned(
                  bottom: 15.h,
                  right: 15.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "sunset",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.grey.shade400),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        sunset,
                        style: Theme.of(context).textTheme.bodyMedium,
                      )
                    ],
                  ),),

            ],
          ),
        );
      }
    );
  }
}

class HalfCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height);
    path.quadraticBezierTo(size.width / 2, 0, size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
