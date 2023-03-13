import 'package:dartz/dartz.dart';
import 'package:jdolh_flutter/booking/data/model/create_booking_model.dart';
import 'package:jdolh_flutter/booking/domain/entities/branch_booking.dart';
import 'package:jdolh_flutter/booking/domain/entities/branch_reservation_day.dart';
import 'package:jdolh_flutter/booking/domain/entities/create_booking_response.dart';
import 'package:jdolh_flutter/core/error/failure.dart';

abstract class BaseBookingRepository {
  Future<Either<Failure, List<BranchReservationDay>>> getBranchReservationDays(int branchId);
  Future<Either<Failure, List<BranchBookingByDate>>> getBranchBookingByDates(int branchId, String fromDate, String toDate);
  Future<Either<Failure, CreateBookingResponse>> createBooking(CreateBookingModel createBooking);
}
