import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jdolh_flutter/account/presentation/components/account_shimmer.dart';
import 'package:jdolh_flutter/account/presentation/controller/account_controller.dart';
import 'package:jdolh_flutter/account/presentation/screens/followers_screen.dart';
import 'package:jdolh_flutter/account/presentation/screens/following_screen.dart';
import 'package:jdolh_flutter/core/utils/app_light_color.dart';
import 'package:jdolh_flutter/core/utils/global_utils.dart';

class FollowersFollowingCountComponent extends StatelessWidget {
  FollowersFollowingCountComponent({super.key});
  final AccountController accountController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(
      builder: (AccountController controller) => Column(
        children: [
          if (controller.userDetails != null)
            Row(
              children: [
                accountFollowBox(
                  controller,
                  context,
                  icon: 'assets/images/followers.svg',
                  count: controller.userDetails!.count.followers,
                  text: 'يتابعك',
                  color: AppLightColor.accountFollowerBg,
                  onTap: () {
                    accountController.getUserFollowers();
                    Get.to(() => FollowersScreen());
                  },
                ),
                horizontal(4),
                accountFollowBox(
                  controller,
                  context,
                  icon: 'assets/images/following.svg',
                  count: controller.userDetails!.count.following,
                  text: 'تتابعه',
                  color: AppLightColor.accountFollowingBg,
                  onTap: () {
                    accountController.getUserFollowing();
                    Get.to(() => FollowingScreen());
                  },
                ),
                horizontal(4),
                accountFollowBox(
                  controller,
                  context,
                  icon: 'assets/images/account_invite.svg',
                  count: controller.userDetails!.count.followers,
                  text: 'دعوات معلقة',
                  color: AppLightColor.accountInviteBg,
                  onTap: () {},
                ),
              ],
            ),
          if (controller.userDetails == null) followerFollowingCountShimmer(),
        ],
      ),
    );
  }

  Expanded accountFollowBox(AccountController controller, BuildContext context,
      {required String icon, required int count, required String text, required Color color, required void Function()? onTap}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: color,
          ),
          child: Column(
            children: [
              SvgPicture.asset(icon, height: 20),
              vertical(5),
              Text(
                count.toString(),
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.white,
                      height: 1.5,
                    ),
              ),
              Text(
                text,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Colors.white,
                      height: 1,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
