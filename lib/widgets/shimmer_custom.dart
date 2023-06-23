import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCustom {
  static Widget baseShimmer(Color color) {
    return Shimmer.fromColors(
      baseColor: color.withOpacity(0.2),
      highlightColor: Colors.grey.withOpacity(0.3),
      child: Container(
        color: Colors.white,
      ),
    );
  }
}
