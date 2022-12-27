import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jdolh_flutter/account/presentation/components/create_group_bootmsheet.dart';
import 'package:jdolh_flutter/account/presentation/controller/account_controller.dart';
import 'package:jdolh_flutter/core/utils/app_light_color.dart';
import 'package:jdolh_flutter/core/utils/global_utils.dart';

class GroupsScreen extends StatelessWidget {
  GroupsScreen({super.key});
  final AccountController accountController = Get.find();

  @override
  Widget build(BuildContext context) {
    DateFormat format = DateFormat.yMd();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('مجموعاتي'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GetBuilder<AccountController>(
          builder: (controller) => ListView.builder(
            itemCount: controller.groups.length,
            itemBuilder: (context, index) {
              String dateString = format.format(DateTime.parse(controller.groups[index].createdAt));
              return InkWell(
                onTap: () {
                  controller.getGroupDetails(controller.groups[index]);
                  controller.groupIdToAddUser = controller.groups[index].id;
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.only(bottom: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppLightColor.inputBgColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.groups[index].name,
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontSize: 14,
                                  height: 1.1,
                                  color: AppLightColor.subHeadingColor,
                                ),
                          ),
                          vertical(8),
                          Text('تاريخ الإنشاء: ${dateString}', style: Theme.of(context).textTheme.labelMedium!.copyWith(height: 1, fontSize: 11)),
                        ],
                      ),
                      Row(
                        children: [
                          SvgPicture.asset('assets/images/group_members_count.svg', height: 15),
                          horizontal(5),
                          Text(
                            '${controller.groups[index].members.length} أعضاء',
                            style: Theme.of(context).textTheme.labelMedium,
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
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.bottomSheet(createGroupBootmsheet(context));
        },
        label: Text('إنشاء مجموعة', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
        icon: Icon(Ionicons.add),
        extendedIconLabelSpacing: 0,
        backgroundColor: AppLightColor.primaryColor,
      ),
    );
  }
}
