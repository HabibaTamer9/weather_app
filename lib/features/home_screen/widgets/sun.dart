import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Sun extends StatelessWidget {
  const Sun({super.key, required this.hour, required this.image});
  final int hour;
  final String image;

  double getSunX(int hour, double width) {
    // 6 AM → 6 PM mapped to 0 → π
    double angle = ((hour - 6) / 12) * 3.14159;
    return width / 5 + cos(angle) * (width / 3);
  }

  double getSunY(int hour, double height) {
    double angle = ((hour - 6) / 12) * 3.14159;
    return height / 1.7 - sin(angle) * (height / 2);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final sunX = getSunX(hour, width);
    final sunY = getSunY(hour, height);

    return SizedBox(
      height: 600.h,
      width: 400.w,
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(seconds: 2),
            left: sunX,
            top: sunY,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.amber.withOpacity(0.3),
                    blurRadius: 50,
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: Image.asset(
                image,
                width: 180.w,
                height: 180.h,
              ),
            )
          ),
        ],
      ),
    );
  }
}
