import 'package:flutter/material.dart';
import 'package:jdolh_flutter/core/utils/app_light_color.dart';

SizedBox vertical(double size) => SizedBox(height: size);
SizedBox horizontal(double size) => SizedBox(width: size);
Container line(double width) => Container(
      width: width,
      height: 4,
      decoration: BoxDecoration(
        color: AppLightColor.primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
    );

Center loading({double width = 25, double height = 25, required Color color, double strokeWidth = 2}) => Center(
      child: SizedBox(width: width, height: height, child: CircularProgressIndicator(color: color, strokeWidth: strokeWidth)),
    );
