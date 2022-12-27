import 'package:image_picker/image_picker.dart';
import 'package:jdolh_flutter/account/data/model/group_model.dart';
import 'package:jdolh_flutter/account/data/model/success_model.dart';
import 'package:jdolh_flutter/account/data/model/user_details_model.dart';
import 'package:jdolh_flutter/account/data/model/user_model.dart';

abstract class BaseRemoteAccountDataSource {
  /// get user details
  Future<UserDetailsModel> getUserDetails(int userId);

  /// update user info
  Future<SuccessModel> updateUserInfo(int userId, Map<String, dynamic> body);

  /// update user avatar
  Future<SuccessModel> updateUserAvatar(XFile? file, int userId);

  /// make follow unfollow
  Future<SuccessModel> makeFollowUnfollow(int followerId, int followingId);

  /// is follow exist
  Future<SuccessModel> isFollowExist(int followerId, int followingId);

  /// get user followers
  Future<List<UserModel>> getUserFollowers(int userId);

  /// get user following
  Future<List<UserModel>> getUserFollowing(int userId);

  /// sync user phone contact
  Future<List<UserModel>> syncUserPhoneContacts(List<String> phoneContacts);

  /// get user groups
  Future<List<GroupModel>> getUserGroups(int userId);

  /// create group
  Future<GroupModel> createGroup(int userId, String name);

  /// update group
  Future<GroupModel> updateGroup(int groupId, String name);

  /// add user to group
  Future<GroupModel> addUserToGroup(int groupId, int memberId);

  /// remove user from group
  Future<GroupModel> removeUserFromGroup(int groupId, int memberId);

  /// delete group
  Future<SuccessModel> deleteGroup(int groupId);
}
