import 'package:dartz/dartz.dart';
import 'package:jdolh_flutter/auth/domain/entities/auth_result.dart';
import 'package:jdolh_flutter/auth/domain/repository/base_auth_repository.dart';
import 'package:jdolh_flutter/core/error/failure.dart';

class RegisterUsecase {
  final BaseAuthRepository baseAuthRepository;

  RegisterUsecase(this.baseAuthRepository);

  Future<Either<Failure, AuthResult>> call(String phoneNumber, String fullName, String deviceId) async {
    return await baseAuthRepository.register(phoneNumber, fullName, deviceId);
  }
}
