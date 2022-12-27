import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jdolh_flutter/account/domain/entities/group.dart';
import 'package:jdolh_flutter/account/domain/entities/success.dart';
import 'package:jdolh_flutter/account/domain/entities/user.dart';
import 'package:jdolh_flutter/account/domain/entities/user_details.dart';
import 'package:jdolh_flutter/core/error/failure.dart';

abstract class BaseAccountRepository {
  /// get user details
  Future<Either<Failure, UserDetails>> getUserDetails(int userId);
  Future<Either<Failure, Success>> updateUserInfo(int userId, Map<String, dynamic> body);

  /// update user avatar image
  Future<Either<Failure, Success>> updateUserAvatar(XFile? file, int userId);

  /// make follow unfollow
  Future<Either<Failure, Success>> makeFollowUnfollow(int followerId, int followingId);

  /// is follow exist
  Future<Either<Failure, Success>> isFollowExist(int followerId, int followingId);

  /// get user followers
  Future<Either<Failure, List<User>>> getUserFollowers(int userId);

  /// get user following
  Future<Either<Failure, List<User>>> getUserFollowing(int userId);

  /// sync user phone contact
  Future<Either<Failure, List<User>>> syncUserPhoneContacts(List<String> phoneContacts);

  /// get user groups
  Future<Either<Failure, List<Group>>> getUserGroups(int userId);

  /// create group
  Future<Either<Failure, Group>> createGroup(int userId, String name);

  /// update group
  Future<Either<Failure, Group>> updateGroup(int groupId, String name);

  /// add user to group
  Future<Either<Failure, Group>> addUserToGroup(int groupId, int memberId);

  /// remove user from group
  Future<Either<Failure, Group>> removeUserFromGroup(int groupId, int memberId);

  /// delete group
  Future<Either<Failure, Success>> deleteGroup(int groupId);
}
