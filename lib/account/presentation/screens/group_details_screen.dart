import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jdolh_flutter/account/presentation/components/confirm_remove.dart';
import 'package:jdolh_flutter/account/presentation/controller/account_controller.dart';
import 'package:jdolh_flutter/core/utils/app_light_color.dart';
import 'package:jdolh_flutter/core/utils/global_utils.dart';
import 'package:jdolh_flutter/core/utils/shimmer_effect.dart';

class GroupDetailsScreen extends StatelessWidget {
  GroupDetailsScreen({super.key});
  final AccountController accountController = Get.find();

  @override
  Widget build(BuildContext context) {
    DateFormat format = DateFormat.yMd();

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('تفاصيل المجموعة')),
      body: GetBuilder<AccountController>(
        builder: (controller) {
          String dateString = format.format(DateTime.parse(controller.group!.createdAt));
          return controller.group == null
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
              : Container(
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: AppLightColor.inputBgColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('اسم المجموعة', style: Theme.of(context).textTheme.labelMedium!.copyWith(height: 1.5)),
                                  vertical(6),
                                  Text(controller.group!.name, style: Theme.of(context).textTheme.titleLarge!.copyWith(height: 1.1)),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: AppLightColor.primaryColor.withOpacity(.1),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/group_members_count.svg',
                                          height: 13,
                                          color: AppLightColor.subHeadingColor,
                                        ),
                                        horizontal(3),
                                        Text(
                                          '${controller.group!.members.length} أعضاء',
                                          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                                color: AppLightColor.subHeadingColor,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  vertical(6),
                                  Text('تاريخ الإنشاء: ${dateString}', style: Theme.of(context).textTheme.labelMedium!.copyWith(height: 1)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        vertical(10),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: AppLightColor.inputBgColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('أعضاء المجموعة', style: Theme.of(context).textTheme.titleMedium),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: AppLightColor.primaryColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Ionicons.person_add, color: Colors.white, size: 15),
                                        horizontal(5),
                                        Text(
                                          'أضف عضو',
                                          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                                fontSize: 12,
                                                color: Colors.white,
                                                height: 1.7,
                                              ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              vertical(10),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.group!.members.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.only(bottom: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            CachedNetworkImage(
                                              imageUrl: controller.group!.members[index].avatar.imageUrl,
                                              placeholder: (context, url) => ShimmerEffect.shimmerBox(width: 40, height: 40, borderRaduis: 100),
                                              errorWidget: (context, url, error) => Icon(Icons.error),
                                              imageBuilder: (context, imageProvider) => Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(100),
                                                  border: Border.all(color: AppLightColor.inputBgColor, width: 2, strokeAlign: StrokeAlign.outside),
                                                  color: Colors.grey.shade200,
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            horizontal(5),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  controller.group!.members[index].fullName,
                                                  style: Theme.of(context).textTheme.titleMedium!.copyWith(height: 1.5),
                                                ),
                                                Text(
                                                  '${controller.group!.members[index].phoneNumber}@',
                                                  style: Theme.of(context).textTheme.labelMedium!.copyWith(height: 1.2, fontSize: 11),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.bottomSheet(
                                              confirmRemove(
                                                context,
                                                onTap: () {
                                                  controller.removeMemberFromGroup(controller.group!.id, controller.group!.members[index].id);
                                                  Get.back();
                                                },
                                              ),
                                            );
                                          },
                                          child: Icon(
                                            Ionicons.remove_circle,
                                            size: 25,
                                            color: AppLightColor.redColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
