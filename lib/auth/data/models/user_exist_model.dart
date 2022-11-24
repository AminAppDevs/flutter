import 'package:jdolh_flutter/auth/domain/entities/user_exist.dart';

class UserExistModel extends UserExist {
  const UserExistModel(super.isExist, super.message);

  factory UserExistModel.fromJson(Map<String, dynamic> json) {
    return UserExistModel(json['isExist'], json['message']);
  }
}
