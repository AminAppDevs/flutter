import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_flutter/category/presentation/controller/category_controller.dart';
import 'package:jdolh_flutter/core/utils/app_light_color.dart';
import 'package:jdolh_flutter/core/utils/shimmer_effect.dart';
import 'package:jdolh_flutter/store/presentation/controller/store_controller.dart';
import 'package:jdolh_flutter/store/presentation/screens/store_details_screen.dart';

CarouselSlider categorySlider(CategoryController controller, StoreController storeController) => CarouselSlider.builder(
      itemCount: controller.categorySlides.length,
      itemBuilder: (context, index, realIndex) {
        return InkWell(
          onTap: () {
            Get.to(() => StoreDetailsScreen());
            storeController.getStoreDetails(controller.categorySlides[index].id);
          },
          child: CachedNetworkImage(
            imageUrl: controller.categorySlides[index].image.imageUrl,
            placeholder: (context, url) => ShimmerEffect.shimmerBox(width: double.infinity, height: 140, borderRaduis: 10),
            errorWidget: (context, url, error) => Icon(Icons.error),
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppLightColor.inputBgColor, width: 3, strokeAlign: BorderSide.strokeAlignOutside),
                color: Colors.grey.shade200,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      },
      options: CarouselOptions(
        height: 140,
        viewportFraction: 1,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 4),
        autoPlayAnimationDuration: const Duration(milliseconds: 600),
        autoPlayCurve: Curves.easeIn,
      ),
    );
