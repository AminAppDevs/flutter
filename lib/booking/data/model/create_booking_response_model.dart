import 'package:jdolh_flutter/booking/domain/entities/create_booking_response.dart';

///// CreateBookingResponseModel
class CreateBookingResponseModel extends CreateBookingResponse {
  CreateBookingResponseModel(
    super.id,
    super.dateOfBooking,
    super.branchReservationDayTimeId,
    super.from,
    super.to,
    super.branchReservationDayId,
    super.dayName,
    super.storeBranchId,
    super.storeBranchName,
    super.latitude,
    super.longitude,
    super.neighborhoodId,
    super.neighborhoodName,
    super.cityId,
    super.cityName,
  );

  factory CreateBookingResponseModel.fromJson(Map<String, dynamic> json) => CreateBookingResponseModel(
        json['id'],
        json['dateOfBooking'],
        json['branchReservationDayTimeId'],
        json['from'],
        json['to'],
        json['branchReservationDayId'],
        json['dayName'],
        json['storeBranchId'],
        json['storeBranchName'],
        json['latitude'],
        json['longitude'],
        json['neighborhoodId'],
        json['neighborhoodName'],
        json['cityId'],
        json['cityName'],
      );
}
