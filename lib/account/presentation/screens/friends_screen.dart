import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jdolh_flutter/account/presentation/controller/account_controller.dart';
import 'package:jdolh_flutter/core/utils/app_light_color.dart';
import 'package:jdolh_flutter/core/utils/global_utils.dart';
import 'package:jdolh_flutter/core/utils/shimmer_effect.dart';
import 'package:jdolh_flutter/core/utils/snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

class FriendsScreen extends StatelessWidget {
  FriendsScreen({super.key});
  final AccountController accountController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('الأصدقاء'),
          actions: [
            IconButton(
                onPressed: () {
                  controller.updateIsFriendsSearch();
                },
                icon: Icon(controller.isFriendsSearchActive ? Ionicons.close : Ionicons.search))
          ],
        ),
        body: controller.isGetContactsLoading
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
            : Column(
                children: [
                  vertical(10),
                  if (!controller.isFriendsSearchActive && controller.syncedUsers.isNotEmpty)
                    Container(
                      height: 135,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.syncedUsers.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 135,
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppLightColor.inputBgColor.withOpacity(.8),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: controller.syncedUsers[index].avatar.imageUrl,
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
                                Text(controller.syncedUsers[index].fullName, style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 11)),
                                Text(
                                  controller.syncedUsers[index].phoneNumber,
                                  style: Theme.of(context).textTheme.labelMedium!.copyWith(height: 1, fontSize: 10),
                                ),
                                vertical(5),
                                InkWell(
                                  onTap: () {
                                    accountController.makeFollowOnFriendsScreen(controller.syncedUsers[index].id);
                                  },
                                  child: Container(
                                    width: 70,
                                    height: 30,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppLightColor.primaryColor),
                                    child:
                                        controller.isFollowersFollowingLoading && controller.loadingFlollowUserId == controller.syncedUsers[index].id
                                            ? Center(
                                                child: SizedBox(
                                                  width: 12,
                                                  height: 12,
                                                  child: CircularProgressIndicator(
                                                    color: Colors.white,
                                                    strokeWidth: 1,
                                                  ),
                                                ),
                                              )
                                            : Text(
                                                'متابعة',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                ),
                                              ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  if (!controller.isFriendsSearchActive && controller.syncedUsers.isNotEmpty)
                    Column(
                      children: [
                        vertical(5),
                        Divider(),
                      ],
                    ),
                  if (controller.isFriendsSearchActive)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                      color: Colors.white,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          accountController.searchInContacts(value);
                        },
                        decoration: InputDecoration(
                          suffixIcon: Icon(Ionicons.search),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                          hintText: 'بحث بالاسم أو رقم الجوال',
                        ),
                      ),
                    ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.contactsToInvite.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppLightColor.inputBgColor.withOpacity(.7),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  ProfilePicture(name: controller.contactsToInvite[index]['name']!, radius: 25, fontsize: 15),
                                  horizontal(8),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.contactsToInvite[index]['name'],
                                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                              fontSize: 15,
                                              height: 1.7,
                                            ),
                                      ),
                                      vertical(3),
                                      Directionality(
                                        textDirection: TextDirection.ltr,
                                        child: Text(
                                          controller.contactsToInvite[index]['fullPhone'],
                                          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                                height: 1.2,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () async {
                                  String phoneWithoutSpace = controller.contactsToInvite[index]['fullPhone'].replaceAll(new RegExp(r'[^0-9]'), "");
                                  final url = 'wa.me';
                                  final Uri uri = Uri(
                                      scheme: 'https',
                                      host: url,
                                      path: '$phoneWithoutSpace',
                                      query: 'text=قم بتحميل تطبيق جدولة على الرابط التالي  https://google.com');

                                  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
                                    AppSnackbar.errorSnackbar(message: 'يوجد ما!');
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: AppLightColor.primaryColor),
                                  ),
                                  child: Text(
                                    'دعوة',
                                    style: TextStyle(
                                      color: AppLightColor.primaryColor,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
