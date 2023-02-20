import 'package:dartz/dartz.dart';
import 'package:jdolh_flutter/booking/domain/entities/branch_reservation_day.dart';
import 'package:jdolh_flutter/core/error/failure.dart';

abstract class BaseBookingRepository {
  Future<Either<Failure, List<BranchReservationDay>>> getBranchReservationDays(int branchId);
}
