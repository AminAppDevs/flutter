import 'package:image_picker/image_picker.dart';
import 'package:jdolh_flutter/account/data/datasource/base_remote_account_datasource.dart';
import 'package:jdolh_flutter/account/domain/entities/user_details.dart';
import 'package:jdolh_flutter/account/domain/entities/user.dart';
import 'package:jdolh_flutter/account/domain/entities/success.dart';
import 'package:jdolh_flutter/account/domain/entities/group.dart';
import 'package:dartz/dartz.dart';
import 'package:jdolh_flutter/account/domain/repository/base_account_repository.dart';
import 'package:jdolh_flutter/core/error/exceptions.dart';
import 'package:jdolh_flutter/core/error/failure.dart';

class AccountRepository extends BaseAccountRepository {
  final BaseRemoteAccountDataSource baseRemoteAccountDataSource;

  AccountRepository(this.baseRemoteAccountDataSource);
  @override
  Future<Either<Failure, Group>> addUserToGroup(int groupId, int memberId) async {
    try {
      final resul = await baseRemoteAccountDataSource.addUserToGroup(groupId, memberId);
      return Right(resul);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.serverErrorModel.message, e.serverErrorModel.statusCode));
    }
  }

  @override
  Future<Either<Failure, Group>> createGroup(int userId, String name) async {
    try {
      final resul = await baseRemoteAccountDataSource.createGroup(userId, name);
      return Right(resul);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.serverErrorModel.message, e.serverErrorModel.statusCode));
    }
  }

  @override
  Future<Either<Failure, Success>> deleteGroup(int groupId) async {
    try {
      final resul = await baseRemoteAccountDataSource.deleteGroup(groupId);
      return Right(resul);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.serverErrorModel.message, e.serverErrorModel.statusCode));
    }
  }

  @override
  Future<Either<Failure, UserDetails>> getUserDetails(int userId) async {
    try {
      final resul = await baseRemoteAccountDataSource.getUserDetails(userId);
      return Right(resul);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.serverErrorModel.message, e.serverErrorModel.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<User>>> getUserFollowers(int userId) async {
    try {
      final resul = await baseRemoteAccountDataSource.getUserFollowers(userId);
      return Right(resul);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.serverErrorModel.message, e.serverErrorModel.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<User>>> getUserFollowing(int userId) async {
    try {
      final resul = await baseRemoteAccountDataSource.getUserFollowing(userId);
      return Right(resul);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.serverErrorModel.message, e.serverErrorModel.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<Group>>> getUserGroups(int userId) async {
    try {
      final resul = await baseRemoteAccountDataSource.getUserGroups(userId);
      return Right(resul);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.serverErrorModel.message, e.serverErrorModel.statusCode));
    }
  }

  @override
  Future<Either<Failure, Success>> makeFollowUnfollow(int followerId, int followingId) async {
    try {
      final resul = await baseRemoteAccountDataSource.makeFollowUnfollow(followerId, followingId);
      return Right(resul);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.serverErrorModel.message, e.serverErrorModel.statusCode));
    }
  }

  @override
  Future<Either<Failure, Success>> isFollowExist(int followerId, int followingId) async {
    try {
      final result = await baseRemoteAccountDataSource.isFollowExist(followerId, followingId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.serverErrorModel.message, e.serverErrorModel.statusCode));
    }
  }

  @override
  Future<Either<Failure, Group>> removeUserFromGroup(int groupId, int memberId) async {
    try {
      final resul = await baseRemoteAccountDataSource.removeUserFromGroup(groupId, memberId);
      return Right(resul);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.serverErrorModel.message, e.serverErrorModel.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<User>>> syncUserPhoneContacts(List<String> phoneContacts) async {
    try {
      final resul = await baseRemoteAccountDataSource.syncUserPhoneContacts(phoneContacts);
      return Right(resul);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.serverErrorModel.message, e.serverErrorModel.statusCode));
    }
  }

  @override
  Future<Either<Failure, Group>> updateGroup(int groupId, String name) async {
    try {
      final resul = await baseRemoteAccountDataSource.updateGroup(groupId, name);
      return Right(resul);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.serverErrorModel.message, e.serverErrorModel.statusCode));
    }
  }

  @override
  Future<Either<Failure, Success>> updateUserAvatar(XFile? file, int userId) async {
    try {
      final result = await baseRemoteAccountDataSource.updateUserAvatar(file, userId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.serverErrorModel.message, e.serverErrorModel.statusCode));
    }
  }

  @override
  Future<Either<Failure, Success>> updateUserInfo(int userId, Map<String, dynamic> body) async {
    try {
      final result = await baseRemoteAccountDataSource.updateUserInfo(userId, body);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.serverErrorModel.message, e.serverErrorModel.statusCode));
    }
  }
}
