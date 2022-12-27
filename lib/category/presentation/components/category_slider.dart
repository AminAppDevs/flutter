import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:jdolh_flutter/core/utils/app_light_color.dart';
import 'package:jdolh_flutter/core/utils/shimmer_effect.dart';

Padding categorySlider() => Padding(
      padding: const EdgeInsets.only(right: 16, left: 16, top: 10),
      child: CarouselSlider.builder(
        itemCount: 3,
        itemBuilder: (context, index, realIndex) {
          return CachedNetworkImage(
            imageUrl: 'https://jdolh-app-avatar.s3.ap-south-1.amazonaws.com/69bb968a-19db-4658-a44a-de67c94b4c98__1671940153067',
            placeholder: (context, url) => ShimmerEffect.shimmerBox(width: double.infinity, height: 400, borderRaduis: 10),
            errorWidget: (context, url, error) => Icon(Icons.error),
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
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
          height: 130,
          viewportFraction: 1,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 5),
          autoPlayAnimationDuration: const Duration(milliseconds: 2000),
        ),
      ),
    );
