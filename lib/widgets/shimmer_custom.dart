import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCustom {
  static Widget baseShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.2),
      highlightColor: Colors.grey.withOpacity(0.3),
      child: Container(
        color: Colors.white,
      ),
    );
  }
}
