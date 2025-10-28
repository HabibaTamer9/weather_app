import 'package:flutter/material.dart';
import 'package:weather_app/core/styling/size.dart';

class MovingClouds extends StatefulWidget {
  const MovingClouds({super.key});

  @override
  State<MovingClouds> createState() => _MovingCloudsState();
}

class _MovingCloudsState extends State<MovingClouds>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers = [];

  @override
  void initState() {
    super.initState();

    // 4 controllers بسرعات مختلفة
    for (int i = 0; i < 4; i++) {
      Future.delayed(Duration(seconds: i * 3), () {
        if (mounted) _controllers[i].repeat(); // يبدأ بعد التأخير المحدد
      });
      _controllers.add(AnimationController(
        vsync: this,
        duration: Duration(seconds: 40 + i * 10), // سرعات مختلفة بسيطة
      ));

      // استخدمي delay بسيط للبداية فقط

    }
  }

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: AppSize.height*0.5,
      width: double.infinity,
      child: Stack(
        children: List.generate(4, (i) {
          return AnimatedBuilder(
            animation: _controllers[i],
            builder: (context, child) {
              final double xPos = width * (_controllers[i].value * 1.2 - 0.2);
              final double yPos = 50.0 + i * 60;

              return Positioned(
                left: xPos,
                top: yPos,
                child: Opacity(
                  opacity: 0.8 - i * 0.01,
                  child: Image.asset(
                    "assets/images/cloud.png",
                    width: 100 + i * 10,
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
