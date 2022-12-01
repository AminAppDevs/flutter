import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_flutter/core/utils/app_light_color.dart';
import 'package:jdolh_flutter/core/utils/global_utils.dart';

Container confirmRemove(BuildContext context, {required void Function()? onTap}) {
  return Container(
    height: 140,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
    ),
    child: Column(
      children: [
        Text('تأكيد الحذف', style: Theme.of(context).textTheme.titleLarge),
        vertical(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            removeConfirmButton(text: 'تأكيد الحذف', color: AppLightColor.redColor, onTap: onTap, context: context, textColor: Colors.white),
            horizontal(5),
            removeConfirmButton(
                text: 'تراجع',
                color: Colors.grey.shade200,
                onTap: () {
                  Get.back();
                },
                context: context,
                textColor: AppLightColor.subHeadingColor.withOpacity(.8)),
          ],
        ),
      ],
    ),
  );
}

InkWell removeConfirmButton(
    {required void Function()? onTap, required BuildContext context, required String text, required Color color, required Color textColor}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      child: Text(text, style: Theme.of(context).textTheme.titleMedium!.copyWith(color: textColor)),
    ),
  );
}
