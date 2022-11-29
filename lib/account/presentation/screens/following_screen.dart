import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jdolh_flutter/account/domain/entities/user.dart';
import 'package:jdolh_flutter/account/presentation/controller/account_controller.dart';
import 'package:jdolh_flutter/core/utils/app_light_color.dart';
import 'package:jdolh_flutter/core/utils/global_utils.dart';
import 'package:jdolh_flutter/core/utils/shimmer_effect.dart';

class FollowingScreen extends StatelessWidget {
  FollowingScreen({super.key});
  final AccountController accountController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('تتابعه')),
      body: GetBuilder<AccountController>(
        builder: (controller) => controller.isFollowersFollowingLoading
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
            : controller.following.isEmpty
                ? Center(
                    child: Text('لا يوجد متابعون'),
                  )
                : Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                        color: Colors.white,
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            accountController.searchFollowersFollowing(value, false);
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Ionicons.search),
                            hintText: 'بحث بالاسم أو رقم الجوال',
                          ),
                        ),
                      ),
                      Divider(height: 0),
                      vertical(5),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.followingsSearchResult.length,
                          itemBuilder: (context, index) {
                            User user = controller.followingsSearchResult[index];
                            return InkWell(
                              onTap: () {
                                print(user.id);
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
                                      placeholder: (context, url) => ShimmerEffect.shimmerBox(width: 50, height: 50, borderRaduis: 100),
                                      errorWidget: (context, url, error) => Icon(Icons.error),
                                      imageBuilder: (context, imageProvider) => Container(
                                        width: 50,
                                        height: 50,
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
                                    horizontal(10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          user.fullName,
                                          style: Theme.of(context).textTheme.titleLarge!.copyWith(height: 1.5, fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          '${user.phoneNumber}@',
                                          style: Theme.of(context).textTheme.labelMedium!.copyWith(height: 1),
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
