import 'package:dartz/dartz.dart';
import 'package:jdolh_flutter/auth/domain/entities/auth_result.dart';
import 'package:jdolh_flutter/auth/domain/entities/user_exist.dart';
import 'package:jdolh_flutter/core/error/failure.dart';

abstract class BaseAuthRepository {
  Future<Either<Failure, AuthResult>> login(String phoneNumber);
  Future<Either<Failure, AuthResult>> register(String phoneNumber, String fullName);
  Future<Either<Failure, UserExist>> checkUserExist(String phoneNumber);
}
