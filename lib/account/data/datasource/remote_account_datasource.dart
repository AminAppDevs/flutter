import 'dart:convert';

import 'package:jdolh_flutter/account/data/datasource/base_remote_account_datasource.dart';
import 'package:jdolh_flutter/account/data/model/user_model.dart';
import 'package:jdolh_flutter/account/data/model/user_details_model.dart';
import 'package:jdolh_flutter/account/data/model/success_model.dart';
import 'package:jdolh_flutter/account/data/model/group_model.dart';
import 'package:http/http.dart' as http;
import 'package:jdolh_flutter/auth/presentation/controller/auth_controller.dart';
import 'package:jdolh_flutter/core/error/exceptions.dart';
import 'package:jdolh_flutter/core/error/server_error_model.dart';
import 'package:jdolh_flutter/core/services/service_locator.dart';
import 'package:jdolh_flutter/core/utils/api_config.dart';

class RemoteAccountDatasource extends BaseRemoteAccountDataSource {
  final String token = AuthController(sl(), sl(), sl(), sl()).localAuthUsecases.readToken();
///// update user info
  ///get user details
  @override
  Future<UserDetailsModel> getUserDetails(int userId) async {
    final String url = '${ApiConfig.baseUrl}${ApiConfig.userDetails}/$userId';
    http.Response response = await http.get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      return UserDetailsModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException(ServerErrorModel.fromJson(jsonDecode(response.body)));
    }
  }

  /// update user avatar
  @override
  Future<SuccessModel> updateUserAvatar(int userId) async {
    throw UnimplementedError();
  }

///// groups
  ///get user groups
  @override
  Future<List<GroupModel>> getUserGroups(int userId) async {
    final String url = '${ApiConfig.baseUrl}${ApiConfig.getUserGroups}/$userId';
    http.Response response = await http.get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List).map((e) => GroupModel.fromJson(e)).toList();
    } else {
      throw ServerException(ServerErrorModel.fromJson(jsonDecode(response.body)));
    }
  }

  /// create group
  @override
  Future<GroupModel> createGroup(int userId, String name) async {
    final String url = '${ApiConfig.baseUrl}${ApiConfig.createGroup}';
    http.Response response = await http.post(
      Uri.parse(url),
      body: {"userId": userId, "name": name},
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 201) {
      return GroupModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException(ServerErrorModel.fromJson(jsonDecode(response.body)));
    }
  }

  /// update group
  @override
  Future<GroupModel> updateGroup(int groupId, String name) async {
    final String url = '${ApiConfig.baseUrl}${ApiConfig.updateGroup}';
    http.Response response = await http.patch(
      Uri.parse(url),
      body: {"groupId": groupId, "name": name},
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      return GroupModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException(ServerErrorModel.fromJson(jsonDecode(response.body)));
    }
  }

  /// add user to group
  @override
  Future<GroupModel> addUserToGroup(int groupId, int memberId) async {
    final String url = '${ApiConfig.baseUrl}${ApiConfig.addUserToGroup}';
    http.Response response = await http.patch(
      Uri.parse(url),
      body: {"groupId": groupId, "memberId": memberId},
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      return GroupModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException(ServerErrorModel.fromJson(jsonDecode(response.body)));
    }
  }

  /// remove user from group
  @override
  Future<GroupModel> removeUserFromGroup(int groupId, int memberId) async {
    final String url = '${ApiConfig.baseUrl}${ApiConfig.removeUserFromGroup}';
    http.Response response = await http.patch(
      Uri.parse(url),
      body: {"groupId": groupId, "memberId": memberId},
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      return GroupModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException(ServerErrorModel.fromJson(jsonDecode(response.body)));
    }
  }

  /// delete group
  @override
  Future<SuccessModel> deleteGroup(int groupId) async {
    final String url = '${ApiConfig.baseUrl}${ApiConfig.deleteGroup}/$groupId';
    http.Response response = await http.delete(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      return SuccessModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException(ServerErrorModel.fromJson(jsonDecode(response.body)));
    }
  }

///// follows
  /// make follow unfollow
  @override
  Future<SuccessModel> makeFollowUnfollow(int followerId, int followingId) async {
    final String url = '${ApiConfig.baseUrl}${ApiConfig.makeFollowUnfollow}';
    http.Response response = await http.post(
      Uri.parse(url),
      body: {"followerId": followerId, "followingId": followingId},
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 201) {
      return SuccessModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException(ServerErrorModel.fromJson(jsonDecode(response.body)));
    }
  }

  /// get user follower
  @override
  Future<List<UserModel>> getUserFollowers(int userId) async {
    final String url = '${ApiConfig.baseUrl}${ApiConfig.getUserFollower}/$userId';
    http.Response response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List).map((e) => UserModel.fromJson(e)).toList();
    } else {
      throw ServerException(ServerErrorModel.fromJson(jsonDecode(response.body)));
    }
  }

  /// get user following
  @override
  Future<List<UserModel>> getUserFollowing(int userId) async {
    final String url = '${ApiConfig.baseUrl}${ApiConfig.getUserFollowing}/$userId';
    http.Response response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List).map((e) => UserModel.fromJson(e)).toList();
    } else {
      throw ServerException(ServerErrorModel.fromJson(jsonDecode(response.body)));
    }
  }

  /// sync user phone contacts
  @override
  Future<List<UserModel>> syncUserPhoneContacts(List<String> phoneContacts) async {
    final String url = '${ApiConfig.baseUrl}${ApiConfig.syncUserPhoneContacts}';
    http.Response response = await http.post(
      Uri.parse(url),
      body: {"phoneContacts": json.encode(phoneContacts)},
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List).map((e) => UserModel.fromJson(e)).toList();
    } else {
      throw ServerException(ServerErrorModel.fromJson(jsonDecode(response.body)));
    }
  }
}
