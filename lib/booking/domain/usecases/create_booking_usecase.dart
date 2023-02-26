import 'package:dartz/dartz.dart';
import 'package:jdolh_flutter/booking/data/model/create_booking_model.dart';
import 'package:jdolh_flutter/booking/domain/entities/create_booking_response.dart';
import 'package:jdolh_flutter/booking/domain/repository/base_booking_repository.dart';
import 'package:jdolh_flutter/core/error/failure.dart';

class CreateBookingUsecase {
  final BaseBookingRepository baseBookingRepository;
  const CreateBookingUsecase(this.baseBookingRepository);

  Future<Either<Failure, CreateBookingResponse>> call(CreateBookingModel createBooking) async {
    return await baseBookingRepository.createBooking(createBooking);
  }
}
