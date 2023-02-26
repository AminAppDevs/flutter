import 'package:flutter/material.dart';
import 'package:jdolh_flutter/core/utils/app_light_color.dart';
import 'package:jdolh_flutter/store/domain/entities/product_category.dart';
import 'package:jdolh_flutter/store/presentation/components/products_list.dart';
import 'package:jdolh_flutter/store/presentation/controller/store_controller.dart';

class StoreProductMenu extends StatelessWidget {
  const StoreProductMenu({super.key, required this.controller});
  final StoreController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: controller.storeProductCategories.length,
        child: Scaffold(
          body: Column(
            children: [
              if (controller.storeProductCategories.isNotEmpty)
                Expanded(
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: controller.storeProductCategories
                        .map((ProductCategory productCategory) => ProductsList(productCategory: productCategory))
                        .toList(),
                  ),
                )
            ],
          ),
          bottomNavigationBar: Container(
            height: 50,
            color: AppLightColor.secondaryColor,
            child: TabBar(
              isScrollable: true,
              tabs: controller.storeProductCategories.map((ProductCategory productCategory) => Tab(text: productCategory.name)).toList(),
              indicatorColor: AppLightColor.primaryColor,
              unselectedLabelColor: Colors.white,
              labelColor: AppLightColor.primaryColor,
              labelStyle: TextStyle(fontSize: 12, fontFamily: 'Cairo'),
              padding: EdgeInsets.symmetric(horizontal: 10),
              indicatorPadding: EdgeInsets.zero,
              labelPadding: EdgeInsets.symmetric(horizontal: 7),
              indicatorSize: TabBarIndicatorSize.label,
            ),
          ),
        ),
      ),
    );
  }
}
