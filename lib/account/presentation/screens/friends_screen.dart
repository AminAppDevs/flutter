import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jdolh_flutter/account/presentation/controller/account_controller.dart';
import 'package:jdolh_flutter/core/utils/app_light_color.dart';
import 'package:jdolh_flutter/core/utils/global_utils.dart';

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
          actions: [],
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
                  Column(
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
                    ],
                  ),
                  vertical(7),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.contacts.length,
                      itemBuilder: (context, index) {
                        print(controller.contacts[index].phones);
                        return Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppLightColor.inputBgColor.withOpacity(.7),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              ProfilePicture(name: controller.contacts[index].displayName!, radius: 25, fontsize: 15),
                              horizontal(8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.contacts[index].displayName!,
                                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                          fontSize: 15,
                                          height: 1.7,
                                        ),
                                  ),
                                  vertical(3),
                                  Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: Text(
                                      controller.contacts[index].phones!.isEmpty ? 'a' : controller.contacts[index].phones!.first.value!,
                                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                            height: 1.2,
                                          ),
                                    ),
                                  ),
                                ],
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
