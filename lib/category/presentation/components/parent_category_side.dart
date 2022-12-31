import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jdolh_flutter/category/domain/entities/category.dart';
import 'package:jdolh_flutter/category/presentation/controller/category_controller.dart';
import 'package:jdolh_flutter/core/utils/app_light_color.dart';
import 'package:jdolh_flutter/core/utils/global_utils.dart';
import 'package:jdolh_flutter/core/utils/shimmer_effect.dart';

Container parentCategorySide(CategoryController controller) => Container(
      child: Container(
        constraints: BoxConstraints(minWidth: 120, maxWidth: 150),
        width: 10,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              blurRadius: 15,
            ),
          ],
        ),
        child: controller.isParentCategoriesLoading
            ? loading(color: AppLightColor.primaryColor)
            : ListView.builder(
                itemCount: controller.parentCategories.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  Category category = controller.parentCategories[index];
                  return InkWell(
                    onTap: () {
                      controller.updateActiveCategoryOpen(category.id);
                      controller.updateActiveParentCategory(category.id);
                      if (category.subCategories.isEmpty) {
                        controller.getStoresOfCategory(category.id);
                        controller.updateActiveSubCategory(0);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.grey.shade200),
                              left: BorderSide(
                                  color: controller.activeParentCategory == category.id ? AppLightColor.primaryColor : Colors.white, width: 3)),
                          color: controller.activeParentCategory == category.id ? AppLightColor.primaryColor.withOpacity(.03) : Colors.white),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CachedNetworkImage(
                                    width: 20,
                                    height: 20,
                                    imageUrl:
                                        'https://jdolh-app-avatar.s3.ap-south-1.amazonaws.com/69bb968a-19db-4658-a44a-de67c94b4c98__1671940153067',
                                    placeholder: (context, url) => ShimmerEffect.shimmerBox(width: 20, height: 20, borderRaduis: 10),
                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                    imageBuilder: (context, ImageProvider<Object> imageProvider) =>
                                        SvgPicture.network(category.icon.imageUrl, color: AppLightColor.labelColor),
                                  ),
                                  horizontal(3),
                                  Text(category.name,
                                      style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 12, fontWeight: FontWeight.w500)),
                                ],
                              ),
                              if (category.subCategories.isNotEmpty)
                                Icon(
                                    controller.activeParentCategory == category.id && controller.activeCategoryOpen
                                        ? Ionicons.chevron_up
                                        : Ionicons.chevron_down,
                                    size: 15),
                            ],
                          ),
                          if (controller.activeParentCategory == category.id && controller.activeCategoryOpen)
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: category.subCategories.length,
                              itemBuilder: (context, subIndex) {
                                Category subCategory = category.subCategories[subIndex];
                                return InkWell(
                                  onTap: () {
                                    controller.updateActiveSubCategory(subCategory.id);
                                    controller.getStoresOfCategory(subCategory.id);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(vertical: 5),
                                    margin: const EdgeInsets.symmetric(vertical: 3),
                                    child: Text(
                                      subCategory.name,
                                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                            fontSize: 12,
                                            color: controller.activeSubcategory == subCategory.id ? Colors.white : AppLightColor.subHeadingColor,
                                          ),
                                    ),
                                    decoration: BoxDecoration(
                                      color: controller.activeSubcategory == subCategory.id ? AppLightColor.primaryColor : Colors.white,
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(color: HexColor('#eeeeee')),
                                    ),
                                  ),
                                );
                              },
                            )
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
