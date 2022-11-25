import 'package:dartz/dartz.dart';
import 'package:jdolh_flutter/auth/domain/entities/auth_result.dart';
import 'package:jdolh_flutter/auth/domain/repository/base_auth_repository.dart';
import 'package:jdolh_flutter/core/error/failure.dart';

class LoginUsecase {
  final BaseAuthRepository baseAuthRepository;

  LoginUsecase(this.baseAuthRepository);

  Future<Either<Failure, AuthResult>> call(String phoneNumber, String deviceId) async {
    return await baseAuthRepository.login(phoneNumber, deviceId);
  }
}
