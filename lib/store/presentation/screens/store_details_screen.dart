import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jdolh_flutter/core/services/service_locator.dart';
import 'package:jdolh_flutter/core/utils/app_light_color.dart';
import 'package:jdolh_flutter/core/utils/global_utils.dart';
import 'package:jdolh_flutter/core/utils/shimmer_effect.dart';
import 'package:jdolh_flutter/store/presentation/controller/store_controller.dart';

class StoreDetailsScreen extends StatelessWidget {
  StoreDetailsScreen({super.key});
  final StoreController storeController = Get.put(StoreController(sl()));

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
          body: controller.storeDetails == null
              ? Container()
              : DefaultTabController(
                  length: 2,
                  child: NestedScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                      return [
                        SliverAppBar(
                          collapsedHeight: 200,
                          expandedHeight: 200,
                          leading: Container(),
                          flexibleSpace: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(controller.storeDetails!.cover.imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: AppLightColor.redColor.withOpacity(.8),
                                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15)),
                                  ),
                                  child: Text(
                                    'يمكنك الحجز دون طلب',
                                    style: TextStyle(fontSize: 10, color: Colors.white, height: 1),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 100),
                                  alignment: Alignment.bottomCenter,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [Colors.black.withOpacity(.6), Colors.black.withOpacity(.2), Colors.black.withOpacity(0)],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl: controller.storeDetails!.avatar.imageUrl,
                                            placeholder: (context, url) => ShimmerEffect.shimmerBox(width: 45, height: 45, borderRaduis: 10),
                                            errorWidget: (context, url, error) => Icon(Icons.error),
                                            imageBuilder: (context, imageProvider) => Container(
                                              width: 45,
                                              height: 45,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border.all(color: Colors.white.withOpacity(.3), width: 2, strokeAlign: StrokeAlign.outside),
                                                color: Colors.grey.shade200,
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          horizontal(10),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                controller.storeDetails!.name,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white.withOpacity(.8),
                                                  height: 1,
                                                ),
                                              ),
                                              vertical(4),
                                              Text(
                                                '5.5 ⭐',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white.withOpacity(.8),
                                                  height: 1,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'المتابعين: 50',
                                            style: TextStyle(color: Colors.white.withOpacity(.8), fontSize: 11, height: 1),
                                          ),
                                          vertical(5),
                                          InkWell(
                                            onTap: () {},
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                                              decoration: BoxDecoration(color: AppLightColor.primaryColor, borderRadius: BorderRadius.circular(10)),
                                              child: Text(
                                                'متابعة',
                                                style: TextStyle(color: Colors.white, fontSize: 12),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SliverPersistentHeader(
                          delegate: AppDelegate(
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
                      children: [
                        Container(),
                        Container(color: Colors.yellow),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}

class AppDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  AppDelegate(this.tabBar);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: tabBar,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
