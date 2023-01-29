import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:jdolh_flutter/core/utils/app_light_color.dart';
import 'package:jdolh_flutter/core/utils/shimmer_effect.dart';
import 'package:jdolh_flutter/store/presentation/controller/store_controller.dart';

CarouselSlider productSlider(StoreController storeController) => CarouselSlider.builder(
      itemCount: storeController.productDetails!.images.length,
      itemBuilder: (context, index, realIndex) {
        return CachedNetworkImage(
          imageUrl: storeController.productDetails!.images[index].imageUrl,
          placeholder: (context, url) => ShimmerEffect.shimmerBox(width: double.infinity, height: 170, borderRaduis: 0),
          errorWidget: (context, url, error) => Icon(Icons.error),
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppLightColor.inputBgColor, width: 3, strokeAlign: StrokeAlign.outside),
              color: Colors.grey.shade200,
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
      options: CarouselOptions(
        height: 170,
        viewportFraction: 1,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 4),
        autoPlayAnimationDuration: const Duration(milliseconds: 600),
        autoPlayCurve: Curves.easeIn,
      ),
    );
