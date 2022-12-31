import 'package:flutter/material.dart';

class ShimmerEffect {
  static Container shimmerBox({double width = 0, double height = 0, required double borderRaduis}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(borderRaduis),
      ),
    );
  }
}
