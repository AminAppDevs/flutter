import 'package:flutter/material.dart';
import 'package:jdolh_flutter/booking/domain/entities/branch_booking.dart';
import 'package:jdolh_flutter/booking/view/controllers/booking_controller.dart';
import 'package:jdolh_flutter/booking/view/controllers/branch_booking_datasource.dart';
import 'package:jdolh_flutter/core/utils/app_light_color.dart';
import 'package:jdolh_flutter/store/presentation/controller/booking_details_controller.dart';
import 'package:jdolh_flutter/store/presentation/controller/store_controller.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

Container calendarCreateBooking({
  required BuildContext context,
  required List<BranchBookingByDate> datasource,
  required StoreController storeController,
  required BookingController bookingController,
  required BookingDetailsController bookingDetailsController,
}) {
  return Container(
    height: MediaQuery.of(context).size.height * .50,
    child: SfCalendar(
      view: CalendarView.month,
      cellEndPadding: 20,
      dataSource: DataSource(
        datasource,
      ),
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
      monthCellBuilder: (context, details) {
        bool isBookingAvailable = details.appointments.length <=
            storeController.storeDetails!.branches.firstWhere((element) => element.id == bookingDetailsController.selectedBranchId).numberOfTables *
                bookingController.branchReservationDays
                    .firstWhere((element) => element.dayName == getDayName(details.date.weekday))
                    .branchReservationDayTimes
                    .length;
        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isBookingAvailable ? Colors.white : Colors.red.withOpacity(.05),
            border: Border.all(color: Colors.grey.shade100),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                details.date.day.toString(),
                style: TextStyle(
                  fontSize: 13,
                  height: 1,
                  fontWeight: FontWeight.w600,
                  color: isBookingAvailable ? AppLightColor.subHeadingColor : Colors.red,
                ),
              ),
            ],
          ),
        );
      },
      onViewChanged: (viewChangedDetails) {
        bookingController.getBranchBookingByDate(
          1,
          viewChangedDetails.visibleDates.first.toIso8601String() + 'Z',
          viewChangedDetails.visibleDates.last.toIso8601String() + 'Z',
        );
      },
      onSelectionChanged: (calendarSelectionDetails) {
        bookingController.changeSelectedCalenderDay(calendarSelectionDetails.date!);
        print(calendarSelectionDetails.date!.weekday);
        var selectedDay = bookingController.getSelectedBranchDayWithCalendar(calendarSelectionDetails.date!.weekday);
        print(selectedDay);
      },
    ),
  );
}
