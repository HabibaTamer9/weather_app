import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/styling/app_colors.dart';
import 'package:weather_app/features/home_screen/data/home_api.dart';
import 'package:weather_app/features/splash_screen/splash_screen.dart';
import 'package:weather_app/weather_data/weather_api.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (context)=>AppColors(),
  child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState


    super.initState();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_ , child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Weather',
          // You can use the library anywhere in the app even in theme
          theme:ThemeData(
              useMaterial3: true, // لو بتستخدمي Material 3
              colorScheme: ColorScheme.dark(
                background: AppColors().backgroundColor1,
                primary: AppColors().backgroundColor2,
                secondary: AppColors().textColor,
              ),
              appBarTheme: AppBarTheme(
                backgroundColor: AppColors().backgroundColor2,
                elevation: 0,
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
                iconTheme: IconThemeData(color: Colors.white),
              ),
              iconTheme: const IconThemeData(color: Colors.white),
              inputDecorationTheme: InputDecorationTheme(
                hintStyle: TextStyle(color: Colors.white70),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white38),
                ),
              ),
              textTheme: TextTheme(
                  headlineLarge: TextStyle(
                      fontSize: 40.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                  titleLarge: TextStyle(
                      fontSize: 40.sp,
                      fontWeight: FontWeight.w400,
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
                      fontWeight: FontWeight.w600))),
          themeMode: ThemeMode.system,
          home: child,
        );
      },
      child: SplashScreen(),
    );
  }
}