import 'package:flutter/material.dart';
import 'package:jdolh_flutter/auth/presentation/controller/auth_controller.dart';
import 'package:jdolh_flutter/core/services/service_locator.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});
  AuthController authController = AuthController(sl(), sl(), sl(), sl());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Text(authController.localAuthUsecases.readToken()),
          Text(authController.localAuthUsecases.readIsLogin().toString()),
          Text(authController.localAuthUsecases.readUserId().toString()),
        ],
      )),
    );
  }
}
