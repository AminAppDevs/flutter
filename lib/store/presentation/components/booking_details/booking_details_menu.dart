import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_flutter/booking/view/controllers/booking_controller.dart';
import 'package:jdolh_flutter/core/services/service_locator.dart';
import 'package:jdolh_flutter/core/utils/app_light_color.dart';
import 'package:jdolh_flutter/store/presentation/components/booking_details/branch_seat_time_booking.dart';
import 'package:jdolh_flutter/store/presentation/controller/booking_details_controller.dart';
import 'package:jdolh_flutter/store/presentation/controller/cart_controller.dart';
import 'package:jdolh_flutter/store/presentation/controller/store_controller.dart';

class BookingDetailsMenu extends StatelessWidget {
  BookingDetailsMenu({super.key});
  final StoreController storeController = Get.find();
  final CartController cartController = Get.put(CartController());
  final BookingDetailsController bookingDetailsController = Get.put(BookingDetailsController());
  final TextEditingController seatNumberController = TextEditingController();
  final BookingController bookingController = Get.put(BookingController(sl(), sl()));
  final bookingDetailsFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
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
                    bookingController: bookingController,
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: InkWell(
          onTap: () {
            bookingController.createBooking(
              cart: cartController.cart,
              branchReservationDayTimeId: 1,
              numberOfSeats: 5,
              storeBranchId: bookingDetailsController.selectedBranchId,
            );
          },
          child: Container(
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppLightColor.primaryColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'تأكيد الحجز',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
