import 'package:dartz/dartz.dart';
import 'package:jdolh_flutter/booking/domain/entities/branch_reservation_day.dart';
import 'package:jdolh_flutter/booking/domain/repository/base_booking_repository.dart';
import 'package:jdolh_flutter/core/error/failure.dart';

class GetBranchReservationDaysUsecase {
  final BaseBookingRepository baseBookingRepository;
  const GetBranchReservationDaysUsecase(this.baseBookingRepository);

  Future<Either<Failure, List<BranchReservationDay>>> call(int branchId) async {
    return await baseBookingRepository.getBranchReservationDays(branchId);
  }
}
