import 'package:jdolh_flutter/account/data/model/image_model.dart';
import 'package:jdolh_flutter/account/domain/entities/user.dart';
import 'package:jdolh_flutter/core/utils/image_placeholder.dart';

class UserModel extends User {
  const UserModel(super.id, super.fullName, super.phoneNumber, super.avatar);

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        json['id'],
        json['fullName'],
        json['phoneNumber'],
        ImageModel.fromJson(json['avatar'] ?? ImagePlaceholder.userAvatar),
      );
}
