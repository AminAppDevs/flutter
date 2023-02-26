import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jdolh_flutter/category/domain/entities/store.dart';
import 'package:jdolh_flutter/category/presentation/controller/category_controller.dart';
import 'package:jdolh_flutter/core/utils/app_light_color.dart';
import 'package:jdolh_flutter/core/utils/global_utils.dart';
import 'package:jdolh_flutter/core/utils/shimmer_effect.dart';
import 'package:jdolh_flutter/store/presentation/controller/store_controller.dart';
import 'package:jdolh_flutter/store/presentation/screens/store_details_screen.dart';
import 'package:lottie/lottie.dart';

Container categoryStores(CategoryController controller, BuildContext context, StoreController storeController) => Container(
      padding: const EdgeInsets.all(10),
      color: AppLightColor.inputBgColor,
      child: controller.isStoreOfCategoryLoading
          ? Center(
              child: Container(
                width: 25,
                height: 25,
                child: CircularProgressIndicator(
                  color: AppLightColor.primaryColor,
                  strokeWidth: 3,
                ),
              ),
            )
          : controller.storesOfCategory.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/images/not_found.json', height: 120),
                    Text(
                      'القسم فارغ',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontSize: 14,
                            height: 0.3,
                          ),
                    ),
                    vertical(50),
                  ],
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                        itemCount: controller.storesOfCategory.length,
                        itemBuilder: (context, index) {
                          Store store = controller.storesOfCategory[index];
                          return InkWell(
                            onTap: () {
                              Get.to(() => StoreDetailsScreen());
                              storeController.getStoreDetails(store.id);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: HexColor('#eeeeee')),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: store.cover.imageUrl,
                                        placeholder: (context, url) =>
                                            ShimmerEffect.shimmerBox(width: double.infinity, height: 110, borderRaduis: 10),
                                        errorWidget: (context, url, error) => Icon(Icons.error),
                                        imageBuilder: (context, imageProvider) => Container(
                                          width: double.infinity,
                                          height: 110,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                            color: Colors.grey.shade200,
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
                                          child: CachedNetworkImage(
                                            imageUrl: store.avatar.imageUrl,
                                            placeholder: (context, url) => ShimmerEffect.shimmerBox(width: 45, height: 45, borderRaduis: 10),
                                            errorWidget: (context, url, error) => Icon(Icons.error),
                                            imageBuilder: (context, imageProvider) => Container(
                                              width: 45,
                                              height: 45,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: Colors.white.withOpacity(.3), width: 1, strokeAlign: BorderSide.strokeAlignOutside),
                                                color: Colors.grey.shade200,
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 7),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Expanded(child: Text(store.name, style: Theme.of(context).textTheme.titleMedium!.copyWith(height: 1.7))),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(store.rating.length.toDouble().toString(),
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  height: 3,
                                                )),
                                            horizontal(2),
                                            Icon(
                                              Ionicons.star,
                                              color: HexColor('ED8A19'),
                                              size: 12,
                                            ),
                                          ],
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
                    ),
                  ],
                ),
    );
