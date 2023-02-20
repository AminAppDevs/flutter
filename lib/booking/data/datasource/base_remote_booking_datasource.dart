import 'package:jdolh_flutter/booking/data/model/branch_reservation_day_model.dart';

abstract class BaseRemoteBookingDatasource {
  Future<List<BranchReservationDayModel>> getBranchReservationDays(int branchId);
}
