import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jdolh_flutter/account/presentation/components/account_shimmer.dart';
import 'package:jdolh_flutter/account/presentation/controller/account_controller.dart';
import 'package:jdolh_flutter/core/utils/app_light_color.dart';
import 'package:jdolh_flutter/core/utils/global_utils.dart';
import 'package:jdolh_flutter/core/utils/shimmer_effect.dart';
import 'package:jdolh_flutter/core/utils/snackbar.dart';

class UserAvatarComponent extends StatelessWidget {
  UserAvatarComponent({super.key});
  final AccountController accountController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(
      builder: (AccountController controller) => Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        if (controller.userDetails != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Get.bottomSheet(
                    Container(
                      height: 300,
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      child: GetBuilder<AccountController>(
                        builder: (controller) => controller.isUploadAvatarLoading
                            ? Center(
                                child: SizedBox(
                                  width: 25,
                                  height: 25,
                                  child: CircularProgressIndicator(color: AppLightColor.primaryColor, strokeWidth: 3),
                                ),
                              )
                            : Column(
                                children: [
                                  if (controller.imagePicked != null)
                                    Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                        image: DecorationImage(
                                          image: FileImage(File(controller.imagePicked!.path)),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  if (controller.imagePicked == null) ShimmerEffect.shimmerBox(width: 100, height: 100, borderRaduis: 100),
                                  vertical(10),
                                  if (controller.imagePicked != null)
                                    Container(
                                      width: 120,
                                      height: 40,
                                      child: pickImageButton(
                                        icon: Ionicons.cloud_upload,
                                        text: 'تأكيد ورفع',
                                        color: AppLightColor.primaryColor,
                                        onTap: () {
                                          controller.updateUserAvatar();
                                          print(1);
                                        },
                                      ),
                                    ),
                                  vertical(15),
                                  Text(
                                    'تغيير صورة الملف الشخصي',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 15),
                                  ),
                                  vertical(6),
                                  Row(
                                    children: [
                                      pickImageButton(
                                        icon: Ionicons.image,
                                        text: 'من المعرض',
                                        color: AppLightColor.secondaryColor,
                                        onTap: () {
                                          controller.pickImage(true);
                                        },
                                      ),
                                      horizontal(5),
                                      pickImageButton(
                                        icon: Ionicons.camera,
                                        text: 'من الكاميرا',
                                        color: AppLightColor.headingColor,
                                        onTap: () {
                                          controller.pickImage(false);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                      ),
                    ),
                  );
                },
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CachedNetworkImage(
                      imageUrl: accountController.userDetails!.avatar.imageUrl,
                      placeholder: (context, url) => ShimmerEffect.shimmerBox(width: 90, height: 90, borderRaduis: 90),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      imageBuilder: (context, imageProvider) => Container(
                        width: 90,
                        height: 90,
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
                    Icon(
                      Ionicons.camera,
                      size: 20,
                      color: Colors.grey.shade500,
                    ),
                  ],
                ),
              ),
              vertical(6),
              InkWell(
                onTap: () {
                  Get.bottomSheet(
                    Container(
                      padding: const EdgeInsets.all(16),
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                      ),
                      child: ListView(
                        children: [
                          Text('تحديث بياناتك الشخصية', style: Theme.of(context).textTheme.titleMedium),
                          vertical(12),
                          if (controller.isUpdateUserInfoLoading)
                            Center(
                              child: SizedBox(
                                width: 25,
                                height: 25,
                                child: CircularProgressIndicator(
                                  color: AppLightColor.primaryColor,
                                  strokeWidth: 3,
                                ),
                              ),
                            ),
                          if (!controller.isUpdateUserInfoLoading)
                            Form(
                              child: Column(
                                children: [
                                  TextFormField(
                                    initialValue: controller.userDetails!.fullName,
                                    onChanged: (value) {
                                      controller.fullNameForUpdate = value;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'اسمك بالكامل',
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                                    ),
                                  ),
                                  vertical(5),
                                  Container(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          if (controller.fullNameForUpdate.isEmpty) {
                                            AppSnackbar.errorSnackbar(message: 'حقل الاسم فارغ');
                                          } else {
                                            controller.updateUserInfo({"fullName": controller.fullNameForUpdate});
                                          }
                                        },
                                        child: Text('تحديث')),
                                  )
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(accountController.userDetails!.fullName, style: Theme.of(context).textTheme.headlineSmall),
                        horizontal(5),
                        SvgPicture.asset('assets/images/edit.svg', height: 16, color: AppLightColor.subHeadingColor),
                        horizontal(5),
                      ],
                    ),
                    Text('${accountController.userDetails!.phoneNumber}@', style: Theme.of(context).textTheme.labelLarge!.copyWith(height: .7)),
                  ],
                ),
              ),
            ],
          ),
        if (controller.userDetails == null) userAvatarShimmer(),
      ]),
    );
  }

  Expanded pickImageButton({required Color color, required IconData icon, required String text, required void Function()? onTap}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 20, color: Colors.white),
              horizontal(4),
              Text(
                text,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
