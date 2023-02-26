import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jdolh_flutter/core/utils/app_light_color.dart';
import 'package:jdolh_flutter/core/utils/global_utils.dart';
import 'package:jdolh_flutter/core/utils/shimmer_effect.dart';
import 'package:jdolh_flutter/store/domain/entities/product_category.dart';
import 'package:jdolh_flutter/store/presentation/controller/store_controller.dart';
import 'package:jdolh_flutter/store/presentation/screens/product_details_screen.dart';

class ProductsList extends StatelessWidget {
  ProductsList({super.key, required this.productCategory});
  final ProductCategory productCategory;
  final StoreController storeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: productCategory.products.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              storeController.getProductDetails(productCategory.products[index].id);
              Get.to(ProductDetailsScreen());
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productCategory.products[index].name,
                          style: TextStyle(
                            color: AppLightColor.headingColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            height: 1,
                          ),
                        ),
                        vertical(3),
                        Text(
                          productCategory.products[index].description,
                          maxLines: 2,
                          style: TextStyle(
                            color: AppLightColor.labelColor,
                            fontSize: 12,
                            height: 1.5,
                          ),
                        ),
                        vertical(7),
                        Row(
                          children: [
                            Icon(Ionicons.pricetags, size: 13, color: AppLightColor.primaryColor),
                            horizontal(5),
                            Text(
                              '${productCategory.products[index].regularPrice > 0 ? '${productCategory.products[index].regularPrice} ريال' : 'خيارات متعددة'}',
                              style: TextStyle(
                                color: AppLightColor.labelColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  horizontal(10),
                  if (productCategory.products[index].images.isNotEmpty)
                    CachedNetworkImage(
                      imageUrl: productCategory.products[index].images[0].imageUrl,
                      placeholder: (context, url) => ShimmerEffect.shimmerBox(width: 70, height: 70, borderRaduis: 10),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      imageBuilder: (context, imageProvider) => Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.contain,
                          ),
                        ),
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
