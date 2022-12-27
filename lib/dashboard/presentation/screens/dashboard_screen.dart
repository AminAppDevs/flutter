import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jdolh_flutter/account/presentation/screens/account_screen.dart';
import 'package:jdolh_flutter/category/presentation/screens/category_screen.dart';
import 'package:jdolh_flutter/core/utils/app_light_color.dart';
import 'package:jdolh_flutter/dashboard/presentation/controller/dashboard_controller.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});
  final DashboardController dashboardController = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
        builder: (controller) => Scaffold(
              body: IndexedStack(
                index: dashboardController.activePage,
                children: [
                  CategoryScreen(),
                  Container(color: Colors.green),
                  CategoryScreen(),
                  Container(color: Colors.blue),
                  Container(color: Colors.teal),
                  AccountScreen(),
                ],
              ),
              bottomNavigationBar: Container(
                height: 75,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.06),
                      blurRadius: 15,
                      offset: const Offset(-5, 0),
                    ),
                  ],
                ),
                child: BottomNavigationBar(
                  backgroundColor: Colors.white,
                  currentIndex: dashboardController.activePage,
                  iconSize: 23,
                  elevation: 0,
                  onTap: (index) {
                    dashboardController.changeActivePage(index);
                    // pageController.jumpToPage(dashboardController.activePage.value);
                  },
                  selectedFontSize: 12,
                  selectedItemColor: AppLightColor.primaryColor,
                  type: BottomNavigationBarType.fixed,
                  unselectedFontSize: 12,
                  unselectedItemColor: AppLightColor.subHeadingColor.withOpacity(.8),
                  items: const [
                    BottomNavigationBarItem(
                      label: 'الرئيسية',
                      icon: Icon(
                        Ionicons.home_outline,
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: 'جدولة',
                      icon: Icon(
                        Ionicons.calendar_outline,
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: 'الحجز',
                      icon: Icon(
                        Ionicons.storefront_outline,
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: 'المناسبات',
                      icon: Icon(
                        Ionicons.people_outline,
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: 'الفواتير',
                      icon: Icon(
                        Ionicons.cash_outline,
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: 'الحساب',
                      icon: Icon(
                        Ionicons.person_outline,
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
