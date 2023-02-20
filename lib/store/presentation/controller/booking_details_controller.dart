import 'package:map_launcher/map_launcher.dart';
import 'package:get/get.dart';
import 'package:jdolh_flutter/account/domain/entities/user.dart';

class BookingDetailsController extends GetxController {
  int selectedBranchId = 0;
  String selectedBranchName = '';
  int seatNumber = 0;
  String bookingTime = '';
  List<User> bookingMembers = [];

  //// get address from coordination
  openBranchAddressOnGoogleMap({required String latitude, required String longitude}) async {
    final availableMaps = await MapLauncher.installedMaps;
    await availableMaps.first.showMarker(
      coords: Coords(double.parse(latitude), double.parse(longitude)),
      title: "Jdolh",
    );
  }

  changeSelectedBranch({required int id, required String name}) {
    selectedBranchId = id;
    selectedBranchName = name;
    update();
  }
}
