import 'package:dartz/dartz.dart';
import 'package:jdolh_flutter/auth/domain/entities/user_exist.dart';
import 'package:jdolh_flutter/auth/domain/repository/base_auth_repository.dart';
import 'package:jdolh_flutter/core/error/failure.dart';

class UserExistUsecase {
  final BaseAuthRepository baseAuthRepository;

  UserExistUsecase(this.baseAuthRepository);

  Future<Either<Failure, UserExist>> call(String phoneNumber) async {
    return await baseAuthRepository.checkUserExist(phoneNumber);
  }
}
