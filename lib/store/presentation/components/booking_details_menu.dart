import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_flutter/store/presentation/components/booking_details/branch_seat_time_booking.dart';
import 'package:jdolh_flutter/store/presentation/controller/booking_details_controller.dart';
import 'package:jdolh_flutter/store/presentation/controller/store_controller.dart';

class BookingDetailsMenu extends StatelessWidget {
  BookingDetailsMenu({super.key});
  final StoreController storeController = Get.find();
  final BookingDetailsController bookingDetailsController = Get.put(BookingDetailsController());
  final TextEditingController seatNumberController = TextEditingController();
  final bookingDetailsFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Form(
            key: bookingDetailsFormKey,
            child: Column(
              children: [
                branchSeatTimeBooking(
                  bookingDetailsController: bookingDetailsController,
                  storeController: storeController,
                  seatNumberController: seatNumberController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
