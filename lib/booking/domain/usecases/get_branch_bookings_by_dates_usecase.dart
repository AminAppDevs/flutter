import 'package:dartz/dartz.dart';
import 'package:jdolh_flutter/booking/domain/entities/branch_booking.dart';
import 'package:jdolh_flutter/booking/domain/repository/base_booking_repository.dart';
import 'package:jdolh_flutter/core/error/failure.dart';

class GetBranchBookingByDatesUsecase {
  final BaseBookingRepository baseBookingRepository;
  const GetBranchBookingByDatesUsecase(this.baseBookingRepository);

  Future<Either<Failure, List<BranchBookingByDate>>> call(int branchId, String fromDate, String toDate) async {
    return await baseBookingRepository.getBranchBookingByDates(branchId, fromDate, toDate);
  }
}
