import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:jdolh_flutter/account/domain/entities/user.dart';
import 'package:jdolh_flutter/account/presentation/controller/account_controller.dart';
import 'package:jdolh_flutter/core/utils/app_light_color.dart';
import 'package:jdolh_flutter/core/utils/global_utils.dart';
import 'package:jdolh_flutter/core/utils/shimmer_effect.dart';

class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({super.key});
  final AccountController accountController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('تفاصيل الحساب'),
      ),
      body: GetBuilder<AccountController>(
        builder: (controller) {
          return controller.isUserProfileDetailsLoading
              ? Center(
                  child: SizedBox(
                    width: 25,
                    height: 25,
                    child: CircularProgressIndicator(
                      color: AppLightColor.primaryColor,
                      strokeWidth: 3,
                    ),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      if (controller.userProfileDetails != null)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              CachedNetworkImage(
                                imageUrl: controller.userProfileDetails!.avatar.imageUrl,
                                placeholder: (context, url) => ShimmerEffect.shimmerBox(width: 80, height: 80, borderRaduis: 80),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                                imageBuilder: (context, imageProvider) => Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(color: AppLightColor.inputBgColor, width: 3, strokeAlign: StrokeAlign.outside),
                                    color: Colors.grey.shade200,
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              vertical(5),
                              Text(accountController.userProfileDetails!.fullName, style: Theme.of(context).textTheme.headlineSmall),
                              Text('${accountController.userProfileDetails!.phoneNumber}@',
                                  style: Theme.of(context).textTheme.labelLarge!.copyWith(height: .7)),
                              vertical(20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        '${controller.userProfileDetails!.count.followers}',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          height: 1,
                                        ),
                                      ),
                                      Text(
                                        'المتابعين ',
                                        style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                              height: 1.2,
                                              fontSize: 12,
                                            ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: 1,
                                    height: 30,
                                    color: Colors.grey.shade300,
                                    margin: const EdgeInsets.symmetric(horizontal: 12),
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        '${controller.userProfileDetails!.count.following}',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          height: 1,
                                        ),
                                      ),
                                      Text(
                                        'المتابعون ',
                                        style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                              height: 1.2,
                                              fontSize: 12,
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              vertical(15),
                              InkWell(
                                onTap: () {
                                  controller.makeFollowOnProfilePage(controller.userProfileDetails!.id);
                                },
                                child: Container(
                                  width: 120,
                                  height: 37,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: controller.isFollowingUserExist ? AppLightColor.redColor : AppLightColor.primaryColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: controller.isExistFollowLoading
                                      ? Center(
                                          child: SizedBox(
                                            width: 12,
                                            height: 12,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 1.5,
                                            ),
                                          ),
                                        )
                                      : Text(
                                          controller.isFollowingUserExist ? 'إلغاء المتابعة' : 'متابعة',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
