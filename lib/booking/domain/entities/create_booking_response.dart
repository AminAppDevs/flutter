import 'package:equatable/equatable.dart';

///// create booking response
class CreateBookingResponse extends Equatable {
  final int id;
  final String dateOfBooking;
  final int branchReservationDayTimeId;
  final String from;
  final String to;
  final int branchReservationDayId;
  final String dayName;
  final int storeBranchId;
  final String storeBranchName;
  final String latitude;
  final String longitude;
  final String neighborhoodId;
  final String neighborhoodName;
  final int cityId;
  final String cityName;

  CreateBookingResponse(
      this.id,
      this.dateOfBooking,
      this.branchReservationDayTimeId,
      this.from,
      this.to,
      this.branchReservationDayId,
      this.dayName,
      this.storeBranchId,
      this.storeBranchName,
      this.latitude,
      this.longitude,
      this.neighborhoodId,
      this.neighborhoodName,
      this.cityId,
      this.cityName);

  @override
  List<Object?> get props => [];
}
