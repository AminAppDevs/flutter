import 'package:dartz/dartz.dart';
import 'package:jdolh_flutter/booking/data/datasource/base_remote_booking_datasource.dart';
import 'package:jdolh_flutter/booking/data/model/create_booking_model.dart';
import 'package:jdolh_flutter/booking/domain/entities/branch_reservation_day.dart';
import 'package:jdolh_flutter/booking/domain/entities/create_booking_response.dart';
import 'package:jdolh_flutter/booking/domain/repository/base_booking_repository.dart';
import 'package:jdolh_flutter/core/error/exceptions.dart';
import 'package:jdolh_flutter/core/error/failure.dart';

class BookingRepository extends BaseBookingRepository {
  final BaseRemoteBookingDatasource baseRemoteBookingDatasource;
  BookingRepository(this.baseRemoteBookingDatasource);

  ///// get branch reservation days
  @override
  Future<Either<Failure, List<BranchReservationDay>>> getBranchReservationDays(int branchId) async {
    final result = await baseRemoteBookingDatasource.getBranchReservationDays(branchId);
    try {
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.serverErrorModel.message, e.serverErrorModel.statusCode));
    }
  }

///// create booking
  @override
  Future<Either<Failure, CreateBookingResponse>> createBooking(CreateBookingModel createBooking) async {
    final result = await baseRemoteBookingDatasource.createBooking(createBooking);
    try {
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.serverErrorModel.message, e.serverErrorModel.statusCode));
    }
  }
}
