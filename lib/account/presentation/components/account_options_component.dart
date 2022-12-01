import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jdolh_flutter/account/presentation/controller/account_controller.dart';
import 'package:jdolh_flutter/account/presentation/screens/groups_screen.dart';
import 'package:jdolh_flutter/core/utils/app_light_color.dart';
import 'package:jdolh_flutter/core/utils/global_utils.dart';

class AccountOptionsComponent extends StatelessWidget {
  AccountOptionsComponent({super.key});
  final AccountController accountController = Get.find();

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        accountOptionItem(
          context,
          icon: 'assets/images/account_friends.svg',
          text: 'قائمة الأصدقاء',
          onTap: () {},
        ),
        accountOptionItem(context, icon: 'assets/images/account_groups.svg', text: 'المجموعات', onTap: () {
          accountController.getUserGroups();
          Get.to(() => GroupsScreen());
        }),
        accountOptionItem(
          context,
          icon: 'assets/images/account_invoice.svg',
          text: 'الفواتير',
          onTap: () {},
        ),
        accountOptionItem(
          context,
          icon: 'assets/images/account_wallet.svg',
          text: 'المحفظة',
          onTap: () {},
        ),
        accountOptionItem(
          context,
          icon: 'assets/images/logout.svg',
          text: 'تسجيل خروج',
          hasArrow: false,
          onTap: () {},
        ),
      ],
    );
  }

  InkWell accountOptionItem(BuildContext context,
      {required String icon, required String text, bool hasArrow = true, required void Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
          color: AppLightColor.inputBgColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  icon,
                  width: 18,
                ),
                horizontal(5),
                Text(
                  text,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
            if (hasArrow)
              Icon(
                Ionicons.chevron_back,
                size: 15,
                color: Colors.grey,
              ),
          ],
        ),
      ),
    );
  }
}
