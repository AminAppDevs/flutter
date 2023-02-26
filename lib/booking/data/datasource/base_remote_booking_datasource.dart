import 'package:jdolh_flutter/booking/data/model/branch_reservation_day_model.dart';
import 'package:jdolh_flutter/booking/data/model/create_booking_model.dart';
import 'package:jdolh_flutter/booking/data/model/create_booking_response_model.dart';

abstract class BaseRemoteBookingDatasource {
  Future<List<BranchReservationDayModel>> getBranchReservationDays(int branchId);
  Future<CreateBookingResponseModel> createBooking(CreateBookingModel createBooking);
}
