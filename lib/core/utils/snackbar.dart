import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_flutter/core/utils/app_light_color.dart';

class AppSnackbar {
  static errorSnackbar({required String message}) {
    Get.snackbar(
      '',
      '',
      backgroundColor: AppLightColor.redColor,
      barBlur: 0,
      borderRadius: 0,
      margin: const EdgeInsets.all(0),
      colorText: Colors.white,
      snackStyle: SnackStyle.FLOATING,
      titleText: const SizedBox(),
      messageText: Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white,
            height: 1,
          ),
        ),
      ),
    );
  }

  static successSnackbar({required String message}) {
    Get.snackbar(
      '',
      '',
      backgroundColor: AppLightColor.primaryColor,
      barBlur: 0,
      borderRadius: 0,
      margin: const EdgeInsets.all(0),
      colorText: Colors.white,
      snackStyle: SnackStyle.FLOATING,
      titleText: const SizedBox(),
      messageText: Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white,
            height: 1,
          ),
        ),
      ),
    );
  }
}
