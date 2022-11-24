import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jdolh_flutter/auth/presentation/screens/signin_screen.dart';
import 'package:jdolh_flutter/core/services/service_locator.dart';
import 'package:jdolh_flutter/core/utils/app_light_color.dart';
import 'package:jdolh_flutter/core/utils/theme.dart';

void main() {
  ServiceLocator().init();
  runApp(const App());
}

///// App /////z
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppLightColor.secondaryColor,
        statusBarBrightness: Brightness.light,
      ),
    );
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SigninScreen(),
      theme: lightTheme,
      locale: const Locale("ar"),
      fallbackLocale: const Locale("ar"),
    );
  }
}
