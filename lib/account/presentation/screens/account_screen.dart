import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_flutter/account/presentation/components/account_options_component.dart';
import 'package:jdolh_flutter/account/presentation/components/fllowers_following_count_components.dart';
import 'package:jdolh_flutter/account/presentation/components/user_avatar_component.dart';
import 'package:jdolh_flutter/account/presentation/controller/account_controller.dart';
import 'package:jdolh_flutter/core/services/service_locator.dart';
import 'package:jdolh_flutter/core/utils/global_utils.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({super.key});
  final AccountController accountController = Get.put(AccountController(sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: Column(
              children: [
                vertical(10),
                UserAvatarComponent(),
                vertical(20),

                /// followers following
                FollowersFollowingCountComponent(),
                vertical(10),

                /// options list
                AccountOptionsComponent(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
