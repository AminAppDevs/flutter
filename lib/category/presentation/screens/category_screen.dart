import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jdolh_flutter/category/presentation/components/category_slider.dart';
import 'package:jdolh_flutter/category/presentation/components/category_stores_filter.dart';
import 'package:jdolh_flutter/category/presentation/components/parent_category_side.dart';
import 'package:jdolh_flutter/category/presentation/controller/category_controller.dart';
import 'package:jdolh_flutter/core/services/service_locator.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({super.key});
  final CategoryController categoryController = Get.put(CategoryController(sl(), sl(), sl()));

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text('الحجز'),
          actions: [IconButton(onPressed: () {}, icon: Icon(Ionicons.search))],
        ),
        body: Column(
          children: [
            categorySlider(),
            categoryStoresFilter(context),
            parentCategorySide(),
          ],
        ),
      ),
    );
  }
}
