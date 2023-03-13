import 'package:dartz/dartz.dart';
import 'package:jdolh_flutter/auth/domain/entities/auth_result.dart';
import 'package:jdolh_flutter/auth/domain/entities/user_exist.dart';
import 'package:jdolh_flutter/core/error/failure.dart';

abstract class BaseAuthRepository {
  ///// remote
  Future<Either<Failure, AuthResult>> login(String phoneNumber, String deviceId);
  Future<Either<Failure, AuthResult>> register(String phoneNumber, String fullName, String deviceId);
  Future<Either<Failure, UserExist>> checkUserExist(String phoneNumber);

  ///// local
  void writeIsLogin(bool isLogin);
  bool readIsLogin();
  void writeUserId(int id);
  int readUserId();
  void writeToken(String token);
  String readToken();
}