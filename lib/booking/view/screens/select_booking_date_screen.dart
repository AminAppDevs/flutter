import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jdolh_flutter/booking/domain/entities/branch_reservation_day.dart';
import 'package:jdolh_flutter/booking/view/controllers/booking_controller.dart';
import 'package:jdolh_flutter/core/utils/app_light_color.dart';
import 'package:jdolh_flutter/core/utils/global_utils.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';

class SelectBookingDateScreen extends StatelessWidget {
  SelectBookingDateScreen({super.key});
  final BookingController bookingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تاريخ ووقت الحجز'),
        centerTitle: true,
      ),
      body: GetBuilder<BookingController>(
        builder: (controller) {
          return controller.isGetBranchReservationDaysLoading
              ? loading(color: AppLightColor.primaryColor)
              : Column(
                  children: [
                    Expanded(
                      child: SfCalendar(
                        view: CalendarView.month,
                        initialDisplayDate: DateTime.now(),
                        cellBorderColor: Colors.grey.shade100,
                        todayHighlightColor: AppLightColor.primaryColor,
                        appointmentTextStyle: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 15,
                          color: AppLightColor.headingColor,
                          fontWeight: FontWeight.w600,
                        ),
                        selectionDecoration: BoxDecoration(
                          border: Border.all(color: AppLightColor.primaryColor),
                        ),
                        minDate: DateTime.now(),
                        maxDate: DateTime.now().add(Duration(days: 30 * 3)),
                        showNavigationArrow: true,
                        firstDayOfWeek: 6,
                        headerStyle: CalendarHeaderStyle(
                          textStyle: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 15,
                            color: AppLightColor.headingColor,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                          backgroundColor: Colors.grey.shade50,
                        ),
                        viewHeaderStyle: ViewHeaderStyle(
                          dayTextStyle: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: AppLightColor.subHeadingColor,
                            fontFamily: 'Cairo',
                          ),
                        ),
                        onViewChanged: (viewChangedDetails) {
                          print(viewChangedDetails.visibleDates.first);
                          print(viewChangedDetails.visibleDates.last);
                        },
                        onSelectionChanged: (calendarSelectionDetails) {
                          bookingController.changeSelectedCalenderDay(calendarSelectionDetails.date!);
                          print(calendarSelectionDetails.date!.weekday);
                          var selectedDay = bookingController.getSelectedBranchDayWithCalendar(calendarSelectionDetails.date!.weekday);
                          print(selectedDay);
                        },
                      ),
                    ),
                    Divider(color: AppLightColor.inputBgColor, height: 0, thickness: 1),
                    Container(
                      height: 320,
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
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5, childAspectRatio: 4),
                                itemCount: bookingController.selectedBranchReservationDay!.branchReservationDayTimes.length,
                                itemBuilder: (context, index) {
                                  BranchReservationDayTime time = bookingController.selectedBranchReservationDay!.branchReservationDayTimes[index];
                                  return InkWell(
                                    onTap: () {
                                      bookingController.changeSelectedReservationDayTimeId(time.id);
                                    },
                                    child: Container(
                                      height: 40,
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
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Ionicons.time_outline,
                                            size: 16,
                                            color: AppLightColor.subHeadingColor,
                                          ),
                                          horizontal(3),
                                          Text(
                                            DateFormat('h:mm a').format(DateTime.parse(time.from)).replaceAll('AM', 'ص').replaceAll('PM', 'م'),
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: AppLightColor.subHeadingColor,
                                            ),
                                          ),
                                          Text(' - '),
                                          Text(
                                            DateFormat('h:mm a').format(DateTime.parse(time.to)).replaceAll('AM', 'ص').replaceAll('PM', 'م'),
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: AppLightColor.subHeadingColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                        ],
                      ),
                    ),
                  ],
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
    );
  }
}
