import 'package:flutter/cupertino.dart';
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
