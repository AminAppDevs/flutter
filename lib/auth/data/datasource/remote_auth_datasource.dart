import 'dart:convert';

import 'package:jdolh_flutter/auth/data/models/auth_result_model.dart';
import 'package:http/http.dart' as http;
import 'package:jdolh_flutter/auth/data/models/user_exist_model.dart';
import 'package:jdolh_flutter/core/error/exceptions.dart';
import 'package:jdolh_flutter/core/error/server_error_model.dart';
import 'package:jdolh_flutter/core/utils/api_config.dart';

abstract class BaseRemoteAuthDatasource {
  Future<AuthResultModel> login(String phoneNumber);
  Future<AuthResultModel> register(String phoneNumber, String fullName);
  Future<UserExistModel> checkUserExist(String phoneNumber);
}

class RemoteAuthDatasource extends BaseRemoteAuthDatasource {
  ///// login
  @override
  Future<AuthResultModel> login(String phoneNumber) async {
    const String url = '${ApiConfig.baseUrl}${ApiConfig.login}';

    http.Response response = await http.post(
      Uri.parse(url),
      body: {"phoneNumber": phoneNumber},
    );
    if (response.statusCode == 201) {
      AuthResultModel authResult = AuthResultModel.fromJson(jsonDecode(response.body));
      return authResult;
    } else {
      throw ServerException(ServerErrorModel.fromJson(jsonDecode(response.body)));
    }
  }

///// register
  @override
  Future<AuthResultModel> register(String phoneNumber, String fullName) async {
    const String url = '${ApiConfig.baseUrl}${ApiConfig.register}';
    http.Response response = await http.post(
      Uri.parse(url),
      body: {"fullName": fullName, "phoneNumber": phoneNumber},
    );
    if (response.statusCode == 201) {
      AuthResultModel authResult = AuthResultModel.fromJson(jsonDecode(response.body));
      return authResult;
    } else {
      throw ServerException(ServerErrorModel.fromJson(jsonDecode(response.body)));
    }
  }

///// user exist
  @override
  Future<UserExistModel> checkUserExist(String phoneNumber) async {
    final String url = '${ApiConfig.baseUrl}${ApiConfig.userExist}/$phoneNumber';
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      UserExistModel userExistModel = UserExistModel.fromJson(jsonDecode(response.body));
      return userExistModel;
    } else {
      throw ServerException(ServerErrorModel.fromJson(jsonDecode(response.body)));
    }
  }
}
