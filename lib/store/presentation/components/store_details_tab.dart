import 'package:flutter/material.dart';
import 'package:jdolh_flutter/core/utils/app_light_color.dart';
import 'package:jdolh_flutter/store/presentation/components/booking_details_menu.dart';
import 'package:jdolh_flutter/store/presentation/components/store_details_cover.dart';
import 'package:jdolh_flutter/store/presentation/components/store_details_tabs_delgate.dart';
import 'package:jdolh_flutter/store/presentation/components/store_products_menu.dart';
import 'package:jdolh_flutter/store/presentation/controller/store_controller.dart';

class StoreDetailsTab extends StatelessWidget {
  const StoreDetailsTab({super.key, required this.controller});
  final StoreController controller;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        physics: NeverScrollableScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            StoreDetailsCover(controller: controller),
            SliverPersistentHeader(
              delegate: StoreDetailsTabsDelegate(
                TabBar(
                  indicator: BoxDecoration(color: AppLightColor.primaryColor),
                  tabs: [
                    Tab(text: 'القائمة'),
                    Tab(text: 'تفاصيل الحجز'),
                  ],
                  unselectedLabelColor: AppLightColor.headingColor,
                  labelColor: Colors.white,
                ),
              ),
              floating: true,
              pinned: true,
            )
          ];
        },
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            StoreProductMenu(controller: controller),
            BookingDetailsMenu(),
          ],
        ),
      ),
    );
  }
}
