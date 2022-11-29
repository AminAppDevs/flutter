import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_flutter/account/presentation/components/account_shimmer.dart';
import 'package:jdolh_flutter/account/presentation/controller/account_controller.dart';
import 'package:jdolh_flutter/core/utils/app_light_color.dart';
import 'package:jdolh_flutter/core/utils/global_utils.dart';
import 'package:jdolh_flutter/core/utils/shimmer_effect.dart';

class UserAvatarComponent extends StatelessWidget {
  UserAvatarComponent({super.key});
  final AccountController accountController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(
      builder: (AccountController controller) => Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        if (controller.userDetails != null)
          Column(
            children: [
              CachedNetworkImage(
                imageUrl: accountController.userDetails!.avatar.imageUrl,
                placeholder: (context, url) => ShimmerEffect.shimmerBox(width: 100, height: 100, borderRaduis: 100),
                errorWidget: (context, url, error) => Icon(Icons.error),
                imageBuilder: (context, imageProvider) => Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: AppLightColor.inputBgColor, width: 3, strokeAlign: StrokeAlign.outside),
                      color: Colors.grey.shade200,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      )),
                ),
              ),
              vertical(10),
              Text(accountController.userDetails!.fullName, style: Theme.of(context).textTheme.headlineSmall),
              Text(
                '${accountController.userDetails!.phoneNumber}@',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      height: .7,
                    ),
              ),
            ],
          ),
        if (controller.userDetails == null) userAvatarShimmer(),
      ]),
    );
  }
}
