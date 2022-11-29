import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jdolh_flutter/core/utils/app_light_color.dart';
import 'package:jdolh_flutter/core/utils/global_utils.dart';

class AccountOptionsComponent extends StatelessWidget {
  const AccountOptionsComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        accountOptionItem(context, icon: 'assets/images/account_friends.svg', text: 'قائمة الأصدقاء'),
        accountOptionItem(context, icon: 'assets/images/account_groups.svg', text: 'المجموعات'),
        accountOptionItem(context, icon: 'assets/images/account_invoice.svg', text: 'الفواتير'),
        accountOptionItem(context, icon: 'assets/images/account_wallet.svg', text: 'المحفظة'),
        accountOptionItem(context, icon: 'assets/images/logout.svg', text: 'تسجيل خروج', hasArrow: false),
      ],
    );
  }

  Container accountOptionItem(BuildContext context, {required String icon, required String text, bool hasArrow = true}) {
    return Container(
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
                width: 20,
              ),
              horizontal(8),
              Text(
                text,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          if (hasArrow) Icon(Ionicons.chevron_back, size: 18)
        ],
      ),
    );
  }
}
