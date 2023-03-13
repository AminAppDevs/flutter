import 'package:equatable/equatable.dart';

class BranchBookingByDate extends Equatable {
  final String date;
  final List<BranchBookingMini> bookings;
  BranchBookingByDate(this.date, this.bookings);

  @override
  List<Object?> get props => [date, bookings];
}

class BranchBookingMini extends Equatable {
  final int id;
  final int storeBranchId;
  final int adminId;
  final String dateOfBooking;
  final int branchReservationDayTimeId;
  BranchBookingMini(this.id, this.storeBranchId, this.adminId, this.dateOfBooking, this.branchReservationDayTimeId);

  @override
  List<Object?> get props => [id, storeBranchId, adminId, dateOfBooking, branchReservationDayTimeId];
}
