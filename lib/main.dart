import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jdolh_flutter/auth/presentation/controller/auth_controller.dart';
import 'package:jdolh_flutter/auth/presentation/screens/signin_screen.dart';
import 'package:jdolh_flutter/core/services/service_locator.dart';
import 'package:jdolh_flutter/core/utils/app_light_color.dart';
import 'package:jdolh_flutter/core/utils/theme.dart';
import 'package:jdolh_flutter/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:jdolh_flutter/firebase_options.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  ServiceLocator().init();
  runApp(App());
}

///// App /////
class App extends StatelessWidget {
  App({super.key});
  final AuthController authController = Get.put(AuthController(sl(), sl(), sl(), sl()));

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
      home: authController.localAuthUsecases.readIsLogin() != true ? SigninScreen() : DashboardScreen(),
      theme: lightTheme,
      locale: const Locale("ar"),
      fallbackLocale: const Locale("ar"),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        SfGlobalLocalizations.delegate
      ],
      supportedLocales: [
        Locale('ar'),
      ],
    );
  }
}
