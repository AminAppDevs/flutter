import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jdolh_flutter/account/domain/entities/user.dart';
import 'package:jdolh_flutter/account/presentation/controller/account_controller.dart';
import 'package:jdolh_flutter/account/presentation/screens/user_profile_screen.dart';
import 'package:jdolh_flutter/core/utils/app_light_color.dart';
import 'package:jdolh_flutter/core/utils/global_utils.dart';
import 'package:jdolh_flutter/core/utils/shimmer_effect.dart';

class FollowersScreen extends StatelessWidget {
  FollowersScreen({super.key});
  final AccountController accountController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('يتابعك'),
          actions: [
            IconButton(
                onPressed: () {
                  accountController.changeSearchActiveStatus();
                },
                icon: Icon(accountController.isSearchActive ? Ionicons.close : Ionicons.search))
          ],
        ),
        body: controller.isFollowersFollowingLoading
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
            : controller.followers.isEmpty
                ? Center(
                    child: Text('لا يوجد متابعين'),
                  )
                : Column(
                    children: [
                      if (accountController.isSearchActive)
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                              color: Colors.white,
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                onChanged: (value) {
                                  accountController.searchFollowersFollowing(value, true);
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Ionicons.search),
                                  hintText: 'بحث بالاسم أو رقم الجوال',
                                ),
                              ),
                            ),
                            Divider(height: 0),
                          ],
                        ),
                      vertical(5),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.followersSearchResult.length,
                          itemBuilder: (context, index) {
                            User user = controller.followersSearchResult[index];
                            return InkWell(
                              onTap: () {
                                print(user.id);
                                Get.to(() => UserProfileScreen());
                                controller.getUserProfileDetails(user.id);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(7),
                                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppLightColor.inputBgColor.withOpacity(.5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: user.avatar.imageUrl,
                                      placeholder: (context, url) => ShimmerEffect.shimmerBox(width: 45, height: 45, borderRaduis: 100),
                                      errorWidget: (context, url, error) => Icon(Icons.error),
                                      imageBuilder: (context, imageProvider) => Container(
                                        width: 45,
                                        height: 45,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100),
                                          border: Border.all(color: AppLightColor.inputBgColor, width: 3, strokeAlign: BorderSide.strokeAlignOutside),
                                          color: Colors.grey.shade200,
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    horizontal(10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          user.fullName,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(height: 1.5, fontWeight: FontWeight.w500, fontSize: 14),
                                        ),
                                        Text(
                                          '${user.phoneNumber}@',
                                          style: Theme.of(context).textTheme.labelMedium!.copyWith(height: 1.2, fontSize: 11),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}
