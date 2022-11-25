import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jdolh_flutter/auth/presentation/controller/auth_controller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});
  final AuthController authController = Get.find();

  Future getPosition() async {
    bool services = await Geolocator.isLocationServiceEnabled();
    print(services);
    if (!services) {
      /// open location
    } else {
      LocationPermission permission = await Geolocator.checkPermission();
      print(permission);
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
        Position position = await getLatLang();
        print(position.latitude);
        print(position.longitude);
        List<Placemark> placeMarks = await placemarkFromCoordinates(position.latitude, position.longitude);
        print(placeMarks[0]);
      }
    }
  }

  Future<Position> getLatLang() async {
    return await Geolocator.getCurrentPosition().then((value) => value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              await getPosition();
            },
            child: Icon(Ionicons.download_outline),
          ),
        ],
      )),
    );
  }
}
