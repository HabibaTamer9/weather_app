import 'package:flutter/material.dart';
import 'package:weather_app/core/styling/size.dart';
import 'package:weather_app/features/home_screen/home.dart';
import 'package:weather_app/features/splash_screen/data/check_internet.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  checkInternet() async {
    bool checkInternet = await CheckInternet().hasNetwork(context);
    if (!checkInternet) {
      setState(() {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => Center(
                  child: AlertDialog(
                    title: Text("Error"),
                    content: Text(
                        "Please check your internet connection and try again."),
                  ),
                ));
      });
    }
  }

  @override
  void initState() {
    checkInternet();
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5), // سرعة الدوران
    )..repeat();
    Future.delayed(Duration(seconds: 8), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: AppSize.height,
        width: AppSize.width,
        child: Stack(
          children: [
            SizedBox(
                height: AppSize.height,
                width: AppSize.width,
                child: Image.asset(
                  "assets/images/light_background.jpg",
                  fit: BoxFit.fill,
                )),
            Positioned(
                top: AppSize.height * 0.1,
                child: RotationTransition(
                    turns: _controller,
                    child: Image.asset("assets/images/sun.png"))),
            SizedBox(
              height: AppSize.height,
              width: AppSize.width,
              child: ClipPath(
                clipper: TriangleClipper(),
                child: Image.asset(
                  "assets/images/background.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width, 0); // أعلى نقطة
    path.lineTo(0, size.height); // تحت يسار
    path.lineTo(size.width, size.height); // تحت يمين
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
