import 'package:jdolh_flutter/auth/domain/entities/auth_result.dart';

class AuthResultModel extends AuthResult {
  const AuthResultModel(super.userId, super.token);

  factory AuthResultModel.fromJson(Map<String, dynamic> json) {
    return AuthResultModel(json['userId'], json['token']);
  }
}
