import 'dart:math';
import 'package:flutter/material.dart';

class RainEffect extends StatefulWidget {
  const RainEffect({super.key});

  @override
  State<RainEffect> createState() => _RainEffectState();
}

class _RainEffectState extends State<RainEffect> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Random _random = Random();
  List<Offset> _drops = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {
          _drops = List.generate(30, (index) {
            double x = _random.nextDouble() * MediaQuery.of(context).size.width;
            double y = (_random.nextDouble() * MediaQuery.of(context).size.height + _controller.value * 10) %
                MediaQuery.of(context).size.height;
            return Offset(x, y);
          });
        });
      })
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _RainPainter(_drops),
      child: Container(),
    );
  }
}

class _RainPainter extends CustomPainter {
  final List<Offset> drops;
  _RainPainter(this.drops);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.6)
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;

    for (var drop in drops) {
      canvas.drawLine(drop, Offset(drop.dx+5, drop.dy + 10), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
