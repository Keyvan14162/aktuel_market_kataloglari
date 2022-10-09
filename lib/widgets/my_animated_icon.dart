import 'package:flutter/material.dart';

class MyAnimatedIcon {
  Widget animatedIconButton(
      String controller, AnimationController animationController) {
    if (controller == "bim") {
      return AnimatedIcon(
        icon: AnimatedIcons.menu_close,
        progress: animationController,
      );
    } else if (controller == "a101") {
      return AnimatedIcon(
        icon: AnimatedIcons.menu_close,
        progress: animationController,
      );
    } else if (controller == "sok") {
      return AnimatedIcon(
        icon: AnimatedIcons.menu_close,
        progress: animationController,
      );
    }
    return AnimatedIcon(
      icon: AnimatedIcons.menu_close,
      progress: animationController,
    );
  }

  animateIcon(String controller, AnimationController animationController,
      bool isAnimated) {
    if (controller == "bim") {
      isAnimated = !isAnimated;
      isAnimated
          ? animationController.forward()
          : animationController.reverse();
    } else if (controller == "a101") {
      isAnimated = !isAnimated;
      isAnimated
          ? animationController.forward()
          : animationController.reverse();
    } else if (controller == "sok") {
      isAnimated = !isAnimated;
      isAnimated
          ? animationController.forward()
          : animationController.reverse();
    }
  }
}
