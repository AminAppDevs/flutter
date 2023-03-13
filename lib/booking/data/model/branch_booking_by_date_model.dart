import 'package:jdolh_flutter/booking/domain/entities/branch_booking.dart';

class BranchBookingByDateModel extends BranchBookingByDate {
  BranchBookingByDateModel(super.date, super.bookings);

  factory BranchBookingByDateModel.fromJson(Map<String, dynamic> json) =>
      BranchBookingByDateModel(json['date'], (json['bookings'] as List).map((e) => BranchBookingMiniModel.fromJson(e)).toList());
}

class BranchBookingMiniModel extends BranchBookingMini {
  BranchBookingMiniModel(super.id, super.storeBranchId, super.adminId, super.dateOfBooking, super.branchReservationDayTimeId);

  factory BranchBookingMiniModel.fromJson(Map<String, dynamic> json) => BranchBookingMiniModel(
        json['id'],
        json['storeBranchId'],
        json['adminId'],
        json['dateOfBooking'],
        json['branchReservationDayTimeId'],
      );
}
