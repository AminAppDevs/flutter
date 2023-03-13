import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jdolh_flutter/booking/domain/entities/branch_booking.dart';
import 'package:jdolh_flutter/booking/domain/entities/branch_reservation_day.dart';
import 'package:jdolh_flutter/booking/view/components/calender_create_booking.dart';
import 'package:jdolh_flutter/booking/view/controllers/booking_controller.dart';
import 'package:jdolh_flutter/core/services/service_locator.dart';
import 'package:jdolh_flutter/core/utils/app_light_color.dart';
import 'package:jdolh_flutter/core/utils/global_utils.dart';
import 'package:jdolh_flutter/store/presentation/controller/booking_details_controller.dart';
import 'package:jdolh_flutter/store/presentation/controller/store_controller.dart';
import 'package:intl/intl.dart';

class SelectBookingDateScreen extends StatelessWidget {
  SelectBookingDateScreen({super.key});

  final BookingController bookingController = Get.find();

  final BookingDetailsController bookingDetailsController = Get.put(BookingDetailsController());
  final StoreController storeController = Get.put(StoreController(sl(), sl(), sl()));

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bookingController.timer!.cancel();
        return await true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('تاريخ ووقت الحجز'),
          centerTitle: true,
        ),
        body: GetBuilder<BookingController>(
          builder: (controller) {
            return controller.isGetBranchReservationDaysLoading
                ? loading(color: AppLightColor.primaryColor)
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        calendarCreateBooking(
                          context: context,
                          bookingController: bookingController,
                          datasource: bookingController.branchBookingsByDates,
                          bookingDetailsController: bookingDetailsController,
                          storeController: storeController,
                        ),
                        Divider(color: AppLightColor.inputBgColor, height: 0, thickness: 1),
                        Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                color: AppLightColor.secondaryColor,
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'اختر وقت الحجز',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.white.withOpacity(.8),
                                        fontWeight: FontWeight.w600,
                                        height: 1.5,
                                      ),
                                    ),
                                    if (bookingController.selectedBranchReservationDay != null)
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                        decoration: BoxDecoration(
                                          color: AppLightColor.primaryColor.withOpacity(.2),
                                          borderRadius: BorderRadius.circular(50),
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              '${bookingController.selectedBranchReservationDay!.dayName}: ',
                                              style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white.withOpacity(.7),
                                              ),
                                            ),
                                            Text(
                                              DateFormat("yyyy-MM-dd").format(DateTime.parse(bookingController.selectedCalenderDay.toString())),
                                              style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white.withOpacity(.7),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              if (bookingController.selectedBranchReservationDay != null)
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5, childAspectRatio: 3.7),
                                    itemCount: bookingController.selectedBranchReservationDay!.branchReservationDayTimes.length,
                                    itemBuilder: (context, index) {
                                      BranchReservationDayTime time =
                                          bookingController.selectedBranchReservationDay!.branchReservationDayTimes[index];
                                      List<BranchBookingByDate> dayBooking = bookingController.branchBookingsByDates
                                          .where((element) => element.date == '${bookingController.selectedCalenderDay.toIso8601String()}Z')
                                          .toList();
                                      print('xxxxxxx ${bookingController.selectedCalenderDay.toIso8601String()}');
                                      int timeBookingsCount = dayBooking.isEmpty
                                          ? 0
                                          : dayBooking[0]
                                              .bookings
                                              .where(
                                                (element) => element.branchReservationDayTimeId == time.id,
                                              )
                                              .toList()
                                              .length;
                                      return InkWell(
                                        onTap: () {
                                          bookingController.changeSelectedReservationDayTimeId(time.id);
                                        },
                                        child: Container(
                                          height: 40,
                                          padding: const EdgeInsets.symmetric(horizontal: 7),
                                          decoration: BoxDecoration(
                                              color: bookingController.selectedimeId == time.id
                                                  ? AppLightColor.primaryColor.withOpacity(.1)
                                                  : AppLightColor.inputBgColor,
                                              borderRadius: BorderRadius.circular(10),
                                              border: Border.all(
                                                color: bookingController.selectedimeId == time.id
                                                    ? AppLightColor.primaryColor.withOpacity(.3)
                                                    : AppLightColor.inputBgColor,
                                              )),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Ionicons.time_outline,
                                                    size: 14,
                                                    color: AppLightColor.subHeadingColor,
                                                  ),
                                                  horizontal(3),
                                                  Text(
                                                    DateFormat('h:mm a')
                                                        .format(DateTime.parse(time.from))
                                                        .replaceAll('AM', 'ص')
                                                        .replaceAll('PM', 'م'),
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight: FontWeight.w600,
                                                      color: AppLightColor.subHeadingColor,
                                                    ),
                                                  ),
                                                  Text('-'),
                                                  Text(
                                                    DateFormat('h:mm a').format(DateTime.parse(time.to)).replaceAll('AM', 'ص').replaceAll('PM', 'م'),
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight: FontWeight.w600,
                                                      color: AppLightColor.subHeadingColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              if (storeController.storeDetails!.branches
                                                      .firstWhere((element) => element.id == bookingDetailsController.selectedBranchId)
                                                      .numberOfTables >
                                                  timeBookingsCount)
                                                Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: Colors.green.shade50,
                                                  ),
                                                  child: Text(
                                                    'متاح',
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      height: 1,
                                                      color: Colors.green,
                                                    ),
                                                  ),
                                                ),
                                              if (storeController.storeDetails!.branches
                                                      .firstWhere((element) => element.id == bookingDetailsController.selectedBranchId)
                                                      .numberOfTables <=
                                                  timeBookingsCount)
                                                Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: Colors.red.shade50,
                                                  ),
                                                  child: Text(
                                                    'غير متاح',
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      height: 1,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
          },
        ),
        bottomNavigationBar: Container(
          height: 55,
          color: AppLightColor.primaryColor,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Ionicons.checkmark_done_outline,
                color: Colors.white,
                size: 20,
              ),
              horizontal(5),
              Text(
                'تأكيد',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
