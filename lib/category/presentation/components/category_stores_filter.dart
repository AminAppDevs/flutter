import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jdolh_flutter/core/utils/app_light_color.dart';
import 'package:jdolh_flutter/core/utils/global_utils.dart';

Container categoryStoresFilter(BuildContext context) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade200, width: 1)),
      ),
      child: Row(
        children: [
          categoryFilterSelect(context, icon: Ionicons.location_outline, text: 'حسب المدينة'),
          horizontal(5),
          categoryFilterSelect(context, icon: Ionicons.star_outline, text: 'حسب التقييم'),
        ],
      ),
    );

Expanded categoryFilterSelect(BuildContext context, {required IconData icon, required String text}) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 8),
      decoration: BoxDecoration(
        color: AppLightColor.inputBgColor,
        border: Border.all(color: HexColor('#ECECF1')),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: AppLightColor.labelColor, size: 18),
              horizontal(3),
              Text(
                text,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(height: 2, fontSize: 12),
              ),
            ],
          ),
          Icon(Ionicons.chevron_down, color: AppLightColor.labelColor, size: 16),
        ],
      ),
    ),
  );
}
