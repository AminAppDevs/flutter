import 'package:jdolh_flutter/auth/data/datasource/local_auth_datasource.dart';
import 'package:jdolh_flutter/auth/data/datasource/remote_auth_datasource.dart';
import 'package:jdolh_flutter/auth/domain/entities/user_exist.dart';
import 'package:jdolh_flutter/auth/domain/entities/auth_result.dart';
import 'package:dartz/dartz.dart';
import 'package:jdolh_flutter/auth/domain/repository/base_auth_repository.dart';
import 'package:jdolh_flutter/core/error/exceptions.dart';
import 'package:jdolh_flutter/core/error/failure.dart';

class AuthRepository extends BaseAuthRepository {
  final BaseRemoteAuthDatasource baseRemoteAuthDatasource;
  final BaseLocalAuthDatasource baseLocalAuthDatasource;

  AuthRepository(this.baseRemoteAuthDatasource, this.baseLocalAuthDatasource);
  ///// user exist
  @override
  Future<Either<Failure, UserExist>> checkUserExist(String phoneNumber) async {
    try {
      final result = await baseRemoteAuthDatasource.checkUserExist(phoneNumber);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.serverErrorModel.message, e.serverErrorModel.statusCode));
    }
  }

///// login
  @override
  Future<Either<Failure, AuthResult>> login(String phoneNumber, String deviceId) async {
    try {
      final result = await baseRemoteAuthDatasource.login(phoneNumber, deviceId: deviceId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.serverErrorModel.message, e.serverErrorModel.statusCode));
    }
  }

///// register
  @override
  Future<Either<Failure, AuthResult>> register(String phoneNumber, String fullName, String deviceId) async {
    try {
      final result = await baseRemoteAuthDatasource.register(phoneNumber, fullName, deviceId: deviceId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.serverErrorModel.message, e.serverErrorModel.statusCode));
    }
  }

  /// local
  @override
  void writeIsLogin(bool isLogin) {
    baseLocalAuthDatasource.writeIsLogin(isLogin: isLogin);
  }

  @override
  bool readIsLogin() {
    return baseLocalAuthDatasource.readIsLogin();
  }

  @override
  void writeUserId(int id) {
    baseLocalAuthDatasource.writeUserId(id);
  }

  @override
  int readUserId() {
    return baseLocalAuthDatasource.readUserId();
  }

  @override
  void writeToken(String token) {
    baseLocalAuthDatasource.writeToken(token);
  }

  @override
  String readToken() {
    return baseLocalAuthDatasource.readToken();
  }
}
