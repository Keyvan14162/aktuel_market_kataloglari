import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:math' as math;

class LottieMain extends StatefulWidget {
  LottieMain({required this.lottiePath, super.key});
  String lottiePath;

  @override
  State<LottieMain> createState() => _LottieMainState();
}

class _LottieMainState extends State<LottieMain> with TickerProviderStateMixin {
  double angle = 0.0;
  double rotationY = 0.0;
  double rotationX = 0.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          angle = angle + 0.05;
        });
      },
      onLongPress: () {
        setState(() {
          angle = 0;
        });
      },
      onHorizontalDragEnd: (details) {
        if (details.velocity.pixelsPerSecond.dx >
            details.velocity.pixelsPerSecond.dy) {
          // soldan saga
          if (rotationY == 0) {
            setState(() {
              rotationY = math.pi;
            });
          }
        } else {
          // sagdon sola
          if (rotationY != 0) {
            setState(() {
              rotationY = 0;
            });
          }
        }
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 4.2,
        width: MediaQuery.of(context).size.height / 4.2,
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationX(rotationX),
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(rotationY),
            child: Transform.rotate(
              angle: angle,
              child: Lottie.asset(
                widget.lottiePath,
                height: MediaQuery.of(context).size.height / 3,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
