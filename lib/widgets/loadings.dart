import 'package:aktuel_urunler_bim_a101_sok/widgets/lottie_main.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Loadings {
  static Widget baseShimmer(Color color) {
    return Shimmer.fromColors(
      baseColor: color.withOpacity(0.2),
      highlightColor: Colors.grey.withOpacity(0.3),
      child: Container(
        color: Colors.white,
      ),
    );
  }

  static Widget animatedLoadingText() {
    return AnimatedTextKit(
      animatedTexts: [
        TyperAnimatedText(
          "İçerik yükleniyor...",
          textStyle: const TextStyle(fontSize: 16),
        ),
        TyperAnimatedText(
          "Lütfen bekleyin...",
          textStyle: const TextStyle(fontSize: 16),
        ),
        TyperAnimatedText(
          "Az kaldı...",
          textStyle: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  static Widget manWalkinLottie() {
    return const Center(
      child: LottieMain(
        lottiePath: "assets/lotties/walking_man.json",
      ),
    );
  }
}
