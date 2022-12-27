import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jdolh_flutter/core/utils/app_light_color.dart';
import 'package:jdolh_flutter/core/utils/global_utils.dart';
import 'package:jdolh_flutter/core/utils/shimmer_effect.dart';

Expanded parentCategorySide() => Expanded(
      child: Container(
        child: Row(
          children: [
            Container(
              width: 100,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(left: BorderSide(color: Colors.grey.shade100)),
              ),
              child: ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
                    ),
                    child: Column(
                      children: [
                        CachedNetworkImage(
                          width: 30,
                          height: 30,
                          imageUrl: 'https://jdolh-app-avatar.s3.ap-south-1.amazonaws.com/69bb968a-19db-4658-a44a-de67c94b4c98__1671940153067',
                          placeholder: (context, url) => ShimmerEffect.shimmerBox(width: 20, height: 20, borderRaduis: 10),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                          imageBuilder: (context, ImageProvider<Object> imageProvider) => SvgPicture.network(
                            'https://jdolh-app-avatar.s3.ap-south-1.amazonaws.com/539896de-572b-4fe0-9123-37a618b0a344__1671938065165',
                            color: AppLightColor.labelColor,
                          ),
                        ),
                        vertical(3),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('المطاعم', style: Theme.of(context).textTheme.titleSmall),
                            horizontal(2),
                            Icon(Ionicons.chevron_down, size: 12),
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
