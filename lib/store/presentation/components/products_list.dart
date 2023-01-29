import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:jdolh_flutter/core/utils/app_light_color.dart';
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
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: productCategory.products.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              storeController.getProductDetails(productCategory.products[index].id);
              Get.to(() => ProductDetailsScreen());
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: HexColor('eeeeee')),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  if (productCategory.products[index].images.isNotEmpty)
                    CachedNetworkImage(
                      imageUrl: productCategory.products[index].images[0].imageUrl,
                      placeholder: (context, url) => ShimmerEffect.shimmerBox(width: double.infinity, height: 160, borderRaduis: 10),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      imageBuilder: (context, imageProvider) => Container(
                        width: double.infinity,
                        height: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                          border: Border.all(color: Colors.white.withOpacity(.3), width: 2, strokeAlign: StrokeAlign.outside),
                          color: Colors.grey.shade200,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          productCategory.products[index].name,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppLightColor.headingColor,
                          ),
                        ),
                        Text(
                          '25 ريال',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppLightColor.primaryColor,
                          ),
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
