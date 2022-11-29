import 'package:dartz/dartz.dart';
import 'package:jdolh_flutter/account/domain/entities/group.dart';
import 'package:jdolh_flutter/account/domain/entities/success.dart';
import 'package:jdolh_flutter/account/domain/entities/user.dart';
import 'package:jdolh_flutter/account/domain/entities/user_details.dart';
import 'package:jdolh_flutter/account/domain/repository/base_account_repository.dart';
import 'package:jdolh_flutter/core/error/failure.dart';

///// get user details
class GetUserDetailsUsecase {
  final BaseAccountRepository baseAccountRepository;
  const GetUserDetailsUsecase(this.baseAccountRepository);

  Future<Either<Failure, UserDetails>> call(int userId) async {
    return await baseAccountRepository.getUserDetails(userId);
  }
}

///// update user avatar
class UpdateUserAvatarUsecase {
  final BaseAccountRepository baseAccountRepository;
  const UpdateUserAvatarUsecase(this.baseAccountRepository);

  Future<Either<Failure, Success>> call(int userId) async {
    return await baseAccountRepository.updateUserAvatar(userId);
  }
}

///// make follow unfollow
class MakeFollowUnfollowUsecase {
  final BaseAccountRepository baseAccountRepository;
  const MakeFollowUnfollowUsecase(this.baseAccountRepository);

  Future<Either<Failure, Success>> call(int followerId, int followingId) async {
    return await baseAccountRepository.makeFollowUnfollow(followerId, followingId);
  }
}

///// get user followers
class GetUserFollowersUsecase {
  final BaseAccountRepository baseAccountRepository;
  const GetUserFollowersUsecase(this.baseAccountRepository);

  Future<Either<Failure, List<User>>> call(int userId) async {
    return await baseAccountRepository.getUserFollowers(userId);
  }
}

///// get user following
class GetUserFollowingUsecase {
  final BaseAccountRepository baseAccountRepository;
  const GetUserFollowingUsecase(this.baseAccountRepository);

  Future<Either<Failure, List<User>>> call(int userId) async {
    return await baseAccountRepository.getUserFollowing(userId);
  }
}

///// sync user phone contact
class SyncUserPhoneContactsUsecase {
  final BaseAccountRepository baseAccountRepository;
  const SyncUserPhoneContactsUsecase(this.baseAccountRepository);

  Future<Either<Failure, List<User>>> call(List<String> phoneContacts) async {
    return await baseAccountRepository.syncUserPhoneContacts(phoneContacts);
  }
}

///// get user groups
class GetUserGroupsUsecase {
  final BaseAccountRepository baseAccountRepository;
  const GetUserGroupsUsecase(this.baseAccountRepository);

  Future<Either<Failure, List<Group>>> call(int userId) async {
    return await baseAccountRepository.getUserGroups(userId);
  }
}

///// create group
class CreateGroupUsecase {
  final BaseAccountRepository baseAccountRepository;
  const CreateGroupUsecase(this.baseAccountRepository);

  Future<Either<Failure, Group>> call(int userId, String name) async {
    return await baseAccountRepository.createGroup(userId, name);
  }
}

////// update group
class UpdateGroupUsecase {
  final BaseAccountRepository baseAccountRepository;
  const UpdateGroupUsecase(this.baseAccountRepository);

  Future<Either<Failure, Group>> call(int groupId, String name) async {
    return await baseAccountRepository.updateGroup(groupId, name);
  }
}

////// add user to group
class AddUserToGroupUsecase {
  final BaseAccountRepository baseAccountRepository;
  const AddUserToGroupUsecase(this.baseAccountRepository);

  Future<Either<Failure, Group>> call(int groupId, int memberId) async {
    return await baseAccountRepository.addUserToGroup(groupId, memberId);
  }
}

///// remove user from group
class RemoveUserFromGroupUsecase {
  final BaseAccountRepository baseAccountRepository;
  const RemoveUserFromGroupUsecase(this.baseAccountRepository);

  Future<Either<Failure, Group>> call(int groupId, int memberId) async {
    return await baseAccountRepository.removeUserFromGroup(groupId, memberId);
  }
}

///// delete group
class DeleteGroupUsecase {
  final BaseAccountRepository baseAccountRepository;
  const DeleteGroupUsecase(this.baseAccountRepository);

  Future<Either<Failure, Success>> call(int groupId) async {
    return await baseAccountRepository.deleteGroup(groupId);
  }
}
