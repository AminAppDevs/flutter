import 'package:flutter/material.dart';
import 'package:jdolh_flutter/booking/domain/entities/branch_booking.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class DataSource extends CalendarDataSource {
  final List<BranchBookingByDate> bookings;

  DataSource(this.bookings);

  @override
  List<Appointment> get appointments {
    List<Appointment> appointmentList = [];
    for (var booking in bookings) {
      var bookingCount = booking.bookings.length;

      // Add regular appointments for dates with 5 or fewer bookings
      for (var bookingMini in booking.bookings) {
        appointmentList.add(_mapBookingMiniToAppointment(bookingMini, booking.date));
      }
    }
    return appointmentList;
  }

  Appointment _mapBookingMiniToAppointment(BranchBookingMini bookingMini, String date) {
    return Appointment(
      startTime: DateTime.parse(date),
      endTime: DateTime.parse(date),
      subject: 'Booking ${bookingMini.id}',
      color: Colors.transparent,
    );
  }
}

String getDayName(int weekDay) {
  switch (weekDay) {
    case 1:
      return 'الأثنين';
    case 2:
      return 'الثلاثاء';
    case 3:
      return 'الأربعاء';
    case 4:
      return 'الخميس';
    case 5:
      return 'الجمعة';
    case 6:
      return 'السبت';
    case 7:
      return 'الأحد';
    default:
      return '';
  }
}
