import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/styling/app_colors.dart';

class DetailsContainer extends StatelessWidget {
  const DetailsContainer(
      {super.key, required this.icon, required this.title, required this.content});

  final Icon icon;
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppColors>(
      builder: (context , color , child) {
        return Container(
          width: 165.w,
          height: 165.h,
          padding: EdgeInsets.all(25.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22.r),
              border: Border.all(color: color.subtextColor),
              color: Colors.black.withOpacity(0.2),

          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              icon,
              SizedBox(height: 10.h,),
              Container(
                decoration: BoxDecoration(
                    boxShadow: [BoxShadow(
                        color: color.cardColor1,
                        blurRadius: 70,
                        spreadRadius: 5
                    )]
                ),
                child: Text(title,style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.grey.shade400),),
              ),
              SizedBox(height: 5.h,),
              Text(content ,style: Theme.of(context)
                  .textTheme
                  .titleSmall,)
            ],
          ),
        );
      }
    );
  }
}
