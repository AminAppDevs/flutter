import 'package:get/get.dart';

class DashboardController extends GetxController {
  int activePage = 0;

  /// change active page
  changeActivePage(int index) {
    activePage = index;
    update();
  }
}
