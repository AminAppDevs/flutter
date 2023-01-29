import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jdolh_flutter/core/services/service_locator.dart';
import 'package:jdolh_flutter/store/presentation/components/store_details_tab.dart';
import 'package:jdolh_flutter/store/presentation/controller/store_controller.dart';

class StoreDetailsScreen extends StatelessWidget {
  StoreDetailsScreen({super.key});
  final StoreController storeController = Get.put(StoreController(sl(), sl(), sl()));

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            actions: [IconButton(onPressed: () {}, icon: Icon(Ionicons.cart_outline))],
            centerTitle: true,
            title: controller.storeDetails == null
                ? Text('')
                : controller.isGetStoreDetailsLoading
                    ? Text('تحميل...')
                    : Text(controller.storeDetails!.name),
          ),
          body: controller.storeDetails == null ? Container() : StoreDetailsTab(controller: controller),
        );
      },
    );
  }
}
